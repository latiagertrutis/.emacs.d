;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-c.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Thu Jan 28 11:12:29 2021 (+0100)
;; Last-Updated: lun abr  4 11:48:28 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c-mode-delete-trailing-whitespace ()
  (when (derived-mode-p 'c-mode)
    (delete-trailing-whitespace)))

(defun my-c-mode-hook ()
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode t
        lsp-enable-indentation nil
        ))

(add-hook 'c-mode-hook 'my-c-mode-hook)

(add-hook 'c-mode-hook 'flycheck-mode)

(add-hook 'before-save-hook 'c-mode-delete-trailing-whitespace)

(provide 'init-c)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-c.el ends here
