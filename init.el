;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 19:49:50 2022 (+0200)
;; Last-Updated: sáb ago  6 20:33:44 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load source file paths
(add-to-list 'load-path (expand-file-name "package_management" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "interface" user-emacs-directory))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package management config
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-repository)
(require 'init-package-manager)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interface Enhancement config
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-interface)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
