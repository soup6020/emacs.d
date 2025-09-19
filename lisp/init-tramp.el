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

(provide 'init-tramp)
