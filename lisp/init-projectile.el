;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-projectile.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Thu Sep 10 09:58:30 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package projectile
             :ensure t
             :ensure helm-projectile
             :ensure ibuffer-projectile
             :config
             (projectile-mode +1)
             (setq projectile-indexing-method 'alien
                   projectile-project-root-files #'(".projectile")
                   projectile-project-root-files-functions #'(projectile-root-top-down
                                                              projectile-root-top-down-recurring
                                                              projectile-root-bottom-up
                                                              projectile-root-local))
             (projectile-register-project-type 'c '(".cproject")
                                               :project-file ".cproject")
             :bind
             (:map projectile-mode-map
                   ("s-p" . projectile-command-map)
                   ("C-c p" . projectile-command-map))
             :hook
             (after-init . projectile-mode))

(provide 'init-projectile)
