(use-package eglot :ensure t :demand t)

(use-package
 eglot-booster
 :ensure (:host github :repo "jdtsmith/eglot-booster")
 :after eglot
 :config (eglot-booster-mode))

;; Nix
(use-package
 nix-mode
 :ensure t
 :hook (nix-mode . eglot-ensure)
 :config
 (add-to-list 'eglot-server-programs '(nix-mode . ("nixd"))))

;; Markdown
(use-package
 markdown-mode
 :ensure t
 :config (setq markdown-fontify-code-blocks-natively t))

;; Python
(use-package
 python-mode
 :ensure t
 :after eglot
 :hook (python-mode . eglot-ensure))

;; Rust
(use-package
 rust-mode
 :ensure t
 :after eglot
 :hook (rust-mode . eglot-ensure))

;; YAML
(use-package
 yaml-mode
 :ensure t
 :after eglot
 :hook (yaml-mode . eglot-ensure))

(provide 'init-eglot)
