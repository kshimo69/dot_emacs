;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ファイル保存時に自動的にバイトコンパイルする
;; (auto-install-from-emacswiki "auto-async-byte-compile.el")
(when (require 'auto-async-byte-compile nil t)
  ;; 自動バイトコンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "~/junk/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  )
