;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-search.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:30:37 2022 (+0200)
;; Last-Updated: mar sep  6 12:19:57 2022 (+0200)
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
  (setq rg-command-line-flags '("--pcre2"))
  :bind
  ("C-c r" . rg-c-mode)
  ("C-c w" . rg-all-mode)
  )

(provide 'init-search)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-search.el ends here
