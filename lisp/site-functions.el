(defvar todo-irl "~/org/todo/todo-irl.org")
(defvar todo-it "~/org/todo/todo-it.org")

(defun todo-open-soup6020 ()
  "Open primary org todo files in a split"
  (interactive)
  (find-file todo-irl)
  (split-window-right)
  (other-window 1)
  (find-file todo-it))

(provide 'site-functions)
