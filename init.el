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
(unless (window-system)
  (xterm-mouse-mode 1))

;; Enable right click context menu in all relevant modes
(add-hook 'text-mode-hook 'context-menu-mode)
(add-hook 'prog-mode-hook 'context-menu-mode)
(add-hook 'shell-mode-hook 'context-menu-mode)
(add-hook 'dired-mode-hook 'context-menu-mode)

;; lisp userdir - required for elpaca
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Immediately load elpaca and use-package
(require 'init-elpaca)

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
 (setq backup-directory-alist `(("." . "~/.config/emacs/backups")))
 (setq auto-save-file-name-transforms
       `((".*" "~/.config/emacs/saves/" t)))
 (unless (file-exists-p "~/.config/emacs/backups")
   (make-directory "~/.config/emacs/backups"))
(unless (file-exists-p "~/.config/emacs/saves")
  (make-directory "~/.config/emacs/saves"))
 
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

 ;; Enhanced world clock
 (setq world-clock-list
       '(("America/Vancouver" "Vancouver")
        ("America/Edmonton" "Edmonton")
        ("Europe/Paris" "France")
        ("Asia/Kolkata" "India")
        ("Asia/Tokyo" "Japan")))

 
 ;; Line numbers by default in programming modes
 (add-hook 'prog-mode-hook 'display-line-numbers-mode)
 ;; F7 to toggle line number display globally
 (defun prot/toggle-line-numbers ()
   "Toggles the display of line numbers.  Applies to all buffers."
   (interactive)
   (if (bound-and-true-p display-line-numbers-mode)
       (display-line-numbers-mode -1)
     (display-line-numbers-mode)))
 :bind (("<f7>" . prot/toggle-line-numbers)))

;; This doesn't really work, but try before package declarations anyway
(use-package no-littering :ensure t :demand t)

;;; Load some packages
;;; Inspired by purcell's config

;; Cosmetics
(require 'init-themes)
;; Input
(require 'init-evil)
(require 'init-keys)
;; Function
(require 'init-modeline)
(require 'init-completion)
(require 'init-embark)
(require 'init-org)
;; Language support
(require 'init-eglot)
(require 'init-treesit)
(require 'init-elisp)
(require 'init-flymake)
;; Applications
(require 'init-term)
(require 'init-treemacs)
(require 'init-projectile)
(require 'init-dirvish)
(require 'init-magit)
(require 'init-tramp)
;; Dashboard
(require 'init-dashboard)
