;;; init-flymake.el --- -*- lexical-binding: t; -*-
;; Flymake is built in and is what eglot drives natively, so managed
;; buffers get diagnostics with no extra glue. Enable it for the rest of
;; prog-mode (e.g. elisp) too.
(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :custom
  (flymake-no-changes-timeout 0.5)
  (flymake-fringe-indicator-position 'right-fringe)
  :bind
  (:map flymake-mode-map
        ("M-n" . flymake-goto-next-error)
        ("M-p" . flymake-goto-prev-error)
        ("C-c ! l" . flymake-show-buffer-diagnostics)))

(provide 'init-flymake)
