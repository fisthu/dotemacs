(when (or (executable-find "aspell")
          (executable-find "ispell")
          (executable-find "hunspell"))
  (eval-when-compile (require 'cl))

  (defgroup dotemacs-spelling nil
    "Configuration options for spelling."
    :group 'dotemacs
    :prefix 'dotemacs-spelling)

  (defcustom dotemacs-spelling/major-modes
    '(
      org-mode
      markdown-mode
      )
    "List of major modes to enable spelling in."
    :type '(repeat (symbol))
    :group 'dotemacs-spelling)

  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (when (cl-find-if
                     (lambda (mode) (derived-mode-p mode))
                     dotemacs-spelling/major-modes)
                (turn-on-flyspell)))))

(provide 'init-spelling)
