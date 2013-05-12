;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 保存先変更
(set-default 'recentf-save-file "~/.emacs.d/var/recentf")

;; 履歴一覧を開く
;; (auto-install-from-emacswiki "recentf-ext.el")
(when (require 'recentf-ext nil t)
  (global-set-key (kbd "C-x f") 'recentf-open-files)
  (setq recentf-max-saved-items 500)
  (setq recentf-exclude '("/GTAGS$"))
  )
