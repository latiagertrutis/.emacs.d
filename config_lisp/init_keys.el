
(bind-keys*
 ("C-:" . avy-goto-char)
 ("C-x g" . magit-status)
 ("C-x b" . helm-buffers-list)
 ("M-x" . helm-M-x)
 ("M-y" . helm-show-kill-ring)
 ("C-x C-f" . helm-find-files)
 ("M-<up>" . windmove-up)
 ("M-<down>" . windmove-down)
 ("M-<left>" . windmove-left)
 ("M-<right>" . windmove-right)
 ("M-S-<right>" . ahs-forward)
 ("M-S-<left>" . ahs-backward)
 ("C-<up>" . beginning-of-defun)
 ("C-<down>" . end-of-defun)
 ("C-c i" . indent-buffer)
 ("C-x 3" . new-window-right)
 ("C-c a" . align)
 ("C-." . dumb-jump-go)
 ("C-," . dumb-jump-back)
 )

(provide 'init_keys)
