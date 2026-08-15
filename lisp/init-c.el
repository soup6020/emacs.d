;;; init-c.el --- -*- lexical-binding: t; -*-
;; C and C++ using the tree-sitter modes built in since Emacs 29, with clangd
;; driven through eglot.

;; `treesit-auto' remaps c-mode and c++-mode, but only buffer-locally and only
;; for those two.  It has no recipe for `c-or-c++-mode' (what .h files get), and
;; cc-mode's `c-or-c++-mode' funcalls c-mode/c++-mode directly, bypassing any
;; remap.  Set all three globally; treesit-auto appends to this value rather
;; than replacing it, so the two overlapping entries are harmless.
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
