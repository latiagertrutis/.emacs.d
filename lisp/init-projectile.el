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
             :config
             (projectile-mode +1)
             :bind
             (:map projectile-mode-map
                   ("s-p" . projectile-command-map)
                   ("C-c p" . projectile-command-map))
             :hook
             (after-init . projectile-mode))

(provide 'init-projectile)
