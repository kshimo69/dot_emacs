;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 現在の関数名を画面の上に表示する
(which-func-mode 1)
;; すべてのメジャーモードにwhich-func-modeを適用する
(setq which-func-modes t)
;; 画面上部に表示する
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format)))
(set-face-foreground 'which-func "pink")
