;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-lisp.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: vie sep  2 15:53:53 2022 (+0200)
;; Last-Updated: Thu Feb  5 13:58:23 2026 (+0100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'emacs-lisp-mode-hook #'company-mode)

(keymap-set emacs-lisp-mode-map "M-g d" #'xref-find-definitions)
(keymap-set emacs-lisp-mode-map "M-g o" #'xref-find-definitions-other-window)
(keymap-set emacs-lisp-mode-map "M-g r" #'xref-find-references)

(provide 'init-lisp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lisp.el ends here
