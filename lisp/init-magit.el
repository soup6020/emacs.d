(use-package transient :ensure t)

(use-package
 magit
 :general
 (leader-keys
  "g"
  '(:ignore t :which-key "git")
  "g <escape>"
  '(keyboard-escape-quit :which-key t)
  "g g"
  '(magit-status :which-key "status")
  "g l"
  '(magit-log :which-key "log"))
 (general-nmap "<escape>" #'transient-quit-one))

(provide 'init-magit)
