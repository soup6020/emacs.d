;; use-package with Elpaca:
(use-package dashboard
  :ensure t
  :demand t
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

;; Set the title
(setq dashboard-banner-logo-title "Emacs-pgtk on NixOS Unstable")
;; Icons
(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
;; Set the banner
(setq dashboard-startup-banner 3)
;; Value can be:
;;  - 'official which displays the official emacs logo.
;;  - 'logo which displays an alternative emacs logo.
;;  - an integer which displays one of the text banners
;;    (see dashboard-banners-directory files).
;;  - a string that specifies a path for a custom banner
;;    currently supported types are gif/image/text/xbm.
;;  - a cons of 2 strings which specifies the path of an image to use
;;    and other path of a text file to use if image isn't supported.
;;    (cons "path/to/image/file/image.png" "path/to/text/file/text.txt").
;;  - a list that can display an random banner,
;;    supported values are: string (filepath), 'official, 'logo and integers.

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
;; vertically center content
(setq dashboard-vertically-center-content t)

;;Projectile projects
(setq dashboard-projects-backend 'projectile)  
;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)))

(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-newline
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer))

(provide 'init-dashboard)
