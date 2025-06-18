;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-search.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:30:37 2022 (+0200)
;; Last-Updated: Wed Jun 18 20:25:05 2025 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;----------------------------------------------------------------------------
;; Better grep
;;----------------------------------------------------------------------------
(use-package rg
  :ensure t
  :config
  (rg-define-search rg-c-mode
    "Search files in a C project"
    :dir (projectile-project-root)
    :files "*.[chCH]")
  (rg-define-search rg-all-mode
    "Search files of all types in a C project"
    :dir (projectile-project-root)
    :files "*")
  (setq rg-command-line-flags '("--sort path" "--hidden"))
  )

(provide 'init-search)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-search.el ends here
