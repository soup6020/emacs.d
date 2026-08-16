;;; init-tabbar.el --- -*- lexical-binding: t; -*-
;; The built-in tab-bar: frame-level tabs, each holding a window
;; configuration, with nerd-icons for the tab, the close button and the
;; new-tab button.
;;
;; Tab colors need no configuration.  doom-themes styles `tab-bar',
;; `tab-bar-tab' and `tab-bar-tab-inactive' as inherits of the corresponding
;; tab-line faces, so the bar already follows whatever theme init-themes
;; loads.  The new-tab button is the one exception; see the face below.
;;
;; Visibility needs no configuration either: `tab-bar-show' defaults to t,
;; which `tab-bar--tab-bar-lines-for-frame' maps to a permanently visible bar
;; once `tab-bar-mode' is on, including when only one tab exists.

(defface soup6020/tab-bar-button '((t :inherit tab-bar))
  "Face for the tab-bar's new-tab button.
Distinct from `tab-bar' only so `soup6020/tab-bar-button-sync' can give it a
readable foreground on themes that need one.")

(defun soup6020/tab-bar-button-sync (&rest _)
  "Ensure the new-tab button is legible under the current theme.
`tab-bar-format-add-tab' emits the button with no face of its own, so it
renders in the `tab-bar' face.  doom-themes sets that face's foreground
equal to its background, leaving the button invisible but still clickable.
Correct the foreground only when the two really do match, so themes that
already render it — ef-themes among them — are left alone."
  (let ((fg (face-attribute 'tab-bar :foreground nil 'default))
        (bg (face-attribute 'tab-bar :background nil 'default)))
    (set-face-attribute
     'soup6020/tab-bar-button nil
     :foreground (if (equal fg bg)
                     ;; Readable against the bar by construction, and unlike
                     ;; inheriting the whole face this borrows no background
                     ;; or box from it.
                     (face-attribute 'tab-bar-tab-inactive :foreground nil 'default)
                   'unspecified))))

(defun soup6020/tab-bar-icon (buffer)
  "Return a nerd-icons filetype icon for BUFFER, or nil if unavailable."
  (when (require 'nerd-icons nil t)
    (let ((icon (with-current-buffer buffer
                  (if buffer-file-name
                      (nerd-icons-icon-for-file buffer-file-name)
                    (nerd-icons-icon-for-mode major-mode)))))
      ;; Both lookups fall back to a generic icon, but guard anyway so a
      ;; missing entry can never put a symbol into the tab bar.
      (and (stringp icon) icon))))

(defun soup6020/tab-bar-tab-name ()
  "Name the current tab after its buffer, prefixed with a filetype icon.
Only the current tab's name is recomputed on redisplay, by `tab-bar-tabs';
the others keep the name they held when you last left them, which is what
makes each tab remember its own buffer."
  ;; Window choice mirrors `tab-bar-tab-name-current': the minibuffer loses
  ;; its original window after switching tabs while it was active.  A nil
  ;; window here means `window-buffer' falls back to the selected window.
  (let* ((window (or (minibuffer-selected-window)
                     (and (window-minibuffer-p) (get-mru-window))))
         (buffer (window-buffer window))
         (icon (soup6020/tab-bar-icon buffer)))
    ;; `tab-bar-tab-name-format-face' appends the tab's face rather than
    ;; overwriting it, so the icon keeps its own font family and color while
    ;; the tab face still supplies the background.
    (concat (and icon (concat icon " ")) (buffer-name buffer))))

(defun soup6020/tab-bar-setup-buttons ()
  "Replace the tab-bar's new-tab and close buttons with nerd-icons glyphs.
Setting `tab-bar-new-button' and `tab-bar-close-button' directly does not
last: `tab-bar--load-buttons' rebuilds both from the `icons' framework every
time `tab-bar-mode' is enabled.  Registering our own icons is the supported
way in, and it takes precedence because that function only defines the
built-in icons `unless' one is already registered."
  (when (require 'nerd-icons nil t)
    (require 'icons)
    ;; The face goes through nerd-icons rather than the spec's own :face
    ;; keyword, which `icon-string' applies with `propertize' — that would
    ;; overwrite the font family the glyph needs to render at all.  Passing
    ;; :face here instead adds an :inherit alongside the family.
    (define-icon tab-bar-new nil
      `((text ,(concat " " (nerd-icons-mdicon "nf-md-plus_circle"
                                              :face 'soup6020/tab-bar-button)
                       " ")))
      "Icon for creating a new tab."
      :version "29.1"
      :help-echo "New tab")
    ;; The close button is concatenated into the tab name, which then gets
    ;; `tab-bar-tab' or `tab-bar-tab-inactive' appended, so it is legible
    ;; already and needs no face of its own.
    (define-icon tab-bar-close nil
      `((text ,(concat " " (nerd-icons-mdicon "nf-md-close_circle"))))
      "Icon for closing the clicked tab."
      :version "29.1"
      :help-echo "Click to close tab")
    ;; Mirrors what `tab-bar--load-buttons' does, for the case where
    ;; `tab-bar-mode' was already enabled before these icons existed.
    (setq tab-bar-new-button (icon-string 'tab-bar-new)
          tab-bar-close-button (propertize (icon-string 'tab-bar-close)
                                           'close-tab t))
    (force-mode-line-update t)))

(use-package tab-bar
  :ensure nil ; built in
  :demand t
  :config
  ;; setopt rather than setq: several tab-bar options only take effect through
  ;; their :set functions, which refresh the bar on frames that already exist.
  (setopt tab-bar-tab-name-function #'soup6020/tab-bar-tab-name)

  ;; nerd-icons is installed by elpaca, which has not put it on `load-path'
  ;; by the time this file is required, so the buttons wait for the queue.
  (add-hook 'elpaca-after-init-hook #'soup6020/tab-bar-setup-buttons)

  (soup6020/tab-bar-button-sync)
  (add-hook 'enable-theme-functions #'soup6020/tab-bar-button-sync)
  ;; Under a daemon the first real frame appears long after this runs, and a
  ;; tty frame can resolve these faces to different colors than a graphical
  ;; one, so re-check per frame.
  (add-hook 'server-after-make-frame-hook #'soup6020/tab-bar-button-sync)
  (add-hook 'after-make-frame-functions #'soup6020/tab-bar-button-sync)

  (tab-bar-mode 1))

(provide 'init-tabbar)
