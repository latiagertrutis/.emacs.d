;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-console.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: mié ago 10 17:17:10 2022 (+0200)
;; Last-Updated: mié ago 10 17:18:30 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vterm
  :ensure t
  :bind (("C-c t" . vterm)
         :map vterm-mode-map
         ("C-y" . vterm-yank)))

(use-package eshell-prompt-extras
  :ensure t
  :config
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status
        helm-eshell-fuzzy-match t))

;; Add Helm support to eshell complete:
;; https://github.com/emacs-helm/helm/wiki/Eshell#completion
(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
            (define-key eshell-mode-map (kbd "M-p") 'helm-eshell-history)))

;; Alias definition
(defalias 'o 'find-file)
(defalias 'oo 'find-file-other-window)

(provide 'init-console)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-console.el ends here
