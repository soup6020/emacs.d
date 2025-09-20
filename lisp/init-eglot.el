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

;; Wedge nix-ts here for now, evaluate later
;; NOTE: this hook configuration works, change the rest
;; NOTE 2: Set up more ts-modes, maybe in treesit.el? Or split langs out into modules.
(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'"
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nixd")))
  (add-hook 'nix-ts-mode-hook 'eglot-ensure))

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
 :config (add-to-list 'eglot-server-programs '(python-mode . ("basedpyright")))
(add-hook 'python-mode-hook 'eglot-ensure))

;; Rust
(use-package
 rust-mode
 :ensure t
 :after eglot
 :hook (rust-mode . eglot-ensure)
 :config (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer"))))

;; YAML
(use-package
 yaml-mode
 :ensure t
 :after eglot
 :hook (yaml-mode . eglot-ensure)
 :config (add-to-list 'eglot-server-programs '(yaml-mode . ("yaml-language-server"))))

(provide 'init-eglot)
