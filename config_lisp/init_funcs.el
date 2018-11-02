(defun irony-server-installation ()
  (interactive)
  (irony-install-server "cmake -DLIBCLANG_INCLUDE_DIR=$CLANG_INCLUDE_PATH -DLIBCLANG_LIBRARY=$CLANG_LIBRARY -DCMAKE_INSTALL_PREFIX\=/home/mateo/.emacs.d/irony/  /home/mateo/.emacs.d/elpa/irony-20181030.834/server && cmake --build . --use-stderr --config Release --target install"
						))

(provide 'init_funcs)
