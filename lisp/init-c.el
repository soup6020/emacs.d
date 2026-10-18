;;; init-c.el --- -*- lexical-binding: t; -*-
;; Remap all relevant modes to their tree-sitter equivalents
(dolist (remap '((c-mode        . c-ts-mode)
                 (c++-mode      . c++-ts-mode)
                 (c-or-c++-mode . c-or-c++-ts-mode)))
  (add-to-list 'major-mode-remap-alist remap))

(use-package c-ts-mode
  :ensure nil ; built in
  :defer t
  :custom
  (c-ts-mode-indent-offset 2)
  (c-ts-mode-indent-style 'k&r)
  :hook ((c-ts-mode   . eglot-ensure)
         (c++-ts-mode . eglot-ensure))
  :config
  ;; eglot ships (c-mode c-ts-mode c++-mode c++-ts-mode objc-mode) mapped to
  ;; `eglot-alternatives' over ("clangd" "ccls"), which prompts if both are
  ;; installed.  Name clangd outright so it never asks, and pass our own flags.
  (add-to-list 'eglot-server-programs
               '((c-ts-mode c++-ts-mode)
                 . ("clangd"
                    "--background-index"
                    "--clang-tidy"
                    "--completion-style=detailed"))))

(provide 'init-c)
