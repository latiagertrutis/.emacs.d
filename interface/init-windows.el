;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-windows.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 20:43:28 2022 (+0200)
;; Last-Updated: sáb ago  6 20:49:30 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package switch-window
             :ensure t
             :config
             (setq switch-window-shortcut-style 'alphabet)
             (setq switch-window-timeout nil)
	     (setq switch-window-minibuffer-shortcut ?z)
             :bind
             ("C-x o" . switch-window))

(provide 'init-windows)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-windows.el ends here
