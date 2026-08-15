;;; init.el --- -*- lexical-binding: t; -*-
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
(add-to-list
 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Immediately load elpaca and use-package
(require 'init-elpaca)

;; Misc emacs options, mostly self explanatory
(use-package
  emacs
  ;; Revert the GC hack from early-init.el to minimize startup time
  :hook
  (emacs-startup
   . (lambda () (setq gc-cons-threshold (* 8 1024 1024))))
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

  (if (boundp 'use-short-answers)
      (setopt use-short-answers t)
    (fset 'yes-or-no-p 'y-or-n-p))

  ;; Hide pesky backup files
  (setq backup-directory-alist `(("." . "~/.config/emacs/backups")))
  (setq auto-save-file-name-transforms
        `((".*" "~/.config/emacs/saves/" t)))
  (unless (file-exists-p "~/.config/emacs/backups")
    (make-directory "~/.config/emacs/backups"))
  (unless (file-exists-p "~/.config/emacs/saves")
    (make-directory "~/.config/emacs/saves"))

  (setq backup-by-copying t)
  (setq
   delete-old-versions t
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

  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

  ;; Cosmetics
  (set-face-attribute 'default nil
                      ;;                    ;; Conditionally set font settings, specify a bunch of OLED stuff on pgtk because Emacs happily ignores fontconfig.
                      ;;                    ;; Fall back to basic font otherwise
                      ;;                    :font (cond
                      ;;                           ((eq window-system 'x) "Lilex Nerd Font Mono:antialias=true:hintstyle=hintslight:rgba=none:lcdfilter=none")
                      ;;                           ((eq window-system 'pgtk) "Lilex Nerd Font Mono:antialias=true:hintstyle=hintslight:rgba=none:lcdfilter=none")
                      ;;                           (t "Lilex Nerd Font Mono"))
                      ;;                    :height 120)
                      :font "Lilex Nerd Font Mono:antialias=true:hintstyle=hintslight:rgba=none:lcdfilter=none"
                      :height 120)
  
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . light))
  (setq ns-use-proxy-icon nil)
  (setq frame-title-format nil)
  ;; Open a fresh empty buffer in each new tab
  (setq tab-bar-new-tab-choice
        (lambda () (switch-to-buffer (generate-new-buffer "*new*"))))

  ;; Enhanced world clock
  (setq world-clock-list
        '(("America/Vancouver" "Pacific Time")
          ("America/Edmonton" "Mountain Time")
          ("America/Detroit" "Eastern Time")
          ("Asia/Kolkata" "India")
          ("Asia/Tokyo" "Japan")))

  ;; Massively increase undo limits (default is 0.15mb)
  (setq undo-limit 67108864) ; 64mb.
  (setq undo-strong-limit 100663296) ; 96mb.
  (setq undo-outer-limit 1006632960) ; 960mb.

  ;; Minor optimizations and stolen tweaks
  ;; https://emacsredux.com/blog/2026/04/07/stealing-from-the-best-emacs-configs/
  ;; Disable Bidirectional Text Scanning
  (setq-default
   bidi-display-reordering 'left-to-right
   bidi-paragraph-direction 'left-to-right)
  (setq bidi-inhibit-bpa t)
  ;; Increase Process Output Buffer for LSP
  (setq read-process-output-max (* 4 1024 1024)) ; 4MB
  ;; Do not save duplicate entries into clipboard
  (setq kill-do-not-save-duplicates t)
  ;; Proportional Window Resizing
  (setq window-combination-resize t)

  ;; Fix manpage rendering
  (require 'ansi-osc)
  (add-hook 'Man-cooked-hook
            (lambda () (ansi-osc-apply-on-region (point-min) (point-max))))

  ;; Line numbers by default in programming modes
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  ;; F7 to toggle line number display globally
  (defun prot/toggle-line-numbers ()
    "Toggles the display of line numbers.  Applies to all buffers."
    (interactive)
    (if (bound-and-true-p display-line-numbers-mode)
        (display-line-numbers-mode -1)
      (display-line-numbers-mode)))

  ;; Confirm before closing frame
  (defun ask-before-closing ()
    "Prompt for confirmation before exiting emacsclient."
    (interactive)
    (if (y-or-n-p "Really exit this emacsclient? ")
        (save-buffers-kill-terminal)
      (message "Canceled exit")))

  (when (daemonp)
    (global-set-key (kbd "C-x C-c") #'ask-before-closing))

  :bind (("<f7>" . prot/toggle-line-numbers)))


;; This doesn't really work, but try before package declarations anyway
(use-package no-littering :ensure t :demand t)

;; Smooth scrolling
(use-package ultra-scroll
  :ensure (:host github :repo "jdtsmith/ultra-scroll")
  ;; `use-package-always-defer' is t, and nothing autoloads this package, so
  ;; without :demand the :config below would never run.
  :demand t
  :init
  (setq scroll-conservatively 3
        scroll-margin 0)
  :config (ultra-scroll-mode 1))

;;; Load some packages
;;; Inspired by purcell's config

;; Cosmetics
(require 'init-themes)
(require 'init-prism)
;; Input
(require 'init-evil)
(require 'init-keys)
(require 'init-meow)
;; Function
(require 'init-modeline)
;; Turned off for now because it does weird things
;;(require 'init-tabline)
(require 'init-completion)
(require 'init-embark)
(require 'init-org)
;; Language feature support
(require 'init-eglot)
(require 'init-treesit)
(require 'init-flymake)
(require 'init-apheleia)
;; Languages and major modes
(require 'init-c)
(require 'init-nix)
(require 'init-markdown)
(require 'init-elisp)
(require 'init-nushell)
(require 'init-rust)
(require 'init-nginx)
(require 'init-python)
(require 'init-yaml)

;; Applications
(require 'init-term)
(require 'init-treemacs)
(require 'init-projectile)
(require 'init-rg)
(require 'init-dirvish)
(require 'init-magit)
(require 'init-tramp)
(require 'init-pdf)
(require 'init-elfeed)
(require 'init-rmsbolt)
(require 'init-nhexl)
(require 'init-calfw)
;; Site functions (custom commands)
(require 'site-functions)
;; Dashboard
(require 'init-dashboard)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9"
     default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
