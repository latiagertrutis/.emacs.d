;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Filename: init-use-package.el
;Description:
;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;Maintainer:
;Created: Tue Sep  8 12:41:45 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(provide 'init-use-package)
