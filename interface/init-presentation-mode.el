(defun my/start-presentation ()
  (setq-local visual-fill-column-width 110
	      visual-fill-column-center-text t)

  ;; Tweak font sizes
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.5) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))

  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")
  
  ;; Display inline images automatically
  (org-display-inline-images)

  ;; Put window in full screen
  (toggle-frame-fullscreen)
  (delete-other-windows)

  ;; Disable mode line
  (doom-modeline-mode)
  (setq mode-line-format nil)

  ;; Present mode settings
  (org-present-read-only)
  (org-present-hide-cursor)

  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my/end-presentation ()
  ;; Clear the header line string so that it isn't displayed
  (setq header-line-format nil)
  
  ;; Put window in full screen
  (toggle-frame-fullscreen)

  ;; Enable mode line
  (doom-modeline-mode)

  ;; Clean the original buffer
  (find-alternate-file (buffer-file-name)))

(use-package org-present
  :ensure t
  :config
  ;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch :font "mononoki")
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch) :font "mononoki")
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  :bind
  (:map org-present-mode-keymap
	("M-<" . org-present-beginning)
	("M->" . org-present-end)
	("q" . org-present-quit)
	("n" . org-present-next)
	("p" . org-present-prev))
  :hook
  (org-present-mode . my/start-presentation)
  (org-present-mode-quit . my/end-presentation))

(provide 'init-presentation-mode)
