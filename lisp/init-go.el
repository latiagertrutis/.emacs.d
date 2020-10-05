;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-go.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Mon Oct  5 09:28:53 2020 (+0200)
;; Last-Updated: Mon Oct  5 12:18:32 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :ensure t
  :config
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  (flycheck-mode)
  (add-hook 'go-mode-hook 'company-mode)
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'go-mode-hook #'flycheck-mode)
  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
  (add-hook 'go-mode-hook '(lambda ()
			     (setq tab-width 4)))
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))

(provide 'init-go)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-go.el ends here
