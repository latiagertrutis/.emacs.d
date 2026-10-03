(use-package oauth2)

(defvar org-caldav-sync-in-progress nil
  "Non-nil while an org-caldav sync is running.")

(defun org-caldav-sync--prevent-reentry (original-function &rest args)
  "Prevent nested calls to `org-caldav-sync'."
  (if org-caldav-sync-in-progress
      (message "Skipping nested org-caldav sync")
    (let ((org-caldav-sync-in-progress t))
      (apply original-function args))))

(defconst org-caldav-personal-state-directory
  (expand-file-name "org-caldav/personal/" user-emacs-directory))
(defconst org-caldav-madvise-state-directory
  (expand-file-name "org-caldav/madvise/" user-emacs-directory))
(make-directory org-caldav-personal-state-directory t)
(make-directory org-caldav-madvise-state-directory t)

(use-package org-caldav
  :after (oauth2 org-roam)
  :config
  (advice-add 'org-caldav-sync :around #'org-caldav-sync--prevent-reentry)
  (setq
   org-caldav-calendars
   `((:url "https://posteo.de:8443/calendars/teorodrip"
	   :calendar-id "default"
	   :caldav-save-directory ,org-caldav-personal-state-directory
	   :inbox ,(expand-file-name "20261003004340-personal_calendar_inbox.org" org-roam-directory)
	   :files (,(expand-file-name "20261003004434-personal_calendar_entries.org" org-roam-directory)))
     (:url "https://posteo.de:8443/calendars/madvise"
	   :calendar-id "default"
	   :caldav-save-directory ,org-caldav-madvise-state-directory
	   :inbox ,(expand-file-name "20261003004400-madvise_calendar_inbox.org" org-roam-directory)
	   :files (,(expand-file-name "20261003004451-madvise_calendar_entries.org" org-roam-directory))))
   org-caldav-delete-calendar-entries 'ask
   org-caldav-delete-org-entries 'ask
   org-caldav-debug-level 1
   org-caldav-show-sync-results nil
   org-caldav-resume-aborted 'never
   org-icalendar-timezone "Europe/Madrid"))

(defun org-caldav-sync-personal ()
  (interactive)
  (let ((auth-sources '("~/.authinfo.personal"))
         ;; Auth-source caches results by query, not by `auth-sources'.
         ;; URL Basic auth also caches credentials.  Don't let one account's
         ;; credentials leak into the next sync on the same host.
	(auth-source-do-cache nil)
        (url-http-real-basic-auth-storage nil))
    (org-caldav-sync-calendar (nth 0 org-caldav-calendars))))

(defun org-caldav-sync-madvise ()
  (interactive)
  (let ((auth-sources '("~/.authinfo.madvise"))
         ;; Auth-source caches results by query, not by `auth-sources'.
         ;; URL Basic auth also caches credentials.  Don't let one account's
         ;; credentials leak into the next sync on the same host.
	(auth-source-do-cache nil)
        (url-http-real-basic-auth-storage nil))
    (org-caldav-sync-calendar (nth 1 org-caldav-calendars))))

(defun org-caldav-sync-all ()
  (interactive)
  (org-caldav-sync-madvise)
  (org-caldav-sync-personal))

(defun org-caldav-sync-my-files ()
  "Sync files only if they are one of the watched in any calendar"
  (let* ((file (buffer-file-name))
         (files (and (boundp 'org-caldav-calendars)
                     (apply #'append
                            (mapcar (lambda (calendar)
                                      (append
                                       (plist-get calendar :files)
                                       (let ((inbox (plist-get calendar :inbox)))
                                         (and (stringp inbox) (list inbox)))))
                                    org-caldav-calendars)))))
    (when (member file files)
      (run-with-idle-timer 60 nil 'org-caldav-sync-all))))

(defun org-caldav-enable-sync-on-save ()
  "Enable calendar syncing after saving this Org buffer."
  (add-hook 'after-save-hook #'org-caldav-sync-my-files nil t))

;; Sincroniza después de guardar un archivo Org configurado para CalDAV.
(add-hook 'org-mode-hook #'org-caldav-enable-sync-on-save)

(provide 'init-org-calendar)
