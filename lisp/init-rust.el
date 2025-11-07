;; Rust
(use-package rust-mode
 :ensure t
 :defer t
 :after eglot
 :hook (rust-mode . eglot-ensure)
 :config (add-to-list 'eglot-server-programs
                       `(rust-mode . ("rust-analyzer" :initializationOptions
                                     ( :procMacro (:enable t)
                                       :cargo ( :buildScripts (:enable t)
                                                :features "all"))))))
(provide 'init-rust)
