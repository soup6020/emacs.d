;;; init-meow.el --- -*- lexical-binding: t; -*-
;; Meow as an alternative modal system to evil. It is loaded and its keys
;; are defined at startup, but meow-global-mode is left off: evil is the
;; default, and `soup6020/toggle-input-package' switches between the two.
;;
;; The general SPC leader (init-keys.el) is bound in evil states, so it goes
;; inert under meow; the definer's :global-prefix mirrors the whole tree to
;; C-SPC, which stays active regardless of modal system. Meow therefore keeps
;; its own SPC keypad leader and needs no remapping of the general bindings.

(defun soup6020/meow-setup ()
  "Define meow's default QWERTY keys (upstream suggested layout)."
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(defun soup6020/toggle-input-package ()
  "Toggle the modal editing system between evil-mode and meow."
  (interactive)
  (if (bound-and-true-p meow-global-mode)
      (progn
        (meow-global-mode -1)
        (evil-mode 1)
        (message "Modal editing: evil"))
    (progn
      (evil-mode -1)
      (meow-global-mode 1)
      (message "Modal editing: meow"))))

(defun soup6020/meow-leader-setup ()
  "Expose the general SPC leader on C-SPC inside meow's states.
The `leader-keys' definer (init-keys.el) binds the whole tree in evil's
state keymaps, so it is unreachable once evil is off and C-SPC falls back
to `set-mark-command'. General stores those bindings in the evil-normal
auxiliary of `general-override-mode-map'; grab that C-SPC sub-keymap (the
same mutable object later modules keep appending to) and bind it under
C-SPC in meow's normal and motion states."
  (let* ((aux (ignore-errors
                (evil-get-auxiliary-keymap general-override-mode-map 'normal)))
         (leader (and (keymapp aux) (keymap-lookup aux "C-SPC"))))
    (when (keymapp leader)
      (keymap-set meow-normal-state-keymap "C-SPC" leader)
      (keymap-set meow-motion-state-keymap "C-SPC" leader))))

(use-package meow
  :ensure t
  :demand t
  :config
  ;; App-modes that ship their own single-letter keymaps (integrated with
  ;; evil via evil-collection today). Start them in MOTION/INSERT so meow's
  ;; normal-state keys don't shadow the mode's bindings. add-to-list keeps
  ;; meow's built-in defaults intact.
  (dolist (entry '((magit-status-mode . motion)
                   (magit-log-mode . motion)
                   (magit-diff-mode . motion)
                   (dired-mode . motion)
                   (dirvish-mode . motion)
                   (treemacs-mode . motion)
                   (elfeed-search-mode . motion)
                   (elfeed-show-mode . motion)
                   (ibuffer-mode . motion)
                   (pdf-view-mode . motion)
                   (vterm-mode . insert)))
    (add-to-list 'meow-mode-state-list entry))
  ;; Define meow's keys but leave meow-global-mode off; evil stays the
  ;; default until soup6020/toggle-input-package is invoked.
  (soup6020/meow-setup)
  ;; Reach the general SPC leader via C-SPC under meow (init-keys.el loads
  ;; first, so the leader bindings already exist to be borrowed).
  (soup6020/meow-leader-setup))

(provide 'init-meow)
