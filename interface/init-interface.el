;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-interface.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 20:30:22 2022 (+0200)
;; Last-Updated: dom ago  7 15:23:07 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-hl-line-mode +1)

(menu-bar-mode -1)

(setq-default cursor-type 'bar)

(setq user-full-name "Mateo Rodriguez Ripolles (teorodrip@posteo.net)")

;; Custom faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:inherit isearch))))
 '(hl-line ((t (:background "#383838")))))

;;default font
(add-to-list 'default-frame-alist '(font . "mononoki 12"))


(use-package beacon
             :ensure t
             :config
             (setq-default beacon-lighter "")
             (setq-default beacon-size 20)
             :hook
             (after-init . beacon-mode))

(provide 'init-interface)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-interface.el ends here
