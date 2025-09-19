;; TODO: Am I even using this?
(use-package ivy :ensure t :config (ivy-mode))

(use-package
 vertico
 :ensure t
 :init (vertico-mode 1)
 :config (setq vertico-count 25))

(use-package corfu :ensure t :init (global-corfu-mode))

;; Not strictly completion, but complementary
(use-package savehist :ensure nil :init (savehist-mode 1))
(use-package marginalia :ensure t :init (marginalia-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(provide 'init-completion)
