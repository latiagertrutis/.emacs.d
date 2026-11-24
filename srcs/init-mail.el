;; -*- lexical-binding: t; -*-

(require 'auth-source)
(require 'subr-x)

(setq auth-sources '("~/.authinfo")
      auth-source-cache-tokens nil)

(defconst my/mu4e-accounts
  '(("work"
     :address  "madvise@posteo.net"
     :full-name "Madvise"
     :maildir  "/posteo-work"
     :smtp-server "posteo.de"
     :smtp-service 587
     :stream-type starttls
     :debug-info nil)
    ("personal"
     :address  "teorodrip@posteo.net"
     :full-name "Mateo Rodriguez"
     :maildir  "/posteo-personal"
     :smtp-server "posteo.de"
     :smtp-service 587
     :stream-type starttls
     :debug-info nil)))

(defun my/mu4e-insert-signature ()
  "Insert the HTML signature without Message's `-- ' separator."
  (save-excursion
    (goto-char (point-max))
    (insert my/mu4e-signature))
  nil)

(defun my/mu4e-context-match (address)
  "Return a `mu4e-context' :match-func matching ADDRESS.
The context is selected when ADDRESS appears in From, To or Cc of the
current message."
  (lambda (msg)
    (and msg
         (seq-some (lambda (field)
                     (member address (mapcar #'mu4e-contact-email
                                             (mu4e-message-field msg field))))
                   '(:from :to :cc)))))

(use-package mu4e
  :init
  (setq mu4e-maildir "~/.mail"

        ;; Retrieval is delegated to isync/mbsync; credentials for the
        ;; IMAP connection are taken from auth-source (see above).
        mu4e-get-mail-command "mbsync --all"
        mu4e-update-interval 60
        mu4e-update-in-background t
        mu4e-change-filenames-when-moving t

	mu4e-split-view 'vertical
	mu4e-headers-visible-columns 90
        mu4e-confirm-quit t
        mu4e-attachment-dir "~/Downloads"
        mu4e-sent-messages-behavior 'sent

        mu4e-view-show-images t
        mu4e-compose-format-flowed t
        message-kill-buffer-on-exit t
	mail-user-agent 'mu4e-user-agent

	my/mu4e-signature "\n#+BEGIN_EXPORT ascii
Mateo Rodríguez
Co-Founder & Lead Software Architect
info@madvise.dev
madvise.dev
#+END_EXPORT

#+BEGIN_EXPORT html
<div class=\"moz-signature\" style=\"padding-top:15pt;font-family:Inter,'Segoe UI',Arial,Helvetica,sans-serif\">
  <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"font-family:inherit\">
    <tbody>
      <tr>
        <td style=\"vertical-align:middle\">
          <a href=\"https://madvise.dev\">
            <img src=\"file:///home/mateo/Pictures/logo.png\"
                 alt=\"Madvise\"
                 width=\"110\"
                 style=\"display:block;width:110px;height:auto;border:0\">
          </a>
        </td>
        <td style=\"padding-left:24px;padding-right:35px;vertical-align:middle\">
          <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"2\" style=\"width:2px;height:100%\">
            <tbody>
              <tr>
                <td style=\"width:2px;height:85px;background-color:#17191C;font-size:0;line-height:0\">
                  &nbsp;
                </td>
              </tr>
            </tbody>
          </table>
        </td>
        <td style=\"vertical-align:middle;white-space:nowrap\">
          <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"font-family:inherit\">
            <tbody>
              <tr>
                <td style=\"font-size:12pt;font-weight:700;color:#17191C;white-space:nowrap\">
                  Mateo Rodríguez
                </td>
              </tr>
              <tr>
                <td style=\"padding-top:0.5pt;font-size:10pt;font-weight:300;font-style:italic;color:#17191C;white-space:nowrap\">
                  Co-Founder &amp; Lead Software Architect
                </td>
              </tr>
              <tr>
                <td style=\"padding-top:0.5pt;font-size:10pt;font-weight:300;font-style:normal;white-space:nowrap\">
                  <a href=\"mailto:info@madvise.dev\"
                     style=\"color:#4067D3;text-decoration:none\">
                    info@madvise.dev
                  </a>
                </td>
              </tr>
              <tr>
                <td style=\"padding-top:0.5pt;font-size:10pt;font-weight:300;font-style:normal;white-space:nowrap\">
                  <a href=\"https://madvise.dev\"
                     style=\"color:#4067D3;text-decoration:none\">
                    www.madvise.dev
                  </a>
                </td>
              </tr>
            </tbody>
          </table>
        </td>
      </tr>
    </tbody>
  </table>
</div>
#+END_EXPORT"
	message-signature #'my/mu4e-insert-signature)
  :config
  (defface my/mu4e-thread-root-face
    '((t :inherit default :foreground "#eceff4" :background "#252A33"
         :extend t :underline nil :box nil))
    "Nord root-row face for a mail thread."
    :group 'mu4e-faces)
  (defface my/mu4e-thread-child-face
    '((t :inherit default :foreground "#e5e9f0" :background "#1C1F26"
         :extend t :underline nil :box nil))
    "Brighter Nord row face for a mail thread reply."
    :group 'mu4e-faces)
  (defface my/mu4e-unread-face
    '((t :foreground "#ebcb8b" :weight bold))
    "Nord gold accent, layered over the message's row face."
    :group 'mu4e-faces)
  (defface my/mu4e-thread-root-marker-face
    '((t :foreground "#b48ead" :weight bold :height 1.25))
    "Nord purple fold marker for a thread root."
    :group 'mu4e-faces)
  (defface my/mu4e-thread-child-marker-face
    '((t :foreground "#b48ead" :weight bold))
    "Nord purple indentation marker for a thread reply."
    :group 'mu4e-faces)

  ;; mu4e enables this underline on the selected header by default.
  (set-face-attribute 'mu4e-header-highlight-face nil :underline nil :box nil)
  (set-face-attribute 'mu4e-unread-face nil
                      :foreground "#ebcb8b" :weight 'bold)
  ;; Modern mu4e includes Rougier's folding; do not run both implementations.
  (when (and (fboundp 'mu4e-thread-folding-mode)
             (bound-and-true-p mu4e-thread-folding-mode))
    (mu4e-thread-folding-mode -1))

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
              :match-func (my/mu4e-context-match address)
              :vars `((user-full-name      . ,(plist-get cfg :full-name))
                      (user-mail-address   . ,address)
                      (mu4e-sent-folder    . ,(concat root "/Sent"))
                      (mu4e-drafts-folder  . ,(concat root "/Drafts"))
                      (mu4e-trash-folder   . ,(concat root "/Trash"))
                      (mu4e-refile-folder  . ,(concat root "/Archive"))
                      (smtpmail-smtp-user  . ,address)
		      (smtpmail-smtp-server . ,(plist-get cfg :smtp-server))
		      (smtpmail-smtp-service . ,(plist-get cfg :smtp-service))
		      (smtpmail-stream-type . ,(plist-get cfg :stream-type))
		      (smtpmail-debug-info . ,(plist-get cfg :debug-info))))))
         my/mu4e-accounts))

  ;; Choose an account automatically; new mail keeps it, replies match theirs.
  (setq mu4e-context-policy 'pick-first
        mu4e-compose-context-policy nil)

  (defvar-local my/mu4e-header-width 80
    "Available header columns, excluding mu4e's mark area and the right edge.")

  (defun my/mu4e-header-contact (msg)
    "Return MSG's sender as a name with email address when available."
    (let* ((from (car (mu4e-message-field msg :from)))
           (name (mu4e-contact-name from))
           (email (mu4e-contact-email from)))
      (cond ((and name (not (string-empty-p name)))
             (if (and email (not (string-empty-p email)))
                 (format "%s <%s>" name email)
               name))
            ((and email (not (string-empty-p email))) email)
            (t "Unknown sender"))))

  (defun my/mu4e-header-column (text width end)
    "Fit TEXT into WIDTH columns, aligning its trailing space at END.
END includes mu4e's mark area.  Leave a gap between columns and use
three dots for truncated text (fewer only in extremely narrow windows)."
    (let ((limit (max 0 (1- width))))
      (concat (truncate-string-to-width
               text limit 0 nil (substring "..." 0 (min 3 limit)))
              (propertize " " 'display `(space :align-to ,end)))))

  (defun my/mu4e-headers-row (msg)
    "Format MSG as an aligned sender, subject and date row."
    (let* ((thread (mu4e-message-field msg :meta))
           (child (> (or (plist-get thread :level) 0) 0))
           (root (and (not child) (plist-get thread :has-child)))
           (flags (mu4e-message-field msg :flags))
           (unread (or (memq 'unread flags) (memq 'new flags)))
           (face (append (and unread '(my/mu4e-unread-face))
                         (list (cond (child 'my/mu4e-thread-child-face)
                                     (root 'my/mu4e-thread-root-face)
                                     (t 'default)))))
           (date-width (min 12 (max 1 (/ my/mu4e-header-width 3))))
           (available (- my/mu4e-header-width date-width))
           ;; Unlike a fixed cap, this also gives long senders room on wide screens.
           (sender-width (min (max 1 (- available 3))
                              (+ 7 (/ (* (max 0 (- available 7)) 2) 5))))
           (subject-width (max 1 (- available sender-width)))
           (subject (mu4e-message-field msg :subject))
           (row
            (concat
             (my/mu4e-header-column
              (concat (if root
                          (propertize "▾" 'face 'my/mu4e-thread-root-marker-face
                                      'my/mu4e-thread-root-marker t)
                        " ")
                      (propertize " " 'display
                                  `(space :align-to ,(+ mu4e--mark-fringe-len 2)))
                      (if unread "●" " ")
                      (if (memq 'flagged flags)
                          (propertize "!" 'face 'mu4e-flagged-face) " ")
                      (if (memq 'attach flags)
                          (propertize "+" 'face 'shadow) " ")
                      (if (memq 'replied flags)
                          (propertize "↩" 'face 'mu4e-replied-face) " ")
                      " " (my/mu4e-header-contact msg))
              sender-width (+ mu4e--mark-fringe-len sender-width))
             (my/mu4e-header-column
              (concat (if child
                          (propertize "│ " 'face 'my/mu4e-thread-child-marker-face)
                        "  ")
                      (if (string-empty-p subject) "(no subject)" subject))
              subject-width (+ mu4e--mark-fringe-len available))
             (truncate-string-to-width (mu4e~headers-human-date msg) date-width))))
      (add-face-text-property 0 (length row) face t row)
      (propertize row 'my/mu4e-header t)))

  (defun my/mu4e-update-thread-marker-at-point (&rest _args)
    "Update the current root's arrow after a built-in fold operation."
    (when (derived-mode-p 'mu4e-headers-mode)
      (save-excursion
        (mu4e-thread-goto-root)
        (let ((marker (text-property-any
                       (line-beginning-position) (line-end-position)
                       'my/mu4e-thread-root-marker t)))
          (when marker
            ;; Search-result hooks run outside mu4e's inhibit-read-only binding.
            (with-silent-modifications
              (put-text-property
               marker (1+ marker) 'display
               (propertize (if (mu4e-thread-is-folded) "▸" "▾")
                           'face (get-text-property marker 'face)))))))))

  (defun my/mu4e-update-all-thread-markers (&rest _args)
    "Synchronize root arrows with mu4e's fold overlays."
    (when-let* ((buffer (mu4e-get-headers-buffer)))
      (with-current-buffer buffer
        (mu4e-headers-for-each
         (lambda (msg)
           (when (mu4e~headers-thread-root-p msg)
             (my/mu4e-update-thread-marker-at-point)))))))

  (defun my/mu4e-resize-headers (&optional _window)
    "Reflow existing rows without searching again or losing marks and folds."
    (let* ((windows (get-buffer-window-list (current-buffer) nil t))
           (width (max 3 (- (if windows
                                (apply #'min (mapcar #'window-body-width windows))
                              (window-body-width))
                            mu4e--mark-fringe-len 1))))
      (unless (= width my/mu4e-header-width)
        (setq my/mu4e-header-width width)
        (let ((column (current-column)))
          (with-silent-modifications
            (mu4e-headers-for-each
             (lambda (msg)
               (when-let* ((start (text-property-any
                                   (line-beginning-position) (line-end-position)
                                   'my/mu4e-header t)))
                 (let ((length (- (line-end-position) start)))
                   (goto-char start)
                   ;; Insert first so overlays spanning the row retain their bounds.
                   ;; Leave the docid cookie, mark area and newline untouched.
                   (insert (propertize (mu4e~headers-apply-flags
                                        msg (my/mu4e-headers-row msg))
                                       'msg msg 'docid (plist-get msg :docid)))
                   (delete-region (point) (+ (point) length)))))))
          (move-to-column column))
        (my/mu4e-update-all-thread-markers))))

  (defun my/mu4e-headers-setup ()
    "Initialize the responsive layout in a headers buffer."
    (my/mu4e-resize-headers)
    (add-hook 'window-size-change-functions #'my/mu4e-resize-headers nil t))

  (setf (alist-get :thread-row mu4e-header-info-custom)
        '(:name "Messages" :shortname "" :function my/mu4e-headers-row))
  (setq mu4e-search-threads t
        mu4e-headers-fields '((:thread-row . nil)))
  (add-hook 'mu4e-headers-mode-hook #'my/mu4e-headers-setup)

  (defun my/mu4e-thread-fold-info (_count _unread)
    "Hide folded child rows without inserting a second display line."
    "")
  (advice-add 'mu4e-thread-fold-info :override #'my/mu4e-thread-fold-info)
  (dolist (function '(mu4e-thread-fold mu4e-thread-unfold))
    (advice-add function :after #'my/mu4e-update-thread-marker-at-point))
  (advice-add 'mu4e-thread-unfold-all :after #'my/mu4e-update-all-thread-markers)
  (add-hook 'mu4e-headers-found-hook #'my/mu4e-update-all-thread-markers)
  (add-hook 'mu4e-message-changed-hook #'my/mu4e-update-all-thread-markers))


(use-package mu4e-dashboard
  :straight (mu4e-dashboard :type git
                            :repo "https://github.com/rougier/mu4e-dashboard")
  :config
  (setopt mu4e-dashboard-file
	  (expand-file-name "srcs/mu4e-dashboard.org" user-emacs-directory))
  (setq mu4e-dashboard-propagate-keymap nil)
  (defun my/mu4e-show-dashboard ()
    "Show the dashboard after mu4e returns to its main view."
    (interactive)
    (let ((buffer (find-file-noselect mu4e-dashboard-file)))
      (mu4e t)
      (mu4e-dashboard)))
  (defun dmg-mu4e-view (orig &rest args)
    (interactive)
    (mu4e-update-mail-and-index t)
    (if (find-buffer-visiting mu4e-dashboard-file)
        (mu4e-dashboard)
      (apply orig args)))

  (advice-add 'mu4e--main-view :around #'dmg-mu4e-view)
  :bind (("C-c C-x m" . my/mu4e-show-dashboard)))

(use-package org-mime
  :commands (org-mime-edit-mail-in-org-mode)
  :hook (message-send . org-mime-htmlize)
  :init
  (with-eval-after-load 'mu4e-compose
    (define-key mu4e-compose-mode-map (kbd "C-c M-o")
                #'org-mime-edit-mail-in-org-mode)
    (define-key mu4e-compose-mode-map (kbd "C-c M-h")
                #'org-mime-htmlize))
  :config
  (setq org-mime-export-options
	'(:section-numbers nil :with-author nil :with-toc nil)
	org-mime-export-ascii 'utf-8))

(provide 'init-mail)
