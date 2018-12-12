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
(set-face-background 'hl-line "#111111")
;;auto highlight config
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
;;the one in the cursor
(set-face-attribute 'ahs-plugin-defalt-face nil
					:foreground nil
					:background "#111111"
					:underline "dark orchid")
;;the rest of the buffer
(set-face-attribute 'ahs-face nil
					:foreground nil
					:background (face-background 'default)
					:underline "#F4D4AD")
(set-face-attribute 'ahs-plugin-whole-buffer-face nil
					:foreground nil
					:background "#111111"
					:underline "#D11754")
(set-face-attribute 'ahs-plugin-bod-face nil
					:foreground nil
					:background "#111111"
					:underline "#FFE2C5")

;;=== PYTHON ========================================================

(setq jedi:complete-on-dot t)

;;=== ORGMODE ========================================================

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)



(provide 'init_general)
