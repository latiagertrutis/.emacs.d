;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-project-management.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:43:21 2022 (+0200)
;; Last-Updated: Fri May  1 13:52:19 2026 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-indexing-method 'alien
        projectile-project-root-files #'(".projectile")
        projectile-project-root-files-functions #'(projectile-root-bottom-up
						   projectile-root-marked
						   projectile-root-top-down
                                                   projectile-root-top-down-recurring
                                                   projectile-root-local))
  :bind
  (:map projectile-mode-map
        ("s-p" . projectile-command-map)
        ("C-c p" . projectile-command-map))
  :hook
  (after-init . projectile-mode))

(provide 'init-project-management)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-project-management.el ends here
