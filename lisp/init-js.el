;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-js.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Mon Apr 26 13:51:36 2021 (+0200)
;; Last-Updated: Mon Apr 26 13:55:50 2021 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode :ensure t :defer 20
  :mode
  (("\\.js\\'" . js2-mode))
  :custom
  (js2-include-node-externs t)
  (js2-global-externs '("customElements"))
  (js2-highlight-level 3)
  (js2r-prefer-let-over-var t)
  (js2r-prefered-quote-type 2)
  (js-indent-align-list-continuation t)
  (global-auto-highlight-symbol-mode t)
  :config
  (setq js-indent-level 2)
  ;; patch in basic private field support
  (advice-add #'js2-identifier-start-p
            :after-until
            (lambda (c) (eq c ?#))))

(use-package which-key :ensure t
  :config
  (which-key-mode))


(use-package company-quickhelp :ensure t :defer 30
  :config
  (company-quickhelp-mode t))

(use-package dumb-jump :ensure t :defer 10
  :custom
  (dumb-jump-rg-search-args '())
  :config
  (defun jump-to-mouse-position (event &optional promote-to-region)
    (interactive "e\np")
    (mouse-set-point event promote-to-region)
    (dumb-jump-go))
  (global-unset-key [C-down-mouse-1])
  (define-key global-map [C-mouse-1] 'jump-to-mouse-position))


(use-package flymake-eslint :ensure t :defer 10
  :custom ;; add glasses-mode to bolden capitals in CamelCase here. Could also be done elsewhere.
  (glasses-face (quote bold))
  (glasses-original-separator "")
  (glasses-separate-capital-groups t)
  (glasses-separate-parentheses-p nil)
  (glasses-separator "")
  :config
  (add-hook 'js-mode-hook (lambda () (flymake-eslint-enable)(flymake-mode -1)(flycheck-mode 1)(glasses-mode 1)))
  (add-hook 'js2-mode-hook (lambda () (flymake-eslint-enable)(flymake-mode -1)(flycheck-mode 1)(glasses-mode 1)))
  (custom-set-variables
     '(help-at-pt-timer-delay 0.3)
     '(help-at-pt-display-when-idle '(flymake-overlay))))
(use-package flymake-diagnostic-at-point :ensure t :defer 20
  :config
  (flymake-diagnostic-at-point-mode t))

(use-package tern :ensure t :defer 30
  :if (locate-file "tern" exec-path)
  :hook (js2-mode . tern-mode))
(use-package json-mode :ensure t :defer 20
  :custom
  (json-reformat:indent-width 2)
  :mode (("\\.bowerrc$"     . json-mode)
         ("\\.jshintrc$"    . json-mode)
         ("\\.json_schema$" . json-mode)
         ("\\.json\\'" . json-mode))
  :bind (:package json-mode-map
         :map json-mode-map
         ("C-c <tab>" . json-mode-beautify)))

(use-package js2-refactor :ensure t :defer 30
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-m"))
;; context menu for keybindings
(use-package discover :ensure t :defer 30
  :config
  (global-discover-mode 1))

(use-package tabbar :ensure t)

(use-package rainbow-identifiers :ensure t
  :config
  (defun rainbow-identifiers--bolden-faces ()
    (dotimes (i 15) ;; TODO: use number of faces as customized
      (face-remap-add-relative (intern (format "rainbow-identifiers-identifier-%d" (1+ i))) :weight 'bold)))
  (add-hook 'rainbow-identifiers-mode-hook 'rainbow-identifiers--bolden-faces)
  (rainbow-identifiers--bolden-faces))

(provide 'init-js)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-js.el ends here
