(use-package nushell-mode
  :ensure (:host github :repo "mrkkrp/nushell-mode"))

(use-package nushell-ts-mode
  :ensure (:host github :repo "herbertjones/nushell-ts-mode")
  :mode "\\.nu\\'"
  )
(provide 'init-nushell)
