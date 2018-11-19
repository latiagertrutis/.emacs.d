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

(provide 'init_funcs)
