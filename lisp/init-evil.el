;; Evil mode
(use-package evil
 :ensure t
 :demand t ; No lazy loading
 :init
 (setq evil-want-keybinding nil)
 (setq evil-want-C-u-scroll t)
 (setq evil-undo-system 'undo-fu)
 :config (evil-mode 1))

(use-package undo-fu
  :ensure t)

(use-package evil-collection
 :after evil
 :ensure t
 :demand t
 :config (evil-collection-init))

(provide 'init-evil)
