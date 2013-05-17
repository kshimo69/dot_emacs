;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; user設定
(setq user-full-name "Kimihiko Shimomura")
(setq user-mail-address "kshimo69@gmail.com")

;; 初期位置
(cd "~/")

;; exec-path、PATH、MANPATHの追加 (下が優先)
;; http://sakito.jp/emacs/emacsshell.html
(dolist (dir (list
              "/sbin"
              "/bin"
              "/usr/sbin"
              "/usr/bin"
              "/usr/local/sbin"
              "/usr/local/bin"
              "/opt/local/sbin"
              "/opt/local/bin"
              (expand-file-name "~/local/bin")
              (expand-file-name "~/bin")
              ))
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))
(setenv "MANPATH"
        (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man"
                (getenv "MANPATH")))

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

;; メニューバー、ツールバー、スクロールバー非表示
;; (menu-bar-mode nil)
;; (tool-bar-mode nil)
(tool-bar-mode -1)
;; (scroll-bar-mode nil)
(scroll-bar-mode -1)

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
        ("." . "~/.emacs.d/var/backup")
        ))

;; TAB はスペース 4 個ぶんを基本
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; スクロール時のカーソル位置の維持
(setq scroll-preserve-screen-position t)

;; スクロール行数（一行ごとのスクロール）
(setq vertical-centering-font-regexp ".*")
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)

;; 画面スクロール時の重複行数
(setq next-screen-context-lines 1)

;; 個人用infoディレクトリを追加
(require 'info)
;; 全体のinfo優先
;; (setq Info-default-directory-list
;;       (cons (expand-file-name "~/.emacs.d/info/")
;;             Info-default-directory-list))
;; 個人用infoディレクトリを優先
(setq Info-default-directory-list
      (append Info-default-directory-list
              (list (expand-file-name "~/.emacs.d/info"))))

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

;; yes or no を y or n に
(fset 'yes-or-no-p 'y-or-n-p)

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

;; C-u C-SPC C-SPC... でカーソル位置を辿る
;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
(setq set-mark-command-repeat-pop t)

;; カーソル位置のファイル名、URLで開く
(ffap-bindings)

;; GUI上のコピー
(setq x-select-enable-primary t)

;; kill-ringに同じ内容の文字列を入れない
;; http://d.hatena.ne.jp/kitokitoki/20100515/p1
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))

;; Emacsを終了してもファイルを編集してた位置やminibuffer への入力内容を覚えておく
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  ;; これがないと file-name-history に500個保存する前に max-string に達する
  (setq session-globals-max-string 100000000)
  ;; デフォルトでは30!
  (setq history-length t)
  (add-hook 'after-init-hook 'session-initialize))

;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)
(setq savehist-file (expand-file-name "~/.emacs.d/var/history"))
;; savehistのファイルに保存する履歴からfile-name-historyをのぞく
(setq savehist-ignored-variables '(file-name-history))

;; ファイル内のカーソル位置を記録する
(require 'saveplace nil t)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/var/emacs-places")

;; ログの記録行数を減らす
(setq message-log-max 10000)

;; ミニバッファを再帰的に呼び出せるようにする
(setq enable-recursive-minibuffers t)

;; *scratch* バッファを消さないように
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))
(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

;; 終了時に聞く
(setq confirm-kill-emacs 'y-or-n-p)
