;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-mode-line.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 21:11:59 2022 (+0200)
;; Last-Updated: sáb ago  6 21:42:59 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-vcs-max-length 80)
  (setq doom-modeline-buffer-encoding nil)
)

(provide 'init-mode-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-mode-line.el ends here
