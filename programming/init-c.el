;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-c.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:58:11 2022 (+0200)
;; Last-Updated: dom ago  7 14:58:21 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c-mode-delete-trailing-whitespace ()
  (when (derived-mode-p 'c-mode)
    (delete-trailing-whitespace)))

(defun my-c-mode-hook ()
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode t
        c-block-comment-prefix "*"
        ))

(add-hook 'c-mode-hook 'my-c-mode-hook)

(add-hook 'c-mode-hook 'flycheck-mode)

(add-hook 'before-save-hook 'c-mode-delete-trailing-whitespace)

(provide 'init-c)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-c.el ends here
