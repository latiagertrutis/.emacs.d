;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-editing-utils.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Thu Sep 10 15:43:58 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package smooth-scrolling
             :ensure t
             :config
             (smooth-scrolling-mode 1))

(use-package diminish
             :ensure t)

(use-package unfill
             :ensure t)

(when (fboundp 'electric-pair-mode)
  (add-hook 'after-init-hook 'electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (add-hook 'after-init-hook 'electric-indent-mode))

(use-package list-unicode-display
             :ensure t)

;;----------------------------------------------------------------------------
;; Some basic preferences
;;----------------------------------------------------------------------------
(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil)

(add-hook 'after-init-hook 'global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)
(after-load 'autorevert
  (diminish 'auto-revert-mode))

(add-hook 'after-init-hook 'transient-mark-mode)



;; Huge files

(use-package vlf
             :ensure t)

(defun ffap-vlf ()
  "Find file at point with VLF."
  (interactive)
  (let ((file (ffap-file-at-point)))
    (unless (file-exists-p file)
      (error "File does not exist: %s" file))
    (vlf file)))


;;; A simple visible bell which works in all terminal types
(use-package mode-line-bell
             :ensure t
             :hook
             (after-init . mode-line-bell-mode))



(use-package beacon
             :ensure t
             :config
             (setq-default beacon-lighter "")
             (setq-default beacon-size 20)
             :hook
             (after-init . beacon-mode))


;;; Newline behaviour

(global-set-key (kbd "RET") 'newline-and-indent)
(defun sanityinc/newline-at-end-of-line ()
  "Move to end of line, enter a newline, and reindent."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(global-set-key (kbd "S-<return>") 'sanityinc/newline-at-end-of-line)



(after-load 'subword
  (diminish 'subword-mode))



(when (fboundp 'display-line-numbers-mode)
  (setq-default display-line-numbers-width 3)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(use-package goto-line-preview
             :ensure t
             :config
             (global-set-key [remap goto-line] 'goto-line-preview)
             (when (fboundp 'display-line-numbers-mode)
               (defun sanityinc/with-display-line-numbers (f &rest args)
                 (let ((display-line-numbers t))
                   (apply f args)))
               (advice-add 'goto-line-preview :around #'sanityinc/with-display-line-numbers)))



(use-package rainbow-delimiters
             :ensure t
             :hook
             (prog-mode . rainbow-delimiters-mode))



(when (fboundp 'global-prettify-symbols-mode)
  (add-hook 'after-init-hook 'global-prettify-symbols-mode))


(use-package symbol-overlay
             :ensure t
             :config
             (dolist (hook '(prog-mode-hook html-mode-hook yaml-mode-hook conf-mode-hook))
               (add-hook hook 'symbol-overlay-mode)))
(after-load 'symbol-overlay
  (diminish 'symbol-overlay-mode)
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-mode-map (kbd "M-I") 'symbol-overlay-remove-all)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))
;;----------------------------------------------------------------------------
;; Zap *up* to char is a handy pair for zap-to-char
;;----------------------------------------------------------------------------
(autoload 'zap-up-to-char "misc" "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-Z") 'zap-up-to-char)



(use-package browse-kill-ring
             :ensure t)
(setq browse-kill-ring-separator "\f")
(global-set-key (kbd "M-Y") 'browse-kill-ring)
(after-load 'browse-kill-ring
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "M-n") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "M-p") 'browse-kill-ring-previous))
(after-load 'page-break-lines
  (push 'browse-kill-ring-mode page-break-lines-modes))


;;----------------------------------------------------------------------------
;; Don't disable narrowing commands
;;----------------------------------------------------------------------------
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;;----------------------------------------------------------------------------
;; Show matching parens
;;----------------------------------------------------------------------------
(add-hook 'after-init-hook 'show-paren-mode)

;;----------------------------------------------------------------------------
;; Expand region
;;----------------------------------------------------------------------------
(use-package expand-region
             :ensure t)
(global-set-key (kbd "C-=") 'er/expand-region)


;;----------------------------------------------------------------------------
;; Don't disable case-change functions
;;----------------------------------------------------------------------------
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;;----------------------------------------------------------------------------
;; Rectangle selections, and overwrite text when the selection is active
;;----------------------------------------------------------------------------
(cua-selection-mode t)                  ; for rectangles, CUA is nice


;;----------------------------------------------------------------------------
;; Handy key bindings
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "C-x C-.") 'pop-global-mark)

(use-package avy
             :ensure t
             :config
             (global-set-key (kbd "C-o") 'avy-goto-char-timer))

(use-package multiple-cursors
             :ensure t)
;; multiple-cursors
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c m r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C-c m e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c m a") 'mc/edit-beginnings-of-lines)


;; Train myself to use M-f and M-b instead
(global-unset-key [M-left])
(global-unset-key [M-right])



(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(global-set-key (kbd "C-M-<backspace>") 'kill-back-to-indentation)


;;----------------------------------------------------------------------------
;; Page break lines
;;----------------------------------------------------------------------------
(use-package page-break-lines
             :ensure t
             :config
             (add-hook 'after-init-hook 'global-page-break-lines-mode)
             (after-load 'page-break-lines
               (diminish 'page-break-lines-mode)))

;;----------------------------------------------------------------------------
;; Shift lines up and down with M-up and M-down. When paredit is enabled,
;; it will use those keybindings. For this reason, you might prefer to
;; use M-S-up and M-S-down, which will work even in lisp modes.
;;----------------------------------------------------------------------------
(use-package move-dup
             :ensure t)
(global-set-key [M-up] 'md-move-lines-up)
(global-set-key [M-down] 'md-move-lines-down)
(global-set-key [M-S-up] 'md-move-lines-up)
(global-set-key [M-S-down] 'md-move-lines-down)

(global-set-key (kbd "C-c d") 'md-duplicate-down)
(global-set-key (kbd "C-c u") 'md-duplicate-up)

;;----------------------------------------------------------------------------
;; Fix backward-up-list to understand quotes, see http://bit.ly/h7mdIL
;;----------------------------------------------------------------------------
(defun sanityinc/backward-up-sexp (arg)
  "Jump up to the start of the ARG'th enclosing sexp."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (sanityinc/backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))

(global-set-key [remap backward-up-list] 'sanityinc/backward-up-sexp) ; C-M-u, C-M-up


;;----------------------------------------------------------------------------
;; Cut/copy the current line if no region is active
;;----------------------------------------------------------------------------
(use-package whole-line-or-region
             :ensure t
             :hook
             (after-init . whole-line-or-region-global-mode)
             :bind
             ("C-M-w" . whole-line-or-region-delete-region))
(after-load 'whole-line-or-region
  (diminish 'whole-line-or-region-local-mode))


;; Some local minor modes clash with CUA rectangle selection

(defvar-local sanityinc/suspended-modes-during-cua-rect nil
  "Modes that should be re-activated when cua-rect selection is done.")

(eval-after-load 'cua-rect
  (advice-add 'cua--deactivate-rectangle :after
              (lambda (&rest _)
                (dolist (m sanityinc/suspended-modes-during-cua-rect)
                  (funcall m 1)
                  (setq sanityinc/suspended-modes-during-cua-rect nil)))))

(defun sanityinc/suspend-mode-during-cua-rect-selection (mode-name)
  "Add an advice to suspend `MODE-NAME' while selecting a CUA rectangle."
  (eval-after-load 'cua-rect
    (advice-add 'cua--activate-rectangle :after
                (lambda (&rest _)
                  (when (bound-and-true-p mode-name)
                    (push mode-name sanityinc/suspended-modes-during-cua-rect)
                    (funcall mode-name 0))))))

(sanityinc/suspend-mode-during-cua-rect-selection 'whole-line-or-region-local-mode)




(defun sanityinc/open-line-with-reindent (n)
  "A version of `open-line' which reindents the start and end positions.
If there is a fill prefix and/or a `left-margin', insert them
on the new line if the line would have been blank.
With arg N, insert N newlines."
  (interactive "*p")
  (let* ((do-fill-prefix (and fill-prefix (bolp)))
         (do-left-margin (and (bolp) (> (current-left-margin) 0)))
         (loc (point-marker))
         ;; Don't expand an abbrev before point.
         (abbrev-mode nil))
    (delete-horizontal-space t)
    (newline n)
    (indent-according-to-mode)
    (when (eolp)
      (delete-horizontal-space t))
    (goto-char loc)
    (while (> n 0)
      (cond ((bolp)
             (if do-left-margin (indent-to (current-left-margin)))
             (if do-fill-prefix (insert-and-inherit fill-prefix))))
      (forward-line 1)
      (setq n (1- n)))
    (goto-char loc)
    (end-of-line)
    (indent-according-to-mode)))

;; (global-set-key (kbd "C-o") 'sanityinc/open-line-with-reindent)


;;----------------------------------------------------------------------------
;; Random line sorting
;;----------------------------------------------------------------------------
(defun sanityinc/sort-lines-random (beg end)
  "Sort lines in region from BEG to END randomly."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr nil 'forward-line 'end-of-line nil nil
                   (lambda (s1 s2) (eq (random 2) 0)))))))




(use-package highlight-escape-sequences
             :ensure t
             :hook
             (after-init . hes-mode))


(use-package which-key
             :ensure t
             :hook
             (after-init . which-key-mode)
             :config
             (setq-default which-key-idle-delay 1.5))
(after-load 'which-key
  (diminish 'which-key-mode))


(defun sanityinc/disable-features-during-macro-call (orig &rest args)
  "When running a macro, disable features that might be expensive.
ORIG is the advised function, which is called with its ARGS."
  (let (post-command-hook
        font-lock-mode
        (tab-always-indent (or (eq 'complete tab-always-indent) tab-always-indent)))
    (apply orig args)))

(advice-add 'kmacro-call-macro :around 'sanityinc/disable-features-during-macro-call)


(provide 'init-editing-utils)
;;; init-editing-utils.el ends here
