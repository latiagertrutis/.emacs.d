;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-interface.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 20:30:22 2022 (+0200)
;; Last-Updated: sáb ago  6 20:32:26 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package beacon
             :ensure t
             :config
             (setq-default beacon-lighter "")
             (setq-default beacon-size 20)
             :hook
             (after-init . beacon-mode))

(provide 'init-interface)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-interface.el ends here
