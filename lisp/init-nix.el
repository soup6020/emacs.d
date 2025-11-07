;; Nix
(use-package nix-mode
 :ensure t
 :after eglot 
 :defer t
 :hook
  ((nix-mode . eglot-ensure)
   (nix-mode . (lambda ()
                 (add-hook 'before-save-hook #'nix-format-buffer nil t))))
 :mode "\\.nix\\'"
 :commands nix-format-buffer
 :config
 (add-to-list 'eglot-server-programs '(nix-mode . ("nixd"))))

;;Nix-ts
(use-package nix-ts-mode
  :ensure t
  :after (:all treesit-auto eglot)
  :mode "\\.nix\\'"
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd")))
  (add-hook 'nix-ts-mode-hook 'eglot-ensure))

(provide 'init-nix)
