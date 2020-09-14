;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-ggtags.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Mon Sep 14 17:45:05 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ggtags
             :ensure t
             :config
             (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
             :hook
             (c-mode-common . (lambda ()
                                (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                                  (ggtags-mode 1)))))

(use-package helm-gtags
             :ensure t
             :config
             (setq
              helm-gtags-ignore-case t
              helm-gtags-auto-update t
              helm-gtags-use-input-at-cursor t
              helm-gtags-pulse-at-cursor t
              helm-gtags-prefix-key "\C-cg"
              helm-gtags-suggested-key-mapping t)
             :hook
             ((dired-mode
               eshell-mode
               c-mode
               asm-mode) . helm-gtags-mode)
             :bind
             (:map helm-gtags-mode-map
                   ("C-c g a" . helm-gtags-tags-in-this-function)
                   ("C-j" . helm-gtags-select)
                   ("M-." . helm-gtags-dwim)
                   ("M-," . helm-gtags-pop-stack)
                   ("C-c <" . helm-gtags-previous-history)
                   ("C-c >" . helm-gtags-next-history)))

(provide 'init-ggtags)
