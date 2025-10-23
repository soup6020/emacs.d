;; Dirvish
(use-package dired
 :config
 (setq
  dired-listing-switches
  "-l --almost-all --human-readable --group-directories-first --no-group")
 ;; this command is useful when you want to close the window of `dirvish-side'
 ;; automatically when opening a file
 (setq tab-bar-new-tab-choice '("dired" ".*" (tab-new-buffer-with-name (buffer-name)) nil nil))
 (put 'dired-find-alternate-file 'disabled nil))

(use-package dirvish
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

(provide 'init-dirvish)
