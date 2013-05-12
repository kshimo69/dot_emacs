;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 使い捨てのファイルを開く
;; (auto-install-from-emacswiki "open-junk-file.el")
(when (require 'open-junk-file nil t)
  (setq open-junk-file-format "~/junk/%Y%m%d-%H%M%S.")
  )
