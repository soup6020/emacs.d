;;; init-prism.el --- -*- lexical-binding: t; -*-
;; Colorize code by depth. Use prism-mode for delimiter-nested languages
;; and prism-whitespace-mode for indentation-sensitive ones.
;;
;; prism derives its palette from theme faces the first time it is enabled
;; (see `prism-set-colors', driven by `prism-colors' which defaults to the
;; font-lock-*-face set). Under an Emacs daemon the initial frame has no
;; colors, so that derivation signals "No non-unspecified colors remain ..."
;; and aborts startup. The helpers below enable prism only once its palette
;; is actually computable, deferring to the first server frame otherwise.
;; This still works in real TTY frames, where the theme's colors do resolve.

(defun soup6020/prism-colors-ready-p ()
  "Compute prism's palette if needed; return non-nil once it is available.
Calls `prism-set-colors' (ignoring the error it raises on a colorless
frame, e.g. a daemon's initial frame) and reports whether `prism-faces'
ended up populated."
  (unless prism-faces
    (ignore-errors (prism-set-colors)))
  prism-faces)

(defun soup6020/enable-prism (mode)
  "Enable prism minor MODE once colors are available, else defer.
On a colorless frame (such as an Emacs daemon's initial frame) prism
cannot derive its palette and would abort startup, so defer enabling MODE
in this buffer until a server frame with colors is created."
  (require 'prism)
  (if (soup6020/prism-colors-ready-p)
      (funcall mode 1)
    (let ((buffer (current-buffer)) hook-fn)
      (setq hook-fn
            (lambda ()
              (when (soup6020/prism-colors-ready-p)
                (remove-hook 'server-after-make-frame-hook hook-fn)
                (when (buffer-live-p buffer)
                  (with-current-buffer buffer (funcall mode 1))))))
      (add-hook 'server-after-make-frame-hook hook-fn))))

(use-package prism
  :ensure t
  :hook
  ((emacs-lisp-mode lisp-mode scheme-mode
    rust-mode rust-ts-mode nix-ts-mode)
   . (lambda () (soup6020/enable-prism #'prism-mode)))
  ((python-mode python-ts-mode yaml-mode yaml-ts-mode)
   . (lambda () (soup6020/enable-prism #'prism-whitespace-mode))))

(provide 'init-prism)
