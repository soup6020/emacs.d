;; Emacs 30 ships recent enough eldoc/jsonrpc/track-changes for ELPA eglot,
;; so we use the built-ins.

(use-package project
  :ensure t
  :defer t)

(use-package eglot
  :ensure t
  :demand t
  :custom
  ;; Document-highlight overlays redraw on every cursor move and garble
  ;; lines in a TUI; disable that capability in terminal frames.
  (eglot-ignored-server-capabilities
   (unless (display-graphic-p) '(:documentHighlightProvider)))
  :hook
  ;; Overlays that repaint as point moves or as the server pushes updates
  ;; garble lines in a TUI. Disable them in terminal frames only.
  ;; nixd in particular republishes diagnostics repeatedly.
  (eglot-managed-mode . (lambda ()
                          (unless (display-graphic-p)
                            (eglot-inlay-hints-mode -1)
                            (flymake-mode -1)))))

(use-package eglot-booster
  :ensure (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :demand t
  :config (eglot-booster-mode))

(provide 'init-eglot)
