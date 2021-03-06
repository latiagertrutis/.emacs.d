;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-c.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Thu Jan 28 11:12:29 2021 (+0100)
;; Last-Updated: Thu May 20 12:10:05 2021 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Insal ccls (language server) client for emacs
;; (use-package ccls
;;   :ensure t
;;   :config
;;   (setq ccls-executable "ccls -log-file=/tmp/ccls.log -v=1")
;;   (setq lsp-prefer-flymake nil)
;;   (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
;;   :hook
;;   (c-mode . (lambda() (require 'ccls) (lsp))))

(defun c-mode-delete-trailing-whitespace ()
  (when (derived-mode-p 'c-mode)
    (delete-trailing-whitespace)))

(add-hook 'c-mode-hook 'flycheck-mode)

(add-hook 'before-save-hook 'c-mode-delete-trailing-whitespace)

(provide 'init-c)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-c.el ends here
