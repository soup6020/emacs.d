;; Treemacs
(use-package treemacs
 :ensure t
 :defer t
 :init
 (with-eval-after-load 'winum
   (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
 :config
 (progn
   (setq
    treemacs-buffer-name-function #'treemacs-default-buffer-name
    treemacs-buffer-name-prefix " *Treemacs-Buffer-"
    treemacs-position 'left
    treemacs-show-cursor nil
    treemacs-show-hidden-files nil
    treemacs-width 25
    treemacs-follow-after-init t)
   (treemacs-follow-mode t)
   (treemacs-filewatch-mode t)
   (treemacs-fringe-indicator-mode 'always)
   (treemacs-hide-gitignored-files-mode nil))
 :bind
 (:map
  global-map
  ("M-0" . treemacs-select-window)
  ("C-x t 1" . treemacs-delete-other-windows)
  ("C-x t t" . treemacs)
  ("C-x t d" . treemacs-select-directory)
  ("C-x t B" . treemacs-bookmark)
  ("C-x t C-t" . treemacs-find-file)
  ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-projectile
 :after (treemacs projectile)
 :ensure t)

;; Superfluous with dirvish
;;(use-package treemacs-icons-dired
;;  :hook (dired-mode . treemacs-icons-dired-enable-once)
;;  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-nerd-icons
 :config (treemacs-load-theme "nerd-icons"))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)
(provide 'init-treemacs)
