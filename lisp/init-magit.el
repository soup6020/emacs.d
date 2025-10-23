(use-package transient :ensure t)

(use-package
  magit
 :defer t
 :general
 (leader-keys
  "g"
  '(:ignore t :which-key "git")
  "g <escape>"
  '(keyboard-escape-quit :which-key t)
  "g g"
  '(magit-status :which-key "status")
  "g l"
  '(magit-log :which-key "log")
  "g c"
  '(magit-commit :which-key "commit")
  "g s"
  '(magit-stage :which-key "stage file")
  "g p"
  '(magit-pull :which-key "pull")
  "g o"
  '(magit-push :which-key "push")
  "g f"
  '(with-editor-finish :which-key "finish editing message")
  )
 (general-nmap "<escape>" #'transient-quit-one))

(provide 'init-magit)
