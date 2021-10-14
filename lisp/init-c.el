;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-c.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Thu Jan 28 11:12:29 2021 (+0100)
;; Last-Updated: Thu Oct 14 13:34:11 2021 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c-mode-delete-trailing-whitespace ()
  (when (derived-mode-p 'c-mode)
    (delete-trailing-whitespace)))

(add-hook 'c-mode-hook 'flycheck-mode)

(add-hook 'before-save-hook 'c-mode-delete-trailing-whitespace)

(provide 'init-c)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-c.el ends here
