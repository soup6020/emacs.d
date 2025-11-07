;; Treesitter
(use-package treesit-auto
 :ensure t
 :demand t
 :config (global-treesit-auto-mode))

(use-package markdown-ts-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer 't
  :config
  )

(provide 'init-treesit)
