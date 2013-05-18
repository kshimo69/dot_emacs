;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 保存先変更
(set-default 'recentf-save-file "~/.emacs.d/var/recentf")

(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-auto-cleanup 30)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 300 t 'recentf-save-list))
  ;; 保存ファイルの設定に リモートファイル tramp の先等を追加。
  ;; これを実施すると起動時にパスワード等の確認はされない
  (add-to-list 'recentf-keep 'file-remote-p)
  (add-to-list 'recentf-keep 'file-readable-p)
  ;; 除外ファイル
  (setq recentf-exclude
        '("\\.elc$"
          "\\.pyc$"
          "\\.cache$"
          "recentf$"
          "revive$"
          ))
  ;; Emacs 終了時に cleanup
  (add-hook 'kill-emacs-query-functions 'recentf-cleanup)
  (recentf-mode 1)
)

;; 履歴一覧を開く
;; (auto-install-from-emacswiki "recentf-ext.el")
(when (require 'recentf-ext nil t)
  (global-set-key (kbd "C-x f") 'recentf-open-files)
  (setq recentf-max-saved-items 500)
  (setq recentf-exclude '("/GTAGS$"))
  )
