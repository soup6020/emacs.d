;;; init-apheleia.el --- -*- lexical-binding: t; -*-
(use-package apheleia
  :ensure t
  :demand t
  :config
  (setf (alist-get 'nix-mode apheleia-mode-alist) 'nixfmt)
  (setf (alist-get 'nix-ts-mode apheleia-mode-alist) 'nixfmt)
  (apheleia-global-mode 1))

(provide 'init-apheleia)
