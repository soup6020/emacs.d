(use-package rg
 :ensure t
 :defer t
 :general
 (leader-keys
  "s"
  '(:ignore t :which-key "search (rg)")
  "s <escape>"
  '(keyboard-escape-quit :which-key t)
  "s s"
  '(rg-menu :which-key "rg transient menu")
  "s r"
  '(rg :which-key "ripgrep")
  "s d"
  '(rg-dwim :which-key "rg dwim at point")
  "s p"
  '(rg-project :which-key "rg in project")
  "s l"
  '(rg-literal :which-key "rg literal string"))
 :config
 (rg-enable-default-bindings))

(provide 'init-rg)
