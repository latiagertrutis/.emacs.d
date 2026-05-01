;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-console.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: mié ago 10 17:17:10 2022 (+0200)
;; Last-Updated: Fri May  1 13:52:00 2026 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vterm
  
  :bind (:map vterm-mode-map
         ("C-y" . vterm-yank)))

(defun multi-vterm-other-window ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (multi-vterm))

(use-package multi-vterm
  
  :bind ("C-c t" . multi-vterm)
  ("C-c o" . multi-vterm-other-window))

;; Disable hl-line in major console modes
(add-hook 'comint-mode-hook (lambda () (setq-local global-hl-line-mode nil)))

;; Do not prompt for confirmation when killing buffer
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(use-package eshell-prompt-extras
  
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
