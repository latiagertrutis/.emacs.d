;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-minibuffer.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 21:06:24 2022 (+0200)
;; Last-Updated: mar abr 18 17:54:35 2023 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-filter-dired-buffers (buffer-list)
  (delq nil (mapcar
             (lambda (buffer)
               (if (eq (with-current-buffer buffer major-mode)  'dired-mode)
                   nil
                 buffer))
             buffer-list)))

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
  (setq helm-show-completion-display-function #'helm-show-completion-default-display-function)
  (setq helm-autoresize-min-height 30)
  (setq helm-boring-buffer-regexp-list '("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\*lsp-log" "\\*clangd" "\\*projectile" "magit:" "\\`\\*Messages"))
  (advice-add 'helm-skip-boring-buffers :filter-return 'my-filter-dired-buffers)
  
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
         ("C-z" . helm-select-action)
         ("C-n" . helm-next-line)
         ("C-p" . helm-previous-line))))

(use-package helm-xref
  :ensure t
  :bind
  (("M-g d" . xref-find-definitions)
   ("M-g r" . xref-find-references)
   ("M-g b" . xref-pop-marker-stack)
   ("M-g o" . xref-find-definitions-other-window))
  )

(provide 'init-minibuffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-minibuffer.el ends here
