;; -*- lexical-binding: t; -*-

(require 'auth-source)

(setq auth-sources '("~/.authinfo")
      auth-source-cache-tokens nil)

(defconst my/posteo-imap-server "posteo.de"
  "IMAP server used by both Posteo accounts.")

(defconst my/posteo-smtp-server "posteo.de"
  "SMTP server used by both Posteo accounts.")

(defconst my/mu4e-accounts
  '(("work"
     :address  "madvise@posteo.net"
     :full-name "Madvise"
     :smtp-user "madvise@posteo.net"
     :maildir  "/posteo-work")
    ("personal"
     :address  "teorodrip@posteo.net"
     :full-name "Mateo Rodriguez"
     :smtp-user "teorodrip@posteo.net"
     :maildir  "/posteo-personal")))

(defun my/mu4e-context-match (address)
  "Return a `mu4e-context' :match-func matching ADDRESS.
The context is selected when ADDRESS appears in From, To or Cc of the
current message."
  (lambda (msg)
    (when msg
      (let ((addrs (mapcar (lambda (field)
                             (mapcar #'cdr (mu4e-message-field msg field)))
                           '(:from :to :cc))))
        (when (member address (apply #'append addrs))
          t)))))

(use-package mu4e
  :init
  (setq mu4e-maildir "~/.mail"

        ;; Retrieval is delegated to isync/mbsync; credentials for the
        ;; IMAP connection are taken from auth-source (see above).
        mu4e-get-mail-command "mbsync --all"
        mu4e-update-interval 300
        mu4e-update-in-background t
        mu4e-change-filenames-when-moving t

        mu4e-confirm-quit nil
        mu4e-attachment-dir "~/Downloads"
        mu4e-sent-messages-behavior 'delete
        mu4e-view-show-images t
        mu4e-compose-format-flowed t
        message-kill-buffer-on-exit t

        ;; SMTP: never inline passwords, let auth-source supply them.
        smtpmail-smtp-server my/posteo-smtp-server
        smtpmail-smtp-service 587
        smtpmail-stream-type 'starttls
        smtpmail-debug-info nil)
  :config
  ;; --- Contexts ---------------------------------------------------------
  (setq mu4e-contexts
        (mapcar
         (lambda (account)
           (let* ((name    (car account))
                  (cfg     (cdr account))
                  (address (plist-get cfg :address))
                  (root    (plist-get cfg :maildir)))
             (make-mu4e-context
              :name name
              :enter-func (lambda ()
                            (mu4e-message (format "Switching to %s" name)))
              :leave-func (lambda () nil)
              :match-func (my/mu4e-context-match address)
              :vars `((user-full-name      . ,(plist-get cfg :full-name))
                      (user-mail-address   . ,address)
                      (mu4e-sent-folder    . ,(concat root "/Sent"))
                      (mu4e-drafts-folder  . ,(concat root "/Drafts"))
                      (mu4e-trash-folder   . ,(concat root "/Trash"))
                      (mu4e-refile-folder  . ,(concat root "/Archive"))
                      (smtpmail-smtp-user  . ,(plist-get cfg :smtp-user))
                      (smtpmail-smtp-server . ,my/posteo-smtp-server)
                      (smtpmail-smtp-service . 587)
                      (smtpmail-stream-type . starttls)))))
         my/mu4e-accounts))

  (setq mu4e-context-policy 'ask
        mu4e-compose-context-policy 'ask)

  ;; --- Folders / shortcuts ---------------------------------------------
  (setq mu4e-maildir-shortcuts
        '((:maildir "/posteo-work/Inbox"     :key ?w)
          (:maildir "/posteo-work/Archive"   :key ?W)
          (:maildir "/posteo-personal/Inbox" :key ?p)
          (:maildir "/posteo-personal/Archive" :key ?P)))

  ;; --- Bookmarks ---------------------------------------------------------
  (setq mu4e-bookmarks
        '((:name "Unread"
                 :query "flag:unread AND NOT flag:trashed"
                 :key ?u)
          (:name "Today"
                 :query "date:today..now AND NOT flag:trashed"
                 :key ?t)
          (:name "Last 7 days"
                 :query "date:7d..now AND NOT flag:trashed"
                 :key ?d)
          (:name "Work"
                 :query "maildir:/posteo-work/* AND NOT flag:trashed"
                 :key ?W)
          (:name "Personal"
                 :query "maildir:/posteo-personal/* AND NOT flag:trashed"
                 :key ?P)
          (:name "Attachments"
                 :query "flag:attach AND NOT flag:trashed"
                 :key ?a)))

  ;; --- Header view --------------------------------------------------------
  (setq mu4e-headers-fields
        '((:human-date . 12)
          (:flags . 6)
          (:maildir . 22)
          (:from-or-to . 22)
          (:subject))))

(provide 'init-mail)
