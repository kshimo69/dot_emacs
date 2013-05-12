;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 使わないバッファを自動的に消す
;; (auto-install-from-emacswiki "tempbuf.el")
(when (require 'tempbuf nil t)
  (setq tempbuf-life-extension-ratio 100)
  ;; ファイルを開いたら自動的にtempbufを有効にする
  (add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
  ;; diredバッファに対してtempbufを有効にする
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
  )
