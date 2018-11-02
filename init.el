;; ====================================================
;; MELPA
;; ====================================================

(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; ====================================================
;; use-package
;; ====================================================

(unless (featurep 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

;; ====================================================
;; INIT
;; ====================================================

(add-to-list 'load-path (expand-file-name "config_lisp" user-emacs-directory))

(require 'init_variables)
(require 'init_funcs)
(require 'init_packages)
(require 'init_irony)
(require 'init_keys)
(require 'init_hooks)
(require 'init_general)

;; ====================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(company-irony flycheck-irony irony-eldoc irony flycheck company use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:background "gray19")))))
