;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'rst nil t)
  ;; http://d.hatena.ne.jp/ymotongpoo/20101106/1289007403
  (setq auto-mode-alist
        (append '(("\\.rst$" . rst-mode)
                  ("\\.rest$" . rst-mode)) auto-mode-alist))
  ;; 黒背景
  (setq frame-background-mode 'dark)
  ;; スペースでインデント
  (add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))
  )
