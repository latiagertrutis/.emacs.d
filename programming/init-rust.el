(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save t)
  :hook
  (rustik-mode . rustic-mode-hook))

(defun rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

(provide 'init-rust)
