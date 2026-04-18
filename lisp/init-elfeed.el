(use-package elfeed
 :ensure t
 :general
 (leader-keys
  "e"
  '(:ignore t :which-key "elfeed")
  "e <escape>"
  '(keyboard-escape-quit :which-key t)
  "e e"
  '(elfeed :which-key "open elfeed")
  "e u"
  '(elfeed-update :which-key "update feeds"))
 :config
 (setq elfeed-search-filter "@1-month-ago +unread"))

(use-package elfeed-org
 :ensure t
 :after elfeed
 :config
 (elfeed-org)
 (setq rmh-elfeed-org-files (list (expand-file-name "elfeed.org" org-directory))))

(provide 'init-elfeed)
