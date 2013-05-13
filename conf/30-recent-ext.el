;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 保存先変更
(set-default 'recentf-save-file "~/.emacs.d/var/recentf")

(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '("recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))

;; 履歴一覧を開く
;; (auto-install-from-emacswiki "recentf-ext.el")
(when (require 'recentf-ext nil t)
  (global-set-key (kbd "C-x f") 'recentf-open-files)
  (setq recentf-max-saved-items 500)
  (setq recentf-exclude '("/GTAGS$"))
  )
