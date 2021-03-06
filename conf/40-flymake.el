;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'flymake nil t)
  ;; face when error/warning
  (set-face-background 'flymake-errline "red4")
  (set-face-foreground 'flymake-errline "white")
  (set-face-background 'flymake-warnline "yellow")
  (set-face-foreground 'flymake-warnline "black")

  ;; print error to minibuffer
  ;; http://d.hatena.ne.jp/xcezx/20080314/1205475020
  (defun flymake-display-err-minibuf ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (let* ((line-no (flymake-current-line-no))
           (line-err-info-list (nth 0 (flymake-find-err-info
                                       flymake-err-info line-no)))
           (count (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((file (flymake-ler-file
                        (nth (1- count) line-err-info-list)))
                 (full-file (flymake-ler-full-file
                             (nth (1- count) line-err-info-list)))
                 (text (flymake-ler-text
                        (nth (1- count) line-err-info-list)))
                 (line (flymake-ler-line
                        (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))
  (define-key global-map (kbd "C-c e") 'flymake-display-err-minibuf)

  (defun flymake-get-make-cmdline (source base-dir)
    (list "make"
          (list "-s" "-C"
                base-dir
                (concat "CHK_SOURCES=" source)
                "SYNTAX_CHECK_MODE=1")))

  (defadvice flymake-goto-next-error (after display-message activate compile)
    "Display the error in the minibuffer."
    (flymake-display-err-minibuffer))

  (defadvice flymake-goto-prev-error (after display-message activate compile)
    "Display the error in the minibuffer."
    (flymake-display-err-minibuffer))

  (defun flymake-create-temp-in-system-tempdir (filename prefix)
    (make-temp-file (or prefix "flymake")))

  )
