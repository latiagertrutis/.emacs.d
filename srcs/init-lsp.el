;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-lsp.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:55:15 2022 (+0200)
;; Last-Updated: Fri May  1 13:52:09 2026 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOTE: on clangd rememeber to use either compile_commands.json or compile_flags.txt
;; compile_commands.json can be generated with the Bear tool: https://github.com/rizsotto/Bear
;; in the C projects in order to find the includes

;; IMPORTANT: Do not add hooks here, lsp should not depend on anything since
;; many packages load lsp and if they go first this configuration will not be
;; loaded. For this reasons add lsp hooks on each individual package
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-;")
  :commands (lsp)
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
  :commands (lsp-ui-mode)
  :hook
  (lsp-mode . lsp-ui-mode)
  :bind
  ("C-c l" . lsp-ui-doc-toggle)
  ("C-x m" . lsp-ui-imenu)
  ("M-g r" . lsp-ui-peek-find-references)
  ("M-g d" . lsp-ui-peek-find-definitions)
  :bind (:map lsp-ui-imenu-mode-map
	      ("p" . lsp-ui-imenu--prev-kind)
	      ("n" . lsp-ui-imenu--next-kind))
  :config
  (setq lsp-ui-sideline-enable t
	lsp-ui-sideline-delay 1
	lsp-ui-sideline-diagnostic-max-line-length 90
	lsp-ui-doc-position 'at-point
        lsp-ui-imenu-enable t
	lsp-ui-sideline-ignore-duplicate t))

;; To provide consult-lsp for dirvish and others
(use-package consult-lsp)

(use-package company
  :defer 20
  ;; This is not perfect yet. It completes too quickly outside programming modes, but while programming it is just right.
  :custom
  (company-idle-delay 0.1)
  :custom-face
  (company-preview ((nil(:background "dark slate blue"))))
  :config
  (setq company-frontends '(company-preview-frontend)))

;; Better forntend for company
(use-package company-box
  :hook (company-mode . company-box-mode))

(provide 'init-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here
