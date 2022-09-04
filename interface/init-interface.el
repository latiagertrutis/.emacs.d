;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-interface.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 20:30:22 2022 (+0200)
;; Last-Updated: dom sep  4 22:25:41 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;----------------------------------------------------------------------------
;; Suppress GUI features
;;----------------------------------------------------------------------------

(menu-bar-mode -1)

(setq use-file-dialog nil)

(setq use-dialog-box nil)

(setq inhibit-startup-screen t)

(setq-default cursor-type 'bar)

;;----------------------------------------------------------------------------
;; Window size and features
;;----------------------------------------------------------------------------
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Save session
(desktop-save-mode 1)

(setq user-full-name "Mateo Rodriguez Ripolles (teorodrip@posteo.net)")

(global-hl-line-mode +1)

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

(use-package linum-relative
  :ensure t
  :config
  (setq linum-relative-backend 'display-line-numbers-mode)
  )

(provide 'init-interface)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-interface.el ends here
