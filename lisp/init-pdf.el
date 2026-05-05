;; PDF
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query t))

;; DjVu
(use-package djvu
  :ensure t
  :mode ("\\.djvu\\'" . djvu-read-mode))

(provide 'init-pdf)
