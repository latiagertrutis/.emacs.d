;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-telega.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Wed Feb 26 12:50:19 2025 (+0100)
;; Last-Updated: Tue May 13 22:24:35 2025 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun telega-chat-other-window ()
  (interactive)
  (let ((chat (telega-chat-for-interactive)))
    (if chat
	(progn
	  (when (one-window-p)
	    (split-window-right))
	  (other-window 1)
	  (telega-chat-with chat))
      (message "No Chat Found!"))))

(use-package telega
  :ensure t
  :config
  (setq telega-use-docker t
	telega-msg-delimiter (propertize "\n" 'line-spacing 0.5)
	telega-root-default-view-function #'telega-view-grouping
	telega-completing-read-function #'completing-read)
  :bind
  (:map telega-root-mode-map ("<return>" . telega-chat-other-window))
  :bind-keymap
  ("C-c C-t" . telega-prefix-map)
  )

(provide 'init-telega)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-telega.el ends here
