;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-lsp.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:55:15 2022 (+0200)
;; Last-Updated: dom ago  7 14:56:21 2022 (+0200)
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
  :bind
  ("M-g r" . lsp-find-references)
  ("M-g d" . lsp-find-definition)
  :config
  (setq lsp-clients-clangd-args '("--background-index")
        lsp-enable-on-type-formatting nil
	lsp-signature-mode nil
        lsp-enable-indentation nil))

(use-package lsp-ui
  :ensure t
  :commands (lsp-ui-mode)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-mode . yas-minor-mode)
  :bind
  ("C-c l" . lsp-ui-doc-mode)
  ("C-x m" . lsp-ui-imenu)
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable nil
        lsp-ui-imenu-enable t
	lsp-ui-sideline-ignore-duplicate t))

(provide 'init-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here
