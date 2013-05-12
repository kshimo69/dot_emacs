;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 変更箇所にジャンプする
;; (auto-install-from-emacswiki "goto-chg.el")
(when (require 'goto-chg nil t)
  (global-set-key (kbd "<f7>") 'goto-last-change)
  (global-set-key (kbd "S-<f7>") 'goto-last-change-reverse)
  )
