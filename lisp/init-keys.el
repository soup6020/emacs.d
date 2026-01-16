(use-package which-key
 :ensure t
 :demand t
 :init
 (setq which-key-idle-delay 0.1) ; Open after .1s instead of 1s
 :config (which-key-mode))

(use-package general
 ; Must wait otherwise the :general keyword is not available
 :ensure (:wait t)
 :demand
 :config (general-evil-setup)

 (general-create-definer leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "C-SPC")

 (leader-keys
 ;; Top level keybinds
  "r"
  '(restart-emacs :which-key "restart emacs")
  "i"
  '((lambda ()
      (interactive)
      (find-file user-init-file))
    :which-key "open init file")
  "t"
  '(consult-theme :which-key "change theme")
  "m"
  '(consult-bookmark :which-key "bookmarks menu")
  ;; This should probably be something else, so it's usable in minibuffers like consult-buffer
  "."
  '(embark-act :which-key "embark-act")

  ;; Buffer menu
  "b"
  '(:ignore t :which-key "buffer menu")
  "b <escape>"
  '(keyboard-escape-quit :which-key t)
  "bb"
  '(consult-buffer :which-key "consult-buffer")
  "bk"
  '(kill-buffer :which-key "kill-buffer")
  "bi"
  '(ibuffer :which-key "ibuffer")

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
  "oa"
  '(org-archive-subtree :which-key "archive selected task")

  ;; org-agenda
  "a"
  '(:ignore t :which-key "agenda")
  "ao"
  '(org-agenda :which-key "open org-agenda")
  "aa"
  '(consult-org-agenda :which-key "consult agenda picker")
  "at"
  '(todo-open-soup6020 :which-key "open irl and it todo files")

  ;;Treemacs
  "k"
  '(:ignore t :which-key "treemacs")
  "kk"
  '(treemacs :which-key "treemacs")
  "kl"
  '(treemacs-next-workspace :which-key "switch workspaces")
  "ke"
  '(treemacs-edit-workspaces :which-key "edit workspaces")

 ;; Window commmands
 "w"
 '(:ignore t :which-key "window commands")
 "wh"
 '(split-window-horizontally :which-key "horizontal split")
 "wv"
 '(split-window-vertically :which-key "vertical split")
 "wt"
 '(tab-new :which-key "new tab")
 ))

(provide 'init-keys)
