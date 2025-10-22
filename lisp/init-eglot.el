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
 :mode "\\.nix\\'"
 :config
 (require 'nix-format)
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
 :config (add-to-list 'eglot-server-programs '(python-mode . ("basedpyright")))
(add-hook 'python-mode-hook 'eglot-ensure))

;; Rust
(use-package
 rust-mode
 :ensure t
 :after eglot
 :hook (rust-mode . eglot-ensure)
 :config (add-to-list 'eglot-server-programs
                       `(rust-mode . ("rust-analyzer" :initializationOptions
                                     ( :procMacro (:enable t)
                                       :cargo ( :buildScripts (:enable t)
                                                :features "all"))))))

;; YAML
(use-package
 yaml-mode
 :ensure t
 :after eglot
 :hook (yaml-mode . eglot-ensure)
 :config (add-to-list 'eglot-server-programs '(yaml-mode . ("yaml-language-server")))
(add-hook 'yaml-mode-hook 'eglot-ensure))

(provide 'init-eglot)
