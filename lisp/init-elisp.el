;;; init-elisp.el --- -*- lexical-binding: t; -*-
(use-package sly
  :ensure t)

(use-package elisp-autofmt
 :ensure t
 :defer t
 :commands (elisp-autofmt-mode elisp-autofmt-buffer)
 :hook (emacs-lisp-mode . elisp-autofmt-mode))

;; Structural editing for lisps.
(use-package lispy
  :ensure t
  :hook ((emacs-lisp-mode lisp-mode scheme-mode) . lispy-mode))

;; Reconcile lispy's keybindings with evil states.
(use-package lispyville
  :ensure t
  :after (lispy evil)
  :hook (lispy-mode . lispyville-mode))

(provide 'init-elisp)
