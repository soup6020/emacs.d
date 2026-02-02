;; Install themes

(use-package nerd-icons
  :ensure t)

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
  (load-theme 'ef-night t)
  )

(use-package tron-legacy-theme
  :config
  :ensure t
  ;;(load-theme 'tron-legacy t)
  )

(use-package doom-themes
 :ensure t
 :demand t
 :custom
 ;; Global settings (defaults)
 (doom-themes-enable-bold t) ; if nil, bold is universally disabled
 (doom-themes-enable-italic t) ; if nil, italics is universally disabled
 ;; for treemacs users
 (doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
 :config
 ;; (load-theme 'doom-outrun-electric t)

 ;; Enable flashing mode-line on errors
 (doom-themes-visual-bell-config)
 ;; Enable custom neotree theme (nerd-icons must be installed!)
 (doom-themes-neotree-config)
 ;; or for treemacs users
 (doom-themes-treemacs-config)
 ;; Corrects (and improves) org-mode's native fontification.
 (doom-themes-org-config))

(provide 'init-themes)
