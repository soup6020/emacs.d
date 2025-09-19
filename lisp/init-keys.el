(use-package
 which-key
 :ensure t
 :demand t
 :init
 (setq which-key-idle-delay 0.5) ; Open after .5s instead of 1s
 :config (which-key-mode))

(use-package
 general
 ; Must wait otherwise the :general keyword is not available
 :ensure (:wait t)
 :demand
 :config (general-evil-setup)

 (general-create-definer
  leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "C-SPC")

 (leader-keys
  "x"
  '(execute-extended-command :which-key "execute command")
  "r"
  '(restart-emacs :which-key "restart emacs")
  "i"
  '((lambda ()
      (interactive)
      (find-file user-init-file))
    :which-key "open init file")

  ;; Buffer
  "b"
  '(:ignore t :which-key "buffer")
  ;; Don't show an error because SPC b ESC is undefined, just abort
  "b <escape>"
  '(keyboard-escape-quit :which-key t)
  "bd"
  'kill-current-buffer))

(provide 'init-keys)
