(use-package company
	     :ensure t
	     )

(use-package flycheck
	     :ensure t
	     )

(use-package irony
  :ensure t
  )

(use-package irony-eldoc
	     :ensure t
	     )

(use-package flycheck-irony
	     :ensure t
	     )

(use-package company-irony
	     :ensure t
	     )

(provide 'init_packages)

(use-package ample-theme
  :ensure t
  )

(use-package smartparens
  :ensure t
  )

(use-package undo-tree
  :ensure t
  )

(use-package rainbow-delimiters
  :ensure t
  )

(use-package magit
  :ensure t
  )

(use-package iedit
  :ensure t
  )

(use-package helm
  :ensure t
  )

(use-package avy
  :ensure t
  )

(use-package ws-butler
  :ensure t
  )

(use-package whole-line-or-region
  :ensure t
  )

(use-package anzu
  :ensure t
  )

(use-package auto-highlight-symbol
  :ensure t
  )

(use-package auto-complete
  :ensure t
  )

(use-package jedi
  :ensure t
  )

(use-package lice
  :ensure t
  )

(use-package json-mode
  :ensure t
  )

(use-package omnisharp
  :ensure t
  )

(use-package org
  :ensure t
  )

(load-file "~/.emacs.d/plugins/header/list.el")
(load-file "~/.emacs.d/plugins/header/string.el")
(load-file "~/.emacs.d/plugins/header/comments.el")
(load-file "~/.emacs.d/plugins/header/header.el")
(load-file "~/.emacs.d/plugins/header/header2.el")

(provide 'init_packages)
