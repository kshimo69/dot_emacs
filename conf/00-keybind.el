;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; C-hをバックスペースに
(global-set-key (kbd "C-h") 'delete-backward-char)

;; Scroll buffer without moving the cursor
(global-set-key (kbd "M-p") '(lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "M-n") '(lambda () (interactive) (scroll-up 1)))
