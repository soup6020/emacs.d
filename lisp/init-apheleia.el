(use-package apheleia
  :ensure t
  :config
  (setf (alist-get 'nix-mode apheleia-mode-alist) 'nixfmt)
  (setf (alist-get 'nix-ts-mode apheleia-mode-alist) 'nixfmt)
  (apheleia-global-mode 1))

(provide 'init-apheleia)
