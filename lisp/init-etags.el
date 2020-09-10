;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Filename: init-etags.el
;;Description:
;;Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;;Maintainer:
;;Created: Thu Sep 10 15:38:07 2020 (+0200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package etags
             :ensure t
             :bind
             (("M-g d" . xref-find-definitions)
              ("M-g r" . xref-find-references)
              ("M-g b" . xref-pop-marker-stack)
              ("M-g o" . xref-find-definitions-other-window)))

(defun refresh-project-tags ()
  "Rewfres the TAG file of one project."
  (interactive)
  (let
      ((tag-dir (locate-dominating-file buffer-file-name tag-file)))
    (if tag-dir
        (shell-command (format
                        "find %s \\( -name \"*.[chCH]\" -o -name \"*.go\" \\) -print | etags - -o %s"
                        tag-dir
                        "~/.emacs.d/TAGS"))
      (print (format "No %s file found in project." tag-file)))))

(provide 'init-etags)
