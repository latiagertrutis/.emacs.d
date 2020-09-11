;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-markdown.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Fri Sep 11 11:52:43 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
             :ensure t
             :config
             (add-auto-mode 'markdown-mode "\\.md\\.html\\'")
             (after-load 'whitespace-cleanup-mode
               (push 'markdown-mode whitespace-cleanup-mode-ignore-modes)))

(provide 'init-markdown)
