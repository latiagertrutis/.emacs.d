;;; init-utils.el --- Elisp helper functions and commands -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(if (fboundp 'with-eval-after-load)
    (defalias 'after-load 'with-eval-after-load)
  (defmacro after-load (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))

;;----------------------------------------------------------------------------
;; command log mode
;;----------------------------------------------------------------------------

(use-package command-log-mode
  :ensure t)

;;----------------------------------------------------------------------------
;; Ztree
;;----------------------------------------------------------------------------

(use-package ztree
  :ensure t
  :custom-face
  (ztreep-diff-model-add-face ((nil(:foreground "chartreuse"))))
  (ztreep-diff-model-diff-face ((nil(:foreground "coral"))))
  (ztreep-diff-model-normal-face ((nil(:foreground "gainsboro")))))

;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))


;;----------------------------------------------------------------------------
;; String utilities missing from core emacs
;;----------------------------------------------------------------------------
(defun sanityinc/string-all-matches (regex str &optional group)
  "Find all matches for `REGEX' within `STR', returning the full match string or group `GROUP'."
  (let ((result nil)
        (pos 0)
        (group (or group 0)))
    (while (string-match regex str pos)
      (push (match-string group str) result)
      (setq pos (match-end group)))
    result))


;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (unless (buffer-file-name)
    (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))


;;----------------------------------------------------------------------------
;; Rename the current file
;;----------------------------------------------------------------------------
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (progn
      (when (file-exists-p filename)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name)
      (rename-buffer new-name))))

;;----------------------------------------------------------------------------
;; Browse current HTML file
;;----------------------------------------------------------------------------
(defun browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (and (fboundp 'tramp-tramp-file-p)
             (tramp-tramp-file-p file-name))
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))

;;----------------------------------------------------------------------------
;; Copy filepath of current buffer
;;----------------------------------------------------------------------------

(defun copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.

If in dired, copy the file/dir cursor is on, or marked files.

If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2017-09-01"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory path copied: [%s]" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: [%s]" $fpath)
         $fpath )))))

;;----------------------------------------------------------------------------
;; Copy base file name of current buffer
;;----------------------------------------------------------------------------

(defun copy-file-name (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.

If in dired, copy the file/dir cursor is on, or marked files.

If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2017-09-01"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (file-name-nondirectory (buffer-file-name))
             (file-name-nondirectory (expand-file-name default-directory))))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory path copied: [%s]" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: [%s]" $fpath)
         $fpath )))))

;;----------------------------------------------------------------------------
;; Copy base line reference
;;----------------------------------------------------------------------------

(defun copy-file-line-position ()
  "Copy to the kill ring a string in the format \"file-name:line-number\"
for the current buffer's file name, and the line number at point."
  (interactive)
  (let (($reference (format "%s:%d" (file-name-nondirectory (buffer-file-name)) (save-restriction
                                                                                  (widen) (line-number-at-pos)))))
    (message "File reference copied: [%s]" $reference)
    (kill-new $reference))
  )

;;----------------------------------------------------------------------------
;; Toggle case sensitive
;;----------------------------------------------------------------------------
(defun toggle-case-search ()
  (interactive)
  (setq case-fold-search (not case-fold-search)))

;;----------------------------------------------------------------------------
;; Better grep
;;----------------------------------------------------------------------------
(use-package rg
  :ensure t)

;;----------------------------------------------------------------------------
;; plantuml
;;----------------------------------------------------------------------------
(use-package plantuml-mode
  :ensure t
  :config
  (setq plantuml-jar-path (expand-file-name "~/.emacs.d/resources/plantuml.jar"))
  (setq plantuml-default-exec-mode 'jar))

(provide 'init-utils)
;;; init-utils.el ends here
