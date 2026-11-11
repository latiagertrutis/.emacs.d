(defconst gptel-roam-files
  `(,(expand-file-name "20261103180248-gptel.org" org-roam-directory)))

(use-package gptel
  :bind (("C-c g g" . gptel)             ; open gptel chat buffer
         ("C-c g s" . gptel-send)        ; send prompt/region
         ("C-c g m" . gptel-menu)        ; transient menu: model, backend, context
         ("C-c g r" . gptel-rewrite)     ; rewrite region (diff-based)
         ("C-c g c" . gptel-add)         ; add region/buffer to context
         ("C-c g k" . gptel-abort))      ; cancel in-flight request
  :config
  (setopt
   gptel-default-mode 'org-mode
   gptel-org-branching-context t
   gptel-backend
   (gptel-make-openai "OpenRouter"
		      :host "openrouter.ai"
		      :endpoint "/api/v1/chat/completions"
		      :stream t
		      :key (funcall
			    (plist-get
			     (car (auth-source-search :host "openrouter.ai" :user "gptel"))
			     :secret))
		      :models '(nvidia/nemotron-3-ultra-550b-a55b:free
				openai/gpt-6-luna
				deepseek/deepseek-v4-flash-0731
				xiaomi/mimo-v2.6-pro
				openai/gpt-6-luna-pro)))
  (setf (alist-get 'org-mode gptel-prompt-prefix-alist) "@user ")
  (setf (alist-get 'org-mode gptel-response-prefix-alist) "@assistant ")
  :hook
  ((gptel-post-stream . gptel-auto-scroll)
   (gptel-post-response . gptel-end-of-response)))

(defun my/gptel-roam-hook ()
  (interactive)
  (dolist (file gptel-roam-files)
    (when (equal (buffer-file-name) file)
      (gptel-mode))))

(add-hook 'org-mode-hook #'my/gptel-roam-hook)

(defface my-org-user-face
  '((t :foreground "#8fbcbb"
       :background "#4c566a"
       :box "#8fbcbb"
       :family "Mononoki Nerd Font"
       :weight bold
       :slant italic))
  "Face for @user markers.")

(defface my-org-assistant-face
  '((t :foreground "#ebcb8b"
       :background "#4c566a"
       :box "#ebcb8b"
       :family "Mononoki Nerd Font"
       :weight bold
       :slant italic))
  "Face for @assistant markers.")

(defvar my-org-speaker-keywords
  '(("\\s-*\\(@user\\)\\s-*" 1 'my-org-user-face prepend)
    ("\\s-*\\(@assistant\\)\\s-*" 1 'my-org-assistant-face prepend)))

(defun my-org-enable-speaker-highlighting ()
  (font-lock-add-keywords nil my-org-speaker-keywords 'append)
  (font-lock-flush))

(add-hook 'org-mode-hook #'my-org-enable-speaker-highlighting)


(use-package gptel-agent
  :after gptel)

(provide 'init-gpt)
