;; Markdown
(use-package markdown-mode
 :ensure t
 :defer t
 :config (setq markdown-fontify-code-blocks-natively t))

(use-package markdown-ts-mode
  :ensure t
  :after treesit-auto
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer 't
  :config
  )

(use-package typst-ts-mode
  :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode" :branch "main"))

(provide 'init-markdown)
