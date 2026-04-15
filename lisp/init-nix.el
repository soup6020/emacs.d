;; Nix
(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'"
  :hook (nix-ts-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nixd"))))

(provide 'init-nix)
