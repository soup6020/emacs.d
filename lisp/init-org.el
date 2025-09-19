;; org stuff
(use-package
 org
 :ensure (:wait t)
 :config
 ;; Exclude the daily tag from inheritance so that archived tasks don't appear with this tag in my agenda
 (add-to-list 'org-tags-exclude-from-inheritance "daily")
 (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
 (setq org-hide-leading-stars t)
 (setq org-hide-emphasis-markers t))

(use-package
 evil-org
 :ensure t
 :after org
 :hook (org-mode . (lambda () evil-org-mode))
 :config
 (require 'evil-org-agenda)
 (evil-org-agenda-set-keys)
 (setq evil-want-C-i-jump nil))

(use-package
 org-modern
 :ensure t
 :init (global-org-modern-mode)
 :custom
 (org-modern-star nil)
 (org-modern-block-fringe nil)
 (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
 :hook
 (org-mode . org-indent-mode)
 (org-mode . visual-line-mode))

(provide 'init-org)
