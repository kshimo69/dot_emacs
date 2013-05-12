;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ファイルが#!から始まる場合に実行権をつける
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
