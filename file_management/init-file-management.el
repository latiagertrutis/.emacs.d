;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-file-management.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:18:22 2022 (+0200)
;; Last-Updated: mié abr 19 15:10:44 2023 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; get rid of backup files
;; Don't clutter up directories with files~
(setq dotfiles-dir (expand-file-name "dotfiles" user-emacs-directory))

(unless (file-directory-p dotfiles-dir)
  (make-directory dotfiles-dir))

(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; Don't clutter with #files either
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name (concat dotfiles-dir "backups")))))

(use-package ztree
  :ensure t
  :custom-face
  (ztreep-diff-model-add-face ((nil(:foreground "chartreuse"))))
  (ztreep-diff-model-diff-face ((nil(:foreground "coral"))))
  (ztreep-diff-model-normal-face ((nil(:foreground "gainsboro")))))

(setq dired-recursive-copies 'always)

(provide 'init-file-management)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-file-management.el ends here
