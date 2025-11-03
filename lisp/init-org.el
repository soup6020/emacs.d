;; org stuff
(use-package org
 :ensure (:wait t)
 :demand t
 :config
 ;; Exclude the daily tag from inheritance so that archived tasks don't appear with this tag in my agenda
 (add-to-list 'org-tags-exclude-from-inheritance "daily")
 ;; Make all .org files load org-mode
 (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
 ;; Cosmetic changes
 (setq org-hide-leading-stars t)
 (setq org-hide-emphasis-markers t))
 ;; Global org directory
 (setq org-directory "~/org")
 ;; Agenda directory - org reads TODO entries from this directory for the global agenda
(setq org-agenda-files '("~/org/todo"))
(setq org-archive-location "~/org/archive/agenda-archive.org::* Archived Tasks")
 (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "DONE")))

(use-package evil-org
 :ensure t
 :demand t
 :after org
 :hook (org-mode . (lambda () evil-org-mode))
 :config
 (require 'evil-org-agenda)
 (evil-org-agenda-set-keys)
 (setq evil-want-C-i-jump nil))

(use-package org-modern
 :ensure t
 :init (global-org-modern-mode)
 :custom
 (org-modern-star nil)
 (org-modern-block-fringe nil)
 (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
 :hook
 (org-mode . org-indent-mode)
 (org-mode . visual-line-mode))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))
  
  ;; org-roam-ui dependency
  (use-package websocket
    :ensure t
    :after org-roam)

  (use-package org-roam-ui
    :ensure t
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; Make newline in a list under org act like google docs
(use-package org-autolist
  :ensure t
  :hook (org-mode . org-autolist-mode))

(provide 'init-org)
