;;; init-themes.el --- -*- lexical-binding: t; -*-
;; Install themes

(use-package nerd-icons
  :ensure t
  :config
  ;; The default "Symbols Nerd Font Mono" is not installed here.  Our default
  ;; font is itself a patched Nerd Font and carries the same glyphs, so point
  ;; nerd-icons at it rather than relying on font fallback to find them.
  (setopt nerd-icons-font-family "Lilex Nerd Font Mono"))

(use-package kanagawa-themes
  :ensure t
  :demand t
  :config
  ;;   (load-theme 'kanagawa-wave t))
  )

(use-package ef-themes
  :ensure t
  :demand t
  :config
  ;; (load-theme 'ef-night t)
  )

(use-package tron-legacy-theme
  :ensure t
  ;;:config
  ;;(load-theme 'tron-legacy t)
  )

(use-package doom-themes
  :ensure t
  :demand t
  :config
  ;; Work-around for a weird bug that prevents themes being applied on emacs 30+
  (setcdr (assoc 'gnus-group-news-low-empty doom-themes-base-faces)
          '(:inherit 'gnus-group-mail-1-empty :weight 'normal))
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t) ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-horizon t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(provide 'init-themes)
