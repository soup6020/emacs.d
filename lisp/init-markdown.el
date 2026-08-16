;;; init-markdown.el --- -*- lexical-binding: t; -*-
;; Markdown
(use-package markdown-ts-mode
  :ensure nil ; built-in for Emacs 31+
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer t
  :hook ((markdown-ts-mode	. eglot-ensure))
  :config
  )

(use-package typst-ts-mode
  :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode" :branch "main"))

(provide 'init-markdown)
