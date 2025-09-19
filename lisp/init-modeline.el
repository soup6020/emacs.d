;; Doom modeline
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-continuous-word-count-modes
      '(markdown-mode gfm-mode org-mode))
(setq doom-modeline-env-version t)
(setq doom-modeline-time t)
(use-package
 doom-modeline
 :ensure t
 :demand t
 :init (doom-modeline-mode 1))

;; Minions
(use-package
  minions
  :ensure t
  :demand t
  :config (minions-mode 1)
  )

(provide 'init-modeline)
