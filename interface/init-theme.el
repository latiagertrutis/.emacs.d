;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-theme.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 21:29:26 2022 (+0200)
;; Last-Updated: sáb ago  6 21:46:32 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;;default font
(add-to-list 'default-frame-alist '(font . "mononoki 12"))

(provide 'init-theme)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-theme.el ends here
