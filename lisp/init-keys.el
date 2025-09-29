(use-package
 which-key
 :ensure t
 :demand t
 :init
 (setq which-key-idle-delay 0.1) ; Open after .1s instead of 1s
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
  ;; This is just M-x reboud, probably useless
  ;;"x"
  ;;'(execute-extended-command :which-key "execute command")
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
  ;; Org
  "o"
  '(:ignore t :which-key "org menu")
  ;; Don't show an error because SPC o ESC is undefined, just abort
  "o <escape>" '(keyboard-escape-quit :which-key t)
  "ot"
  '(org-todo :which-key "change state of TODO item")
  "os"
  '(org-schedule :which-key "open schedule picker")
  "od"
  '(org-deadline :which-key "set task deadline")
  "oo"
  '(org-overview :which-key "overview mode")
  "op"
  '(org-priority :which-key "change item priority")
  "oc"
  '(org-cycle-global :which-key "cycle global visibility")
  ))

(provide 'init-keys)
