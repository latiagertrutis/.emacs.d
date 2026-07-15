(defun my-nushell-mode-format ()
  (interactive)
  ;; Call shell-command-to-string to discard output
  (shell-command-to-string (format "nufmt %s" buffer-file-name))
  (revert-buffer nil 't))

(use-package nushell-mode
  :hook
  (nushell-mode . lsp)
  (nushell-mode . (lambda () (add-hook 'after-save-hook #'my-nushell-mode-format nil 'local))))

(defun my-postgres-mode-format ()
  (interactive)
  ;; Call shell-command-to-string to discard output
  (shell-command-to-string (format "pg_format -i %s" buffer-file-name))
  (revert-buffer nil 't))

(add-hook 'sql-mode-hook (lambda () (add-hook 'after-save-hook #'my-postgres-mode-format nil 'local)))

(provide 'init-shell)
