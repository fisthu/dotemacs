(require-package 'flycheck)
(require-package 'add-node-modules-path)

(setq flycheck-standard-error-navigation t)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc html-tidy javascript-jshint))

(after 'web-mode
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'flycheck-mode-hook 'add-node-modules-path)

(when (display-graphic-p)
  (require-package 'flycheck-pos-tip)
  (setq flycheck-pos-tip-timeout -1)
  (flycheck-pos-tip-mode))

(defun /flycheck/advice/next-error-find-buffer (orig-func &rest args)
  (let* ((special-buffers
          (cl-loop for buffer in (mapcar #'window-buffer (window-list))
                   when (with-current-buffer buffer
                          (and
                           (eq (get major-mode 'mode-class) 'special)
                           (boundp 'next-error-function)))
                   collect buffer))
         (first-special-buffer (car special-buffers)))
    (if first-special-buffer
        first-special-buffer
      (apply orig-func args))))

(advice-add #'next-error-find-buffer :around #'/flycheck/advice/next-error-find-buffer)

(provide 'config-flycheck)
