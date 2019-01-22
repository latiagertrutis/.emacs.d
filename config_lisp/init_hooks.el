;;=== GENERAL ================================================================

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'ws-butler-mode)
(global-set-key (kbd "C-c h") 'header-insert2)

;;=== C ================================================================

(add-hook 'c-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			(setq backward-delete-char-untabify-method 'all)
			(setq tab-width 2)
			(setq c-basic-offset 2)
			))
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'irony-mode)

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

;;=== C++ =================================================================

(add-hook 'c++-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			(setq backward-delete-char-untabify-method 'all)
			(setq tab-width 2)
			(setq c-basic-offset 2)
			))
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'irony-mode)

(provide 'init_hooks)
