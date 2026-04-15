;; Eglot requires newer eldoc/jsonrpc than the built-ins shipped with Emacs.
;; Unload the built-ins so elpaca's copies take over before eglot loads.
(use-package eldoc
  :ensure t
  :preface
  (unload-feature 'eldoc t)
  (setq custom-delayed-init-variables '())
  (defvar global-eldoc-mode nil)
  :config
  (global-eldoc-mode))

(use-package jsonrpc
  :ensure t
  :defer t)

(use-package track-changes
  :ensure t
  :defer t)

(use-package project
  :ensure t
  :defer t)

(use-package eglot
  :ensure t
  :after (eldoc jsonrpc track-changes)
  :demand t)

;(use-package eglot-booster
; :ensure (:host github :repo "jdtsmith/eglot-booster")
; :after eglot
; :config (eglot-booster-mode))

(provide 'init-eglot)
