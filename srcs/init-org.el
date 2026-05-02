;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-org.el
;; Description: Ref: https://www.i3s.unice.fr/~malapert/emacs_orgmode.html
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: mar sep  6 11:45:11 2022 (+0200)
;; Last-Updated: Fri May  1 14:08:57 2026 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Org roam

(use-package org-roam
  
  :custom
  (org-roam-directory "~/.org-roam")
  :config
  (org-roam-db-autosync-mode)
  :bind
  ("C-c n i" . org-roam-node-insert)
  ("C-c n f" . org-roam-node-find)
  ("C-c n c" . org-roam-capture)
  )


(defun my/org-roam-git-sync ()
  (let ((current-file (buffer-file-name)))
    (when (org-roam-db-query `[:select id :from nodes :where (= file ,current-file)])
      (setq gac-automatically-push-p t)
      (git-auto-commit-mode))))

(use-package git-auto-commit-mode
  :after org-roam
  :hook (org-mode . my/org-roam-git-sync))

(with-eval-after-load 'org
  (keymap-set org-mode-map "C-;" #'org-shiftleft)
  (keymap-set org-mode-map "C-'" #'org-shiftright)
  (keymap-set org-mode-map "M-p" #'org-publish-current-project)
  (setq org-startup-truncated nil
	org-return-follows-link t
	org-duration-format 'h:mm
	org-clock-persist nil))

(defun my/org-clock-table-report-hours ()
  (interactive)
  (let ((org-clock-clocktable-default-properties
	 '(:scope subtree
		  :maxlevel 2
		  :link t
		  :properties ("EUR")
		  :formula "@4$1..@>$1=$4*14;t"
		  :formatter my/org-table-clock-report-formatter)))
    (org-clock-report)))

(defun my/org-table-clock-report-formatter (&rest args)
  "Custom clocktable writer.
Uses the default writer but shifts the first column right."
  (apply #'org-clocktable-write-default args)
  (save-excursion
    (forward-char) ;; move into the first table field
    (org-table-move-column-right)
    (org-table-move-column-right)
    (org-table-move-column-right)))

(use-package org-roam-walker
  :straight (org-roam-walker :type git
			     :repo "ssh://git@hub.sealcode.org/source/org-roam-walker.git"))

;; Example on configuring org-publish.
;; NOTE: Use org-<format>-publish, not org-<format>-export
;; (setq org-publish-project-alist
;;       `(("org-roam-badass"
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
;; 					     t)))
;; 	("org-roam-walker"
;; 	 :base-directory "~/.org-roam/"
;; 	 :base-extension "org"
;; 	 :exclude ".*"
;; 	 :include ("20260209190229-org_roam_walker.org")
;; 	 :publishing-function (org-md-publish-to-md)
;; 	 :publishing-directory "~/workspace/org-roam-walker/"
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
