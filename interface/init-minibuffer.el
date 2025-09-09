;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-minibuffer.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (mateorodriguez@geotab.com)
;; Maintainer: 
;; Created: sáb ago  6 21:06:24 2022 (+0200)
;; Last-Updated: Tue Sep  9 16:11:10 2025 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-filter-dired-buffers (buffer-list)
  (delq nil (mapcar
             (lambda (buffer)
               (if (eq (with-current-buffer buffer major-mode)  'dired-mode)
                   nil
                 buffer))
             buffer-list)))

(defun helm-rg (directory &optional with-types)
  "Search in DIRECTORY with RG.
With WITH-TYPES, ask for file types to search in."
  (require 'helm-adaptive)
  (helm-grep-ag-1 (expand-file-name directory)
                  (helm-aif (and with-types
                                 (helm-grep-ag-get-types))
                      (helm-comp-read
                       "RG type: " it
                       :must-match t
                       :marked-candidates t
                       :fc-transformer 'helm-adaptive-sort
                       :buffer "*helm rg types*"))))

(defun helm-project-search (&optional with-types)
  "Search in current project with RG.
With WITH-TYPES, ask for file types to search in."
  (interactive "P")
  (helm-rg (projectile-project-root) with-types))

(defun helm-file-search (&optional with-types)
  "Search in current project with RG.
With WITH-TYPES, ask for file types to search in."
  (interactive "P")
  (helm-rg default-directory with-types))

(use-package helm
  :ensure t
  :custom-face
  (helm-ff-directory ((t (:foreground "light sky blue"))))
  :config
  (setq helm-split-window-inside-p            nil ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     nil ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t
        helm-M-x-fuzzy-match                  t
        helm-bookmark-show-location           t
        helm-buffers-fuzzy-matching           t
	helm-buffers-sort-fn                  'helm-fuzzy-matching-sort-fn-preserve-ties-order
        helm-completion-in-region-fuzzy-match t
        helm-file-cache-fuzzy-match           t
        helm-imenu-fuzzy-match                t
        helm-mode-fuzzy-match                 t
        helm-locate-fuzzy-match               t
        helm-quick-update                     t
	helm-follow-mode-persistent           t
        helm-recentf-fuzzy-match              t
        helm-semantic-fuzzy-match             t)

  ;; (setq helm-autoresize-max-height 0)
  (setq helm-show-completion-display-function #'helm-show-completion-default-display-function)
  (setq helm-autoresize-min-height 30)
  (setq helm-boring-buffer-regexp-list '("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\*lsp-log" "\\*clangd" "\\*projectile" "magit[:-]" "\\*Async-native-comp" "\\*Warnings" "\\*Help" "\\*Messages"))
  (advice-add 'helm-skip-boring-buffers :filter-return 'my-filter-dired-buffers)
  (helm-mode 1)
  (helm-autoresize-mode 1)
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x b" . helm-mini)
   ("C-c h" . helm-command-prefix)
   ("C-c r" . helm-project-search)
   ("C-c f" . helm-file-search)
   ("C-c b" . helm-browse-project)
   (:map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action)
         ("C-z" . helm-select-action)
         ("C-n" . helm-next-line)
         ("C-p" . helm-previous-line))))

(use-package helm-xref
  :ensure t
  :bind
  ("M-g b" . xref-go-back)
  ("M-g o" . xref-find-definitions-other-window)
  )

(use-package helm-ls-git
  :ensure t)

(use-package helm-ls-hg
  :ensure t)

(provide 'init-minibuffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-minibuffer.el ends here
