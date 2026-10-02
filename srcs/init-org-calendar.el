(use-package oauth2)

(defvar org-caldav-sync-in-progress nil
  "Non-nil while an org-caldav sync is running.")

(defun org-caldav-sync--prevent-reentry (original-function &rest args)
  "Prevent nested calls to `org-caldav-sync'."
  (if org-caldav-sync-in-progress
      (message "Skipping nested org-caldav sync")
    (let ((org-caldav-sync-in-progress t))
      (apply original-function args))))

(use-package org-caldav
  :after oauth2
  :config
  (advice-add 'org-caldav-sync :around #'org-caldav-sync--prevent-reentry)
  (setq
   org-caldav-url "https://posteo.de:8443/calendars/teorodrip"
   org-caldav-calendar-id "default"
   org-caldav-inbox (expand-file-name "~/.org-calendar/inbox.org")
   org-caldav-files `(,(expand-file-name "~/.org-calendar/appointments.org"))
   org-caldav-delete-calendar-entries 'ask
   org-caldav-delete-org-entries 'ask
   org-caldav-debug-level 1
   org-caldav-show-sync-results nil
   org-caldav-resume-aborted 'never
   org-icalendar-timezone "Europe/Madrid"))

;; sincroniza al cerrar, también pide guardar después de sincronizar
;; no se pierden cambios
(defun org-caldav-sync-at-close ()
  (org-caldav-sync)
  (save-some-buffers))

(defun org-caldav-sync-my-files ()
  (when (member (buffer-file-name) org-caldav-files)
    (run-with-idle-timer 60 nil 'org-caldav-sync)))

(defun org-caldav-enable-sync-on-save ()
  "Enable calendar syncing after saving this Org buffer."
  (add-hook 'after-save-hook #'org-caldav-sync-my-files nil t))

;; Sincroniza después de guardar un archivo Org configurado para CalDAV.
(add-hook 'org-mode-hook #'org-caldav-enable-sync-on-save)

;; Añade hook para el cierre de emacs
(add-hook 'kill-emacs-hook 'org-caldav-sync-at-close)


(provide 'init-org-calendar)
