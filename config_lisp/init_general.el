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
(ac-config-default)
(set-face-background 'hl-line "#111111")
;;auto highlight config
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
;;th one in the cursor
(set-face-attribute 'ahs-plugin-defalt-face nil
					:foreground "#A7E4F2"
					:background "#111111"
					:underline "#D11754")
;;the rest of the buffer
(set-face-attribute 'ahs-face nil
					:foreground (face-foreground 'default)
					:background (face-background 'default)
					:underline "#F4D4AD")
(set-face-attribute 'ahs-plugin-whole-buffer-face nil
					:foreground "#A7E4F2"
					:background "#111111"
					:underline "#D11754")
(set-face-attribute 'ahs-plugin-bod-face nil
					:foreground "#FFDD99"
					:background "#111111"
					:underline "#FFE2C5")

(provide 'init_general)
