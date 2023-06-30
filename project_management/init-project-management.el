;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-project-management.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:43:21 2022 (+0200)
;; Last-Updated: vie jun 30 18:27:07 2023 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-generate-projects-dirs (root-workspace)
  (setq projects-list '())
  (dolist (dir (directory-files root-workspace t "Sprint_.*"))
    (setq projects-list (append projects-list (directory-files dir t "EMB-.*"))))
  projects-list)

(use-package projectile
             :ensure t
             :ensure helm-projectile
             :ensure ibuffer-projectile
             :config
             (projectile-mode +1)
             (setq projectile-indexing-method 'alien
                   projectile-project-root-files #'(".projectile")
		   projectile-project-search-path (my-generate-projects-dirs "~/workspace")
                   projectile-project-root-files-functions #'(projectile-root-top-down
                                                              projectile-root-top-down-recurring
                                                              projectile-root-bottom-up
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
