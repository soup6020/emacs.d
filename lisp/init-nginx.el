(use-package nginx-mode
  :ensure t
  :defer t
  :commands nginx-mode
  :config
  (add-to-list 'auto-mode-alist '("/nginx/sites-\\(?:available\\|enabled\\)/" . nginx-mode))
  )
(provide 'init-nginx)
