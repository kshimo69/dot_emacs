;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; コマンド連続実行時の動作を変える
;; (auto-install-batch "sequential-command")
(when (require 'sequential-command-config nil t)
  (sequential-command-setup-keys)
  )
