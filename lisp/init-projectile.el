(use-package
 projectile
 :ensure t
 :demand t
 :general
 (leader-keys
  :states
  'normal
  "SPC"
  '(projectile-find-file :which-key "find file")

  ;; Projects
  "p"
  '(:ignore t :which-key "projects")
  "p <escape>"
  '(keyboard-escape-quit :which-key t)
  "p p"
  '(projectile-switch-project :which-key "switch project")
  "p a"
  '(projectile-add-known-project :which-key "add project")
  "p r"
  '(projectile-remove-known-project :which-key "remove project"))
 :init (projectile-mode +1))

(provide `init-projectile)
