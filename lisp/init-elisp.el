(use-package sly :ensure t)

(use-package
 elisp-autofmt
 :ensure t
 :defer t
 :commands (elisp-autofmt-mode elisp-autofmt-buffer)
 :hook (emacs-lisp-mode . elisp-autofmt-mode))

(provide 'init-elisp)
