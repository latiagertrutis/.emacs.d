;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-lsp.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Mon Oct  5 09:22:44 2020 (+0200)
;; Last-Updated: vie abr 22 11:39:43 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOTE: on clangd rememeber to use either compile_commands.json or compile_flags.txt
;; compile_commands.json can be generated with the Bear tool: https://github.com/rizsotto/Bear
;; in the C projects in order to find the includes

(use-package lsp-mode
  :ensure t
  :commands (lsp)
  :hook
  (go-mode . lsp)
  (c-mode . lsp)
  :bind
  ("M-g r" . lsp-find-references)
  ("M-g d" . lsp-find-definition)
  :config
  (setq lsp-clients-clangd-args '("--background-index")))

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
