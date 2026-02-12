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
     (keymap-set org-mode-map "M-p" #'org-publish-current-project)
     (setq org-startup-truncated nil)
     ))
;; Example on configuring org-publish.
;; NOTE: Use org-<format>-publish, not org-<format>-export
;; (setq org-publish-project-alist
;;       `(("org-roam"
;; 	 :base-directory "~/.org-roam/"
;; 	 :base-extension "org"
;; 	 :exclude ".*badass\.org"
;; 	 :publishing-function org-org-publish-to-org
;; 	 :publishing-directory "~/Documents/"
;; 	 :recursive t
;; 	 )
;; 	("org-roam-badass"
;; 	 :base-directory "~/.org-roam/"
;; 	 :base-extension "org"
;; 	 :exclude ".*"
;; 	 :include ("20260209163815-badass.org")
;; 	 :publishing-function (org-md-publish-to-md)
;; 	 :publishing-directory "~/workspace/BADASS/"
;; 	 :completion-function (lambda (plist)
;; 				(rename-file (concat
;; 					      (plist-get plist :publishing-directory)
;; 					      (file-name-with-extension
;; 					       (car (plist-get plist :include)) "md"))
;; 					     (concat
;; 					      (plist-get plist :publishing-directory)
;; 					      "README.md")
;; 					     t)))))

(provide 'init-org)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here
