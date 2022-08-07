;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-version-control.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 15:19:00 2022 (+0200)
;; Last-Updated: dom ago  7 15:19:21 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package magit
  :ensure t
  :init
  (use-package fullframe
    :ensure t)
  :config
  (setq-default magit-diff-refine-hunk t)
  (fullframe magit-status magit-mode-quit-window)
  :bind
  ("C-x g" . magit-status))

(provide 'init-version-control)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-version-control.el ends here
