;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; C-hをバックスペースに
(global-set-key (kbd "C-h") 'delete-backward-char)

;; マウスで選択するとコピーする Emacs 24 ではデフォルトが nil
(setq mouse-drag-copy-region t)
