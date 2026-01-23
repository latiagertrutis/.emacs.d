;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-robot.el
;; Description:
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer:
;; Created: Mon Apr 21 19:26:13 2025 (+0200)
;; Last-Updated: Fri Jan 23 19:07:16 2026 (+0100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-robot-mode-format ()
  (interactive)
  ;; Call shell-command-to-string to discard output
  (shell-command-to-string (format "robocop format %s" buffer-file-name))
  (revert-buffer nil 't))

(use-package robot-mode
  :ensure t
  :hook
  ;; https://emacs.stackexchange.com/questions/5452/before-save-hook-for-cc-mode
  (robot-mode . (lambda () (add-hook 'after-save-hook #'my-robot-mode-format nil 'local))))

(provide 'init-robot)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-robot.el ends here
