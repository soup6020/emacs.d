;;; site-functions.el --- -*- lexical-binding: t; -*-
(defvar todo-irl "~/org/todo/todo-irl.org")
(defvar todo-work "~/org/todo/work.org")
(defvar todo-it "~/org/todo/todo-it.org")
(defvar todo-school "~/org/school/work.org")

(defun soup6020/todo-open ()
  "Open primary org todo files in a 2x2 grid."
  (interactive)
  (delete-other-windows)
  (let* ((tl (selected-window))
         (bl (split-window tl nil 'below))
         (windows (list tl (split-window tl nil 'right)
                        bl (split-window bl nil 'right))))
    (seq-mapn (lambda (win file)
                (set-window-buffer win (find-file-noselect file)))
              windows
              (list todo-irl todo-work todo-it todo-school))
    (balance-windows)
    (select-window tl)))

(defun soup6020/indent-buffer ()
  "Indent the entire buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(provide 'site-functions)
