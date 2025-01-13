;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-email.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Mon Jan 13 14:41:35 2025 (+0100)
;; Last-Updated: Mon Jan 13 14:47:35 2025 (+0100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package mu4e
  ;; Refer to https://systemcrafters.net/emacs-mail/streamline-your-email-with-mu4e/ for the doc
  :ensure t
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 20 ; Wait until 20 seconds after startup
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/.mail")

  (setq mu4e-drafts-folder "/[Posteo]/Drafts")
  (setq mu4e-sent-folder   "/[Posteo]/Sent Mail")
  (setq mu4e-refile-folder "/[Posteo]/All Mail")
  (setq mu4e-trash-folder  "/[Posteo]/Trash")

  (setq mu4e-maildir-shortcuts
      '(("/Inbox"             . ?i)
        ("/[Posteo]/Sent Mail" . ?s)
        ("/[Posteo]/Trash"     . ?t)
        ("/[Posteo]/Drafts"    . ?d)
        ("/[Posteo]/All Mail"  . ?a))))

(provide 'init-email)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-email.el ends here
