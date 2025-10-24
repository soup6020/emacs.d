;; Evil mode
(use-package evil
 :ensure t
 :demand t ; No lazy loading
 :init
 (setq evil-want-keybinding nil)
 (setq evil-want-C-u-scroll t)
 (setq evil-undo-system 'undo-fu)
 :config (evil-mode 1))

;; TODO: Move this somewhere more fitting, undo is not explicitly an evil thing
(use-package undo-fu
  :ensure t)

(use-package vundo
  :ensure t
  :commands (vundo)
  :hook (prog-mode . vundo-popup-mode)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols)
  )

(use-package evil-collection
 :after evil
 :ensure t
 :demand t
 :config (evil-collection-init))

(provide 'init-evil)
