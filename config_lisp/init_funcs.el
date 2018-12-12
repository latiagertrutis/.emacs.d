(defun irony-server-installation ()
  (interactive)
  (irony-install-server "cmake -DLIBCLANG_INCLUDE_DIR=$CLANG_INCLUDE_PATH -DLIBCLANG_LIBRARY=$CLANG_LIBRARY -DCMAKE_INSTALL_PREFIX\=/home/mateo/.emacs.d/irony/  /home/mateo/.emacs.d/elpa/irony-20181030.834/server && cmake --build . --use-stderr --config Release --target install"
						))

;;indectar todo el buffer
(defun indent-buffer ()
  (interactive)
  (save-excursion
	(indent-region (point-min) (point-max) nil)))

;;new window right
(defun new-window-right ()
  (interactive)
  (split-window-right)
  (other-window 1))

;;update all non modified buffers
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

(defun eyedrop-foreground-at-point (&optional msg-p)
  "Return the foreground color under the text cursor.
Non-nil optional arg MSG-P means display an informative message."
  (interactive "p")
  ;; `eyedrop-face-at-point' alone is not sufficient.  It only gets named faces.
  ;; Need also pick up any face properties that are not associated with named faces.
  (let* ((face  (or (eyedrop-face-at-point)
                    (get-char-property (point) 'read-face-name)
                    (get-char-property (point) 'face)))
         (fg    (cond ((and face (symbolp face))
                       (condition-case nil
                           (face-foreground face nil 'default) ; Emacs 22+.
                         (error (or (face-foreground face) ; Emacs 20
                                    (cdr (assq 'foreground-color (frame-parameters)))))))
                      ((consp face)
                       (cond ((memq 'foreground-color face)
                              (cdr (memq 'foreground-color face)))
                             ((memq ':foreground face)
                              (cadr (memq ':foreground face)))))
                      (t nil)))         ; Invalid face value.
         (fg    (and (not (member fg '("unspecified-fg" "unspecified-bg")))  fg)))
    (when msg-p
      (if fg (eyedrop-color-message fg) (message "No foreground color here")))
    fg))

(provide 'init_funcs)
