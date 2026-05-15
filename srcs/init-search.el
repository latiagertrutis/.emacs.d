;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-search.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:30:37 2022 (+0200)
;; Last-Updated: Fri May  1 13:50:54 2026 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;----------------------------------------------------------------------------
;; Better grep
;;----------------------------------------------------------------------------

(defun my/project-root-or-default ()
  (or (projectile-project-root)
      (magit-toplevel)
      (expand-file-name default-directory)
      ((expand-file-name "~")))
  )

(use-package rg
  :config
  (rg-define-search rg-c-mode
    "Search files in a C project"
    :dir (my/project-root-or-default)
    :files "*.[chCH]")
  (rg-define-search rg-all-mode
    "Search files of all types in a C project"
    :dir (my/project-root-or-default)
    :files "*")
  (setq rg-command-line-flags '("--sort path" "--hidden" "--multiline"))
  :bind
  ("C-c w" . rg-all-mode)
  )

(provide 'init-search)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-search.el ends here
