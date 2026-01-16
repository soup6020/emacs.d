;; YAML
(use-package
 yaml-mode
 :ensure t
 :defer t
 :after eglot
 :hook (yaml-mode . eglot-ensure)
 :config (add-to-list 'eglot-server-programs '(yaml-mode . ("yaml-language-server")))
 (add-hook 'yaml-mode-hook 'eglot-ensure)
 (setq indent-tabs-mode nil)
 (setq yaml-indent-offset 2))

(provide 'init-yaml)
