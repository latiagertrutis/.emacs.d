;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-org.el
;; Description: Ref: https://www.i3s.unice.fr/~malapert/emacs_orgmode.html
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: mar sep  6 11:45:11 2022 (+0200)
;; Last-Updated: Mon Feb  9 16:51:09 2026 (+0100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Org roam

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/.org-roam")
  :config
  (org-roam-db-autosync-mode)
  :bind
  ("C-c n i" . org-roam-node-insert)
  ("C-c n f" . org-roam-node-find)
  ("C-c n c" . org-roam-capture)
  )

(eval-after-load "org"
  '(progn
     (keymap-set org-mode-map "C-;" #'org-shiftleft)
     (keymap-set org-mode-map "C-'" #'org-shiftright)
     (setq org-startup-truncated nil)
     ))

(provide 'init-org)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here
