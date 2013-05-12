;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 終了時バイトコンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p
                 (concat user-emacs-directory "init.el")
                 (concat user-emacs-directory "init.elc"))
                (byte-compile-file
                 (concat user-emacs-directory "init.el")))
            (byte-recompile-directory
             (concat user-emacs-directory "conf") 0)
            (byte-recompile-directory
             (concat user-emacs-directory "plugins") 0)
            (byte-recompile-directory
             (concat user-emacs-directory "elpa") 0)
            ))
