(setq-default cursor-type 'bar)
(setq-default tab-width 4)
(setq helm-split-window-in-side-p t)
(desktop-save-mode 1)
(smartparens-global-mode t)
(show-smartparens-global-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode +1)
(global-anzu-mode +1)
(whole-line-or-region-global-mode 1)
(global-undo-tree-mode 1)
(scroll-bar-mode -1)
(ac-config-default)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; (set-face-background 'hl-line "#555555")
;;auto highlight config
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(require 'server)
(require 'init_funcs)
(defadvice server-create-window-system-frame
  (after set-window-system-frame-colours ())
  "Set custom frame colours when creating the first frame on a display"
  (message "Running after frame-initialize")
  (setup-window-system-frame-colours))
(ad-activate 'server-create-window-system-frame)
(add-hook 'after-make-frame-functions 'setup-window-system-frame-colours t)

;;=== PYTHON ========================================================

(setq jedi:complete-on-dot t)

;;=== ORGMODE ========================================================

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)



(provide 'init_general)
