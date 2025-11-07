(use-package eglot
  :ensure t
  :demand t)

(use-package eglot-booster
 :ensure (:host github :repo "jdtsmith/eglot-booster")
 :after eglot
 :config (eglot-booster-mode))

(provide 'init-eglot)
