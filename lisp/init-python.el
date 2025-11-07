;; Python
(use-package python-mode
 :ensure t
 :defer t
 :after eglot
 :config (add-to-list 'eglot-server-programs '(python-mode . ("basedpyright")))
(add-hook 'python-mode-hook 'eglot-ensure))
(provide 'init-python)
