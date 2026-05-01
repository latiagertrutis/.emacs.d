(use-package rustic
  :hook
  (rust-mode . lsp)
  :config
  (setq rustic-format-on-save t
	rustic-rustfmt-bin "/usr/bin/cargo"
	rustic-rustfmt-args "fmt"))


(provide 'init-rust)
