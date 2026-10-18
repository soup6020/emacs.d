;;; init-evil.el --- -*- lexical-binding: t; -*-
;; Evil mode
(use-package evil
  :ensure t
  :demand t ; No lazy loading
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-fu)
  :config (evil-mode 1)
  (evil-define-command my/evil-quit-tab (&optional force)
    "Close the current tab, or quit normally if it's the only one."
    :repeat nil
    (interactive "<!>")
    (if (> (length (tab-bar-tabs)) 1)
        (tab-bar-close-tab)
      (evil-quit force)))

  (evil-define-command my/evil-save-and-quit-tab ()
    "Save the buffer, then close the current tab."
    :repeat nil
    (save-buffer)
    (my/evil-quit-tab))

  (evil-ex-define-cmd "q[uit]" #'my/evil-quit-tab)
  (evil-ex-define-cmd "wq" #'my/evil-save-and-quit-tab))

;; TODO: Move this somewhere more fitting, undo is not explicitly an evil thing
(use-package undo-fu
  :ensure t)

(use-package vundo
  :ensure t
  :commands (vundo)
  :hook (prog-mode . vundo-popup-mode)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :demand t
  :config (evil-collection-init))

(provide 'init-evil)
