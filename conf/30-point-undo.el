;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; カーソル位置を戻す
;; (auto-install-from-emacswiki "point-undo.el")
(when (require 'point-undo nil t)
  (global-set-key (kbd "<f6>") 'point-undo)
  (global-set-key (kbd "S-<f6>") 'point-redo)
  )
