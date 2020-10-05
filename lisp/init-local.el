;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-local.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Thu Sep 10 14:10:37 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'bind-key)

(global-hl-line-mode +1)
(setq-default cursor-type 'bar)

;; Save session
(desktop-save-mode 1)

(setq user-full-name "Mateo Rodriguez Ripolles (teorodrip@posteo.net)")

;; Custom faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:inherit isearch))))
 '(hl-line ((t (:background "#383838")))))

;; indent all the buffer
(defun indent-buffer ()
  "Just indent all the buffer."
  (interactive)
  (save-excursion (indent-region (point-min) (point-max) nil)))
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

;;default font
(add-to-list 'default-frame-alist '(font . "Free Mono 12"))

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

;; get rid of backup files
;; Don't clutter up directories with files~
(setq dotfiles-dir "~/.emacs.d/dotfiles/")
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; Don't clutter with #files either
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name (concat dotfiles-dir "backups")))))

(provide 'init-local)
