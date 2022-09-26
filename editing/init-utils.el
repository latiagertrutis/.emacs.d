;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-utils.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: dom ago  7 14:09:06 2022 (+0200)
;; Last-Updated: lun sep 26 13:08:44 2022 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'bind-key)

;;----------------------------------------------------------------------------
;; Some basic preferences
;;----------------------------------------------------------------------------
(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode t
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil)

(when (fboundp 'delete-selection-mode)
  (add-hook 'after-init-hook 'delete-selection-mode))

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

;; indent all the buffer
(defun indent-buffer ()
  "Just indent all the buffer."
  (interactive)
  (save-excursion (astyle-region (point-min) (point-max))))
(bind-key* "C-c i" 'indent-buffer)

;; revert all the buffers
(defun revert-all-buffers ()
  "Revert all non-modified buffers associated with a file.
This is to update existing buffers after a Git pull of their underlying files."
  (interactive)
  (save-current-buffer
    (mapc (lambda (b)
            (set-buffer b)
            (unless (or (null (buffer-file-name)) (buffer-modified-p))
              (revert-buffer t t)
              (message "Reverted %s\n" (buffer-file-name))))
          (buffer-list))))

;;deleteword without add to kill ring
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(bind-key* "M-d" 'my-delete-word)
(bind-key* "<C-backspace>" 'my-backward-delete-word)

(use-package whole-line-or-region
             :ensure t
             :hook
             (after-init . whole-line-or-region-global-mode)
             :bind
             ("C-M-w" . whole-line-or-region-delete-region))

(use-package smooth-scrolling
             :ensure t
             :config
             (smooth-scrolling-mode 1))

(when (fboundp 'electric-pair-mode)
  (add-hook 'after-init-hook 'electric-pair-mode)
  (defun electric-pair ()
    "If at end of line, insert character pair without surrounding spaces.
    Otherwise, just insert the typed character."
    (interactive)
    (if (eolp) (let (parens-require-spaces) (insert-pair)) (self-insert-command 1)))
  (add-hook 'c-mode-hook
            (lambda ()
              (define-key c-mode-map "(" 'electric-pair)
              (define-key c-mode-map ")" 'electric-pair)
              (define-key c-mode-map "[" 'electric-pair)
              (define-key c-mode-map "]" 'electric-pair)
              (define-key c-mode-map "{" 'electric-pair)
	      (define-key c-mode-map "}" 'electric-pair))))

(defun sanityinc/newline-at-end-of-line ()
  "Move to end of line, enter a newline, and reindent."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(bind-key* "S-<return>" 'sanityinc/newline-at-end-of-line)

(use-package rainbow-delimiters
             :ensure t
             :hook
             (prog-mode . rainbow-delimiters-mode))

(use-package avy
             :ensure t
             :config
             (global-set-key (kbd "C-o") 'avy-goto-char-timer))

(when (fboundp 'display-line-numbers-mode)
  (setq-default display-line-numbers-width 3)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(use-package symbol-overlay
             :ensure t
	     :hook
	     (prog-mode . symbol-overlay-mode)
	     (html-mode . symbol-overlay-mode)
	     (yaml-mode . symbol-overlay-mode)
	     (conf-mode . symbol-overlay-mode)
	     :bind (:map symbol-overlay-mode-map
			 ("M-n" . symbol-overlay-jump-next)
			 ("M-p" . symbol-overlay-jump-prev))
	     )

(defface separator-face '((t (:foreground "hot pink" :weight bold))) nil)

(use-package browse-kill-ring
  :ensure t
  :config
  (setq browse-kill-ring-separator "--------------------------------------------------------------------------------"
	browse-kill-ring-highlight-current-entry t
	browse-kill-ring-separator-face 'separator-face)
  :bind
  ("M-Y" . browse-kill-ring)
  (:map browse-kill-ring-mode-map
	("C-g" . browse-kill-ring-quit)
	("M-n" . browse-kill-ring-forward)
	("M-p" . browse-kill-ring-previous))
  )

(provide 'init-utils)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-utils.el ends here
