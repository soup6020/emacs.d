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
  "b"
  '(consult-buffer :which-key "switch buffer")
  "t"
  '(consult-theme :which-key "change theme")
  "m"
  '(consult-bookmark :which-key "bookmarks menu")
  "."
  '(embark-act :which-key "embark-act")
  ))

(provide 'init-keys)
