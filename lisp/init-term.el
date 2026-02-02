(use-package vterm
  :ensure t)
(use-package vterm-toggle
 :ensure t
 :defer t
 :general (leader-keys "'" '(vterm-toggle :which-key "terminal")))

;; Kitty keyboard protocol support
(use-package kkp
 :ensure t
 :config
 ;; (setq kkp-alt-modifier 'alt) ;; use this if you want to map the Alt keyboard modifier to Alt in Emacs (and not to Meta)
 (global-kkp-mode +1))

(use-package eat
  :ensure t
  :config
  (add-hook 'eshell-load-hook #'eat-eshell-mode))

(provide 'init-term)
