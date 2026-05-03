(defvar todo-irl "~/org/todo/todo-irl.org")
(defvar todo-it "~/org/todo/todo-it.org")
(defvar todo-work "~/org/school/work.org")

(defun soup6020/todo-open ()
  "Open primary org todo files in a split"
  (interactive)
  (find-file todo-irl)
  (split-window-right)
  (other-window 1)
  (find-file todo-it)
  (split-window-below)
  (other-window 1)
  (find-file todo-work))

(defun soup6020/indent-buffer ()
  "Indent the entire buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(provide 'site-functions)
