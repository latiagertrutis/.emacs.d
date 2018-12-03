;;=== GENERAL ================================================================

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'ws-butler-mode)
(global-set-key (kbd "C-c h") 'header-insert2)

;;=== PYTHON =================================================================

(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			(setq python-indent 4)
			(setq tab-width 4)))

;;=== C SHARP =================================================================

(add-hook 'csharp-mode-hook 'omnisharp-mode)
(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'flycheck-mode)

(provide 'init_hooks)
