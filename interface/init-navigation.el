;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-navigation.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 21:00:04 2022 (+0200)
;; Last-Updated: sáb ago  6 21:01:48 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package avy
             :ensure t
             :config
             (global-set-key (kbd "C-o") 'avy-goto-char-timer))

;; Show number of matches while searching
(use-package anzu
             :ensure t
             :hook
             (after-init . global-anzu-mode)
             :config
             (setq anzu-mode-lighter "")
             (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
             (global-set-key [remap query-replace] 'anzu-query-replace))

(provide 'init-navigation)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-navigation.el ends here
