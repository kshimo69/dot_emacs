;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ブックマークファイル変更
(set-default 'bookmark-default-file "~/.emacs.d/var/emacs.bmk")

;; ブックマークを変更したら即保存する
(setq bookmark-save 1)
;; ブックマークの使い方
;; ブックマークの設定
;; C-x r m (bookmark-set)
;; ブックマーク選択メニューの表示
;; C-x r l (bookmark-bmenu-list)
;; 超整理法
(progn
  (setq bookmark-sort-flag nil)
  (defun bookmark-arrange-latest-top ()
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (cons latest (delq latest bookmark-alist))))
    (bookmark-save))
  (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))
