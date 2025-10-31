;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-lsp.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:55:15 2022 (+0200)
;; Last-Updated: Wed Oct 22 15:07:51 2025 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOTE: on clangd rememeber to use either compile_commands.json or compile_flags.txt
;; compile_commands.json can be generated with the Bear tool: https://github.com/rizsotto/Bear
;; in the C projects in order to find the includes

(use-package lsp-mode
  :ensure t
  :commands (lsp)
  :init
  (setq lsp-keymap-prefix "C-;")
  :hook
  (go-mode . lsp)
  (c-mode . lsp)
  (yaml-mode . lsp)
  (python-mode . lsp)
  (shell-script-mode . lsp)
  (rust-mode . lsp)
  :config
  (setq lsp-clients-clangd-args '("--background-index")
        lsp-enable-on-type-formatting nil
	lsp-signature-mode nil
	lsp-signature-auto-activate nil
        lsp-enable-indentation nil
	lsp-rust-analyzer-completion-add-call-parenthesis t
	lsp-rust-analyzer-completion-add-call-argument-snippets t
	lsp-rust-analyzer-completion-auto-import-enable nil))

(use-package lsp-ui
  :ensure t
  :ensure yasnippet
  :commands (lsp-ui-mode)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-mode . yas-minor-mode)
  :bind
  ("C-c l" . lsp-ui-doc-toggle)
  ("C-x m" . lsp-ui-imenu)
  ("M-g r" . lsp-ui-peek-find-references)
  ("M-g d" . lsp-ui-peek-find-definitions)
  :config
  (setq lsp-ui-sideline-enable t
	lsp-ui-sideline-delay 1
	lsp-ui-sideline-diagnostic-max-line-length 90
	lsp-ui-doc-position 'at-point
        lsp-ui-imenu-enable t
	lsp-ui-sideline-ignore-duplicate t))

(use-package company :ensure t :defer 20
  ;; This is not perfect yet. It completes too quickly outside programming modes, but while programming it is just right.
  :custom
  (company-idle-delay 0.1)
  (debug-on-error nil) ;; otherwise this throws lots of errors on completion errors
  :custom-face
  (company-preview ((nil(:background "dark slate blue"))))
  :config
  (setq company-frontends '(company-preview-frontend)))

;; Better forntend for company
(use-package company-box  
  :ensure t
  :hook (company-mode . company-box-mode))

(provide 'init-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here
