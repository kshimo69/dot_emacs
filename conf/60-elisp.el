;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; Emacs Lisp関数・変数のヘルプをエコーエリアに表示する
(when (require 'eldoc-extension nil t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  (setq eldoc-idle-delay 0.4)
  (setq eldoc-minor-mode-string "")
  )

;; Emacs Lisp式の値をコメントで注釈する
(when (require 'lispxmp nil t))
