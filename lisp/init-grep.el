;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-grep.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Fri Sep 11 12:36:23 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default grep-highlight-matches t
              grep-scroll-output t)

(use-package wgrep
             :ensure t)
(after-load 'grep
  (dolist (key (list (kbd "C-c C-q") (kbd "w")))
    (define-key grep-mode-map key 'wgrep-change-to-wgrep-mode)))

(when (and (executable-find "ag")
           (use-package ag
                        :ensure t))
  (use-package wgrep-ag
               :ensure t)
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'ag-project))

(when (and (executable-find "rg")
           (use-package rg
                        :ensure t))
  (use-package deadgrep
               :ensure t)
  (global-set-key (kbd "M-?") 'rg-project))


(provide 'init-grep)
;;; init-grep.el ends here
