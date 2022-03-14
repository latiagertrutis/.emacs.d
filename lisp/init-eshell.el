;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-eshell.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: mié feb 23 16:14:27 2022 (+0100)
;; Last-Updated: lun mar 14 12:17:58 2022 (+0100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(provide 'init-eshell)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-eshell.el ends here
