(require-package 'lsp-java)
(setq lsp-java-vmargs
      (list
       "-noverify"
       "-Xmx1G"
       "-XX:+UseG1GC"
       "-XX:+UseStringDeduplication")
      lsp-java-save-actions-organize-imports nil
      lsp-java-java-path "/usr/bin/java")

(add-hook 'java-mode-hook #'/lsp/activate)

(provide 'config-java)
