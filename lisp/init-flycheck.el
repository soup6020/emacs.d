(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Route eglot diagnostics through flycheck instead of flymake.
(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config (global-flycheck-eglot-mode 1))

(provide 'init-flycheck)
