;; Unset vendor-specific emacs config (default.el)
(setq inhibit-default-init t)

;; Some housekeeping
(tool-bar-mode -1) ; Hide the outdated icons
(menu-bar-mode -1) ; Disable menubar
(scroll-bar-mode -1) ; Remove scrollbar
(tab-bar-mode 1) ; Always show tab bar
(setq inhibit-splash-screen t) ; Remove GNU splash
(setq use-file-dialog nil) ; Text-mode confirmations instead of dialog boxes
;; Enable mouse in terminals
(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;; Set up elpaca
(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory
  (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory
  (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory
  (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order
  '(elpaca
    :repo "https://github.com/progfolio/elpaca.git"
    :ref nil
    :depth 1
    :inherit ignore
    :files (:defaults "elpaca-test.el" (:exclude "extensions"))
    :build (:not elpaca--activate-package)))
(let* ((repo (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list
   'load-path
   (if (file-exists-p build)
       build
     repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28)
      (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer
                   (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop
                    (apply #'call-process
                           `("git" nil ,buffer t "clone" ,@
                             (when-let* ((depth
                                          (plist-get order :depth)))
                               (list
                                (format "--depth=%d" depth)
                                "--no-single-branch"))
                             ,(plist-get order :repo) ,repo))))
                  ((zerop
                    (call-process "git"
                                  nil
                                  buffer
                                  t
                                  "checkout"
                                  (or (plist-get order :ref) "--"))))
                  (emacs
                   (concat invocation-directory invocation-name))
                  ((zerop
                    (call-process
                     emacs
                     nil
                     buffer
                     nil
                     "-Q"
                     "-L"
                     "."
                     "--batch"
                     "--eval"
                     "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
          (progn
            (message "%s" (buffer-string))
            (kill-buffer buffer))
          (error
           "%s"
           (with-current-buffer buffer
             (buffer-string))))
      ((error)
       (warn "%s" err)
       (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil))
      (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))


;; Install use-package support
(elpaca
 elpaca-use-package
 ;; Enable use-package :ensure support for Elpaca.
 (elpaca-use-package-mode))
;; Always defer package loading for speed reasons
(setq use-package-always-defer t)
;; Misc emacs options, mostly self explanatory
(use-package
 emacs
 :custom
 (tab-always-indent 'complete)
 (completion-cycle-threshold 3)
 (text-mode-ispell-word-completion nil)
 (read-extended-command-predicate
  #'command-completion-default-include-p)

 :init
 (setq initial-scratch-message nil)
 (defun display-startup-echo-area-message ()
   (message ""))

 (defalias 'yes-or-no-p 'y-or-n-p)

 ;; Hide pesky backup files
 (setq backup-directory-alist `(("." . "~/.config/emacs/saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

 ;; UTF-8 always and everywhere
 (set-charset-priority 'unicode)
 (setq
  locale-coding-system 'utf-8
  coding-system-for-read 'utf-8
  coding-system-for-write 'utf-8)
 (set-terminal-coding-system 'utf-8)
 (set-keyboard-coding-system 'utf-8)
 (set-selection-coding-system 'utf-8)
 (prefer-coding-system 'utf-8)
 (setq default-process-coding-system '(utf-8-unix . utf-8-unix))

 ;; Scroll one line at a time
 (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
 (setq mouse-wheel-follow-mouse 't)
 (setq mouse-wheel-progressive-speed nil)

 (setq-default indent-tabs-mode nil)
 (setq-default tab-width 2)
 (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

 ;; Cosmetics
 (set-face-attribute 'default nil
                     :font "ZedMono Nerd Font Mono"
                     :height 120)
 (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
 (add-to-list 'default-frame-alist '(ns-appearance . light))
 (setq ns-use-proxy-icon nil)
 (setq frame-title-format nil)
 (add-hook 'prog-mode-hook 'display-line-numbers-mode)
 (defun prot/toggle-line-numbers ()
   "Toggles the display of line numbers.  Applies to all buffers."
   (interactive)
   (if (bound-and-true-p display-line-numbers-mode)
       (display-line-numbers-mode -1)
     (display-line-numbers-mode)))
 :bind (("<f7>" . prot/toggle-line-numbers)))

(use-package no-littering :ensure t :demand t)

;; Install themes
(use-package
 kanagawa-themes
 :ensure t
 :demand t
 :config
 (unless (display-graphic-p)
   (load-theme 'kanagawa-wave t)))
(use-package ef-themes :ensure t)
(use-package
 doom-themes
 :ensure t
 :demand t
 :custom
 ;; Global settings (defaults)
 (doom-themes-enable-bold t) ; if nil, bold is universally disabled
 (doom-themes-enable-italic t) ; if nil, italics is universally disabled
 ;; for treemacs users
 (doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
 :config
 (load-theme 'doom-moonlight t)

 ;; Enable flashing mode-line on errors
 (doom-themes-visual-bell-config)
 ;; Enable custom neotree theme (nerd-icons must be installed!)
 (doom-themes-neotree-config)
 ;; or for treemacs users
 (doom-themes-treemacs-config)
 ;; Corrects (and improves) org-mode's native fontification.
 (doom-themes-org-config))

;; Evil mode
(use-package
 evil
 :ensure t
 :demand t ; No lazy loading
 :init (setq evil-want-keybinding nil) (setq evil-want-C-u-scroll t)
 :config (evil-mode 1))

(use-package
 evil-collection
 :after evil
 :ensure t
 :demand t
 :config (evil-collection-init))

(use-package nerd-icons)

;; Doom modeline
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-continuous-word-count-modes
      '(markdown-mode gfm-mode org-mode))
(setq doom-modeline-env-version t)
(setq doom-modeline-time t)
(use-package
 doom-modeline
 :ensure t
 :demand t
 :init (doom-modeline-mode 1))

;; Minions
(use-package
  minions
  :ensure t
  :demand t
  :config (minions-mode 1)
  )

(use-package
 which-key
 :ensure t
 :demand t
 :init
 (setq which-key-idle-delay 0.5) ; Open after .5s instead of 1s
 :config (which-key-mode))

(use-package
 general
 ; Must wait otherwise the :general keyword is not available
 :ensure (:wait t)
 :demand
 :config (general-evil-setup)

 (general-create-definer
  leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "C-SPC")

 (leader-keys
  "x"
  '(execute-extended-command :which-key "execute command")
  "r"
  '(restart-emacs :which-key "restart emacs")
  "i"
  '((lambda ()
      (interactive)
      (find-file user-init-file))
    :which-key "open init file")

  ;; Buffer
  "b"
  '(:ignore t :which-key "buffer")
  ;; Don't show an error because SPC b ESC is undefined, just abort
  "b <escape>"
  '(keyboard-escape-quit :which-key t)
  "bd"
  'kill-current-buffer))

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

  ;; Buffers
  "b b"
  '(projectile-switch-to-buffer :which-key "switch buffer")

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

(use-package ivy :ensure t :config (ivy-mode))

(use-package flymake :ensure t)
(use-package flymake-collection :ensure t :after flymake)


(use-package transient :ensure t)
(use-package
 magit
 :general
 (leader-keys
  "g"
  '(:ignore t :which-key "git")
  "g <escape>"
  '(keyboard-escape-quit :which-key t)
  "g g"
  '(magit-status :which-key "status")
  "g l"
  '(magit-log :which-key "log"))
 (general-nmap "<escape>" #'transient-quit-one))

(use-package vterm :ensure t)
(use-package
 vterm-toggle
 :ensure t
 :general (leader-keys "'" '(vterm-toggle :which-key "terminal")))

;; Kitty keyboard protocol support
(use-package
 kkp
 :ensure t
 :config
 ;; (setq kkp-alt-modifier 'alt) ;; use this if you want to map the Alt keyboard modifier to Alt in Emacs (and not to Meta)
 (global-kkp-mode +1))

(use-package
 vertico
 :ensure t
 :init (vertico-mode 1)
 :config (setq vertico-count 25))

(use-package corfu :ensure t :init (global-corfu-mode))

(use-package savehist :ensure nil :init (savehist-mode 1))

(use-package marginalia :ensure t :init (marginalia-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; Dirvish
(use-package
 dired
 :config
 (setq
  dired-listing-switches
  "-l --almost-all --human-readable --group-directories-first --no-group")
 ;; this command is useful when you want to close the window of `dirvish-side'
 ;; automatically when opening a file
 (put 'dired-find-alternate-file 'disabled nil))

(use-package
 dirvish
 :ensure t
 :init (dirvish-override-dired-mode)
 :custom
 (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
  '(("h" "~/" "Home")
    ("d" "~/Downloads/" "Downloads")
    ("m" "/mnt/" "Drives")
    ("n" "~/nix" "Nix Flake")
    ("e" "~/.config/emacs" "Emacs init dir")))
 :config
 (dirvish-peek-mode) ; Preview files in minibuffer
 (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
 (setq dirvish-mode-line-format
       '(:left (sort symlink) :right (omit yank index)))
 (setq
  dirvish-attributes ; The order *MATTERS* for some attributes
  '(vc-state subtree-state
             nerd-icons
             collapse
             git-msg
             file-time
             file-size)
  dirvish-side-attributes '(vc-state nerd-icons collapse file-size))
 ;; open large directory (over 20000 files) asynchronously with `fd' command
 (setq dirvish-large-directory-threshold 20000)
 ;; Mouse support
 (setq dired-mouse-drag-files t)
 (setq mouse-drag-and-drop-region-cross-program t)
 (setq mouse-1-click-follows-link nil)
 (define-key
  dirvish-mode-map (kbd "<mouse-1>") 'dirvish-subtree-toggle-or-open)
 (define-key
  dirvish-mode-map
  (kbd "<mouse-2>")
  'dired-mouse-find-file-other-window)
 (define-key
  dirvish-mode-map (kbd "<mouse-3>") 'dired-mouse-find-file)
 :bind ; Bind `dirvish-fd|dirvish-side|dirvish-dwim' as you see fit
 (("C-c f" . dirvish)
  :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
  (";" . dired-up-directory) ; So you can adjust `dired' bindings here
  ("?" . dirvish-dispatch) ; [?] a helpful cheatsheet
  ("a" . dirvish-setup-menu) ; [a]ttributes settings:`t' toggles mtime, `f' toggles fullframe, etc.
  ("f" . dirvish-file-info-menu) ; [f]ile info
  ("o" . dirvish-quick-access) ; [o]pen `dirvish-quick-access-entries'
  ("s" . dirvish-quicksort) ; [s]ort flie list
  ("r" . dirvish-history-jump) ; [r]ecent visited
  ("l" . dirvish-ls-switches-menu) ; [l]s command flags
  ("v" . dirvish-vc-menu) ; [v]ersion control commands
  ("*" . dirvish-mark-menu)
  ("y" . dirvish-yank-menu)
  ("N" . dirvish-narrow)
  ("^" . dirvish-history-last)
  ("TAB" . dirvish-subtree-toggle)
  ("M-f" . dirvish-history-go-forward)
  ("M-b" . dirvish-history-go-backward)
  ("M-e" . dirvish-emerge-menu)))

;; Treemacs
(use-package
 treemacs
 :ensure t
 :defer t
 :init
 (with-eval-after-load 'winum
   (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
 :config
 (progn
   (setq
    treemacs-buffer-name-function #'treemacs-default-buffer-name
    treemacs-buffer-name-prefix " *Treemacs-Buffer-"
    treemacs-position 'left
    treemacs-show-cursor nil
    treemacs-show-hidden-files nil
    treemacs-width 25
    treemacs-follow-after-init t)
   (treemacs-follow-mode t)
   (treemacs-filewatch-mode t)
   (treemacs-fringe-indicator-mode 'always)
   (treemacs-hide-gitignored-files-mode nil))
 :bind
 (:map
  global-map
  ("M-0" . treemacs-select-window)
  ("C-x t 1" . treemacs-delete-other-windows)
  ("C-x t t" . treemacs)
  ("C-x t d" . treemacs-select-directory)
  ("C-x t B" . treemacs-bookmark)
  ("C-x t C-t" . treemacs-find-file)
  ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-evil :after (treemacs evil) :ensure t)
(use-package
 treemacs-projectile
 :after (treemacs projectile)
 :ensure t)
;;(use-package treemacs-icons-dired
;;  :hook (dired-mode . treemacs-icons-dired-enable-once)
;;  :ensure t)
(use-package treemacs-magit :after (treemacs magit) :ensure t)
(use-package
 treemacs-nerd-icons
 :config (treemacs-load-theme "nerd-icons"))

;; Language setup
;; LSPs
(use-package eglot :ensure t :demand t)
(use-package
 eglot-booster
 :ensure (:host github :repo "jdtsmith/eglot-booster")
 :after eglot
 :config (eglot-booster-mode))
;; Treesitter
(use-package
 treesit-auto
 :ensure t
 :demand t
 :config (global-treesit-auto-mode))
;; Nix
(use-package
 nix-mode
 :ensure t
 :hook (nix-mode . eglot-ensure)
 :config
 (add-to-list 'eglot-server-programs '(nix-mode . ("nixd"))))
;; Markdown
(use-package
 markdown-mode
 :ensure t
 :config (setq markdown-fontify-code-blocks-natively t))
;; Python
(use-package
 python-mode
 :ensure t
 :after eglot
 :hook (python-mode . eglot-ensure))
;; Rust
(use-package
 rust-mode
 :ensure t
 :after eglot
 :hook (rust-mode . eglot-ensure))
;; YAML
(use-package
 yaml-mode
 :ensure t
 :after eglot
 :hook (yaml-mode . eglot-ensure))
;; Lisp
(use-package sly :ensure t)
(use-package
 elisp-autofmt
 :ensure t
 :commands (elisp-autofmt-mode elisp-autofmt-buffer)
 :hook (emacs-lisp-mode . elisp-autofmt-mode))

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
(use-package
 evil-org
 :ensure t
 :after org
 :hook (org-mode . (lambda () evil-org-mode))
 :config
 (require 'evil-org-agenda)
 (evil-org-agenda-set-keys)
 (setq evil-want-C-i-jump nil))
(use-package org-roam :ensure t :after org)


;; Make TRAMP go brrr
(setq
 remote-file-name-inhibit-locks t
 tramp-use-scp-direct-remote-copying t
 remote-file-name-inhibit-auto-save-visited t)
(connection-local-set-profile-variables
 'remote-direct-async-process
 '((tramp-direct-async-process . t)))
(connection-local-set-profiles
 '(:application tramp :protocol "scp") 'remote-direct-async-process)
(remove-hook
 'evil-insert-state-exit-hook #'doom-modeline-update-buffer-file-name)
(remove-hook 'find-file-hook #'doom-modeline-update-buffer-file-name)
(remove-hook 'find-file-hook 'forge-bug-reference-setup)
(setq magit-tramp-pipe-stty-settings 'pty)
