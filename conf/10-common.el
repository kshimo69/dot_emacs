;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; user設定
(setq user-full-name "Kimihiko Shimomura")
(setq user-mail-address "kshimo69@gmail.com")

;; 初期位置
(cd "~/")

;; スタートアップ時のメッセージを抑制
(setq inhibit-startup-message t)

;; scratch のメッセージを空にする
(setq initial-scratch-message nil)

;; emacsclient を利用するためにサーバ起動
;; サーバが起動していた場合は先に起動していた方を優先
(if window-system
    (progn
      (require 'server)
      (unless (server-running-p) (server-start))
      (defun skt:raise-frame()
        ;; Frame を前面にする
        (raise-frame (selected-frame))
        ;; キーボードフォーカスを選択しているFrameにする
        (x-focus-frame (selected-frame)))
      (add-hook 'server-visit-hook 'skt:raise-frame)
      (add-hook 'find-file-hook 'skt:raise-frame)
      ))

;; メニューバー、ツールバー非表示
;; (menu-bar-mode nil)
(tool-bar-mode nil)
(scroll-bar-mode nil)

;; ヴィジブルベルを抑制
(setq visible-bell nil)

;; ビープ音を抑制
(setq ring-bell-function '(lambda ()))

;; カーソルの点滅を抑制
;; (blink-cursor-mode 0)

;; 行数、列数を表示
(line-number-mode t)
(column-number-mode t)

;; %の代わりに全体の行数を表示する
(setcar mode-line-position
        '(:eval (format "%d" (count-lines (point-max) (point-min)))))

;; 時刻を表示
(setq display-time-string-forms
      '(24-hours ":" minutes " " month "/" day "(" dayname ")"))
(display-time)

;; 曜日表示は英語
(setq system-time-locale "C")

;; 行番号を表示
;; http://macemacsjp.sourceforge.jp/index.php?CocoaEmacs#aae602ba
(global-linum-mode t)
;; (dolist (hook (list
;;               'c-mode-hook
;;               'c++-mode-hook
;;               'cperl-mode-hook
;;               'emacs-lisp-mode-hook
;;               'lisp-interaction-mode-hook
;;               'lisp-mode-hook
;;               'java-mode-hook
;;               'js2-mode-hook
;;               'sh-mode-hook
;;               'python-mode-hook
;;               'ruby-mode-hook
;;               'text-mode-hook
;;               'rst-mode-hook
;;               ))
;; (add-hook hook (lambda () (linum-mode t))))

;; バックアップしない
;; (setq make-backup-files nil)

;; 自動保存したファイルを削除する。
;; (setq delete-auto-savefiles t)

;; 自動セーブしない。
;; (setq auto-save-default nil)

;; ファイルを編集した場合コピーにてバックアップする
;; inode 番号を変更しない
(setq backup-by-copying t)
;; バックアップファイルの保存位置指定
;; !path!to!file-name~ で保存される
(setq backup-directory-alist
      '(
        ("." . "~/.emacs.d/var/emacs")
        ))

;; TAB はスペース 4 個ぶんを基本
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; 個人用infoディレクトリを追加
;; 全体のinfo優先
;; (setq Info-default-directory-list
;;       (cons (expand-file-name "~/.emacs.d/info/")
;;             Info-default-directory-list))
;; 個人用infoディレクトリを優先
;; (setq Info-default-directory-list
;;       (append Info-default-directory-list
;;               (list (expand-file-name "~/.emacs.d/info"))))

;; ファイル名の1階層上を表示する
(when (require 'uniquify nil t)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  ;; *で囲まれたバッファ名は対象外
  (setq uniquify-ignore-buffers-re "*[^*]+*")
  )

;; シンボリックファイルを開く時にいちいち聞かない
(setq vc-follow-symlinks t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; default to unified diffs
(setq diff-switches "-u")

;; 行末の空白をめだたせる M-x delete-trailing-whitespaceで削除出来る
(when (boundp 'show-trailing-whitespace) (setq-default show-trailing-whitespace t))

;; ファイルの最後には \n
(setq require-final-newline t)

;; BSで選択範囲を消す
(delete-selection-mode 1)

;; マウスで選択するとコピーする Emacs 24 ではデフォルトが nil
(setq mouse-drag-copy-region t)
