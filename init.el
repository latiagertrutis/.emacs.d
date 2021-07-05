;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Filename: init.el
;Description:
;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;Maintainer:
;Created: Tue Sep  8 12:13:52 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)

(let ((minver "24.4"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "25.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
;; (let ((normal-gc-cons-threshold (* 20 1024 1024))
;;       (init-gc-cons-threshold (* 128 1024 1024)))
;;   (setq gc-cons-threshold init-gc-cons-threshold)
;;   (add-hook 'emacs-startup-hook
;;             (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-utils)
(require 'init-use-package)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require 'init-themes)
(require 'init-helm)
(require 'init-projectile)
(require 'init-windows)
(require 'init-local)
(require 'init-editing-utils)
(require 'init-gui-frames)
(require 'init-etags)
(require 'init-markdown)
(require 'init-grep)
(require 'init-isearch)
(require 'init-flycheck)
(require 'init-ggtags)
(require 'init-company)
(require 'init-lsp)
(require 'init-go)
(require 'init-c)
(require 'init-git)
(require 'init-org)
(require 'init-powerline)
(require 'init-yaml)
(require 'init-plantuml)
(require 'init-treemacs)
(require 'init-web)
(require 'init-js)
(require 'init-header)
