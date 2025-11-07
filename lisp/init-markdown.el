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

(provide 'init-markdown)
