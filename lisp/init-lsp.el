;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-lsp.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Mon Oct  5 09:22:44 2020 (+0200)
;; Last-Updated: jue oct 14 13:22:09 2021 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOTE: rememeber to use either compile_commands.json or compile_flags.txt
;; in the C projects in order to find the includes

(use-package lsp-mode
  :ensure t
  :commands (lsp)
  :hook
  (go-mode . lsp)
  (c-mode . lsp))

(use-package lsp-ui
  :ensure t
  :commands (lsp-ui-mode)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-mode . yas-minor-mode)
  :bind
  ("C-c l" . lsp-ui-doc-mode)
  :config
  (define-key lsp-ui-mode-map
    [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map
    [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable t
        lsp-ui-flycheck-enable nil
        lsp-ui-imenu-enable t
	lsp-ui-sideline-ignore-duplicate t))

(provide 'init-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here
