;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-helm.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Wed Sep  9 11:14:01 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm
             :ensure t
             :config
             (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
                   helm-move-to-line-cycle-in-source     nil ; move to end or beginning of source when reaching top or bottom of source.
                   helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
                   helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
                   helm-ff-file-name-history-use-recentf t
                   helm-M-x-fuzzy-match                  t
                   helm-bookmark-show-location           t
                   helm-buffers-fuzzy-matching           t
                   helm-completion-in-region-fuzzy-match t
                   helm-file-cache-fuzzy-match           t
                   helm-imenu-fuzzy-match                t
                   helm-mode-fuzzy-match                 t
                   helm-locate-fuzzy-match               t
                   helm-quick-update                     t
                   helm-recentf-fuzzy-match              t
                   helm-semantic-fuzzy-match             t)

             ;; (setq helm-autoresize-max-height 0)
             (setq helm-autoresize-min-height 30)
             (helm-autoresize-mode 1)
             (helm-mode 1)
             :bind
             (("M-x" . helm-M-x)
              ("C-x C-f" . helm-find-files)
              ("C-x b" . helm-buffers-list)
              ("C-c h" . helm-command-prefix)
              (:map helm-map
                    ("<tab>" . helm-execute-persistent-action)
                    ("C-i" . helm-execute-persistent-action)
                    ("C-z" . helm-select-action))))

(provide 'init-helm)
