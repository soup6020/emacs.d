;; Treesitter
(use-package
 treesit-auto
 :ensure t
 :demand t
 :config (global-treesit-auto-mode))

;;Nix-ts
(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'"
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd")))
  (add-hook 'nix-ts-mode-hook 'eglot-ensure))

(use-package markdown-ts-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer 't
  :config
  )

(provide 'init-treesit)
