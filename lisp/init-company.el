;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-company.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Mon Sep 14 18:25:39 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
             :ensure t
             :hook
             (after-init . global-company-mode)
             :config
             (add-hook 'c-mode-common-hook
                       (lambda ()
                         (define-key c-mode-base-map [(tab)] 'company-complete))))

(provide 'init-company)
