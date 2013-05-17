;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'auto-complete-config nil t)
  (ac-config-default)

  ;; ユーザ辞書
  (setq ac-user-dictionary '("kshimo69@gmail.com"
                             "Kimihiko Shimomura"
                             ))

  ;; historyの保存先
  (setq ac-comphist-file (expand-file-name "~/.emacs.d/var/ac-comphist.dat"))

  ;; 補完メニュー表示時のみC-n/C-pで補完候補を選択
  (setq ac-use-menu-map t)
  ;; デフォルトで設定済み
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)

  ;; auto-complete-modeを有効にするモードを追加
  (add-to-list 'ac-modes 'text-mode 'html-mode)

  ;; 大文字・小文字を区別しない
  ;; (setq ac-ignore-case t)
  ;; 補完対象に大文字が含まれる場合のみ区別する
  (setq ac-ignore-case 'smart)
  ;; ;; 大文字・小文字を区別する
  ;; (setq ac-ignore-case nil)

  ;; auto-completeをキーに割りあてておく
  ;; (global-set-key (kbd "M-/") 'auto-complete)

  ;; 補完開始までの秒数
  ;; (setq ac-auto-start 4)

  ;; auto-startせずにTABキーで補完開始する場合
  ;; (setq ac-auto-start nil)
  ;; (ac-set-trigger-key "TAB")

  ;; http://d.hatena.ne.jp/kitokitoki/20100627/p1
  ;; リージョンを開いているバッファのメジャーモードの辞書へ追加する
  (defvar auto-complete-dict-path "~/.emacs.d/share/ac-dict/")
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/share/ac-dict/")
  (defun append-region-to-auto-complete-dict ()
    (interactive)
    (when (and transient-mark-mode mark-active)
      (let ((path (concat auto-complete-dict-path (prin1-to-string major-mode)))
            (str (concat "\n" (buffer-substring-no-properties (region-beginning) (region-end)))))
        (with-temp-buffer
          (insert str)
          (append-to-file (point-min) (point-max) path)))))

  (global-set-key (kbd "M-h") 'append-region-to-auto-complete-dict)

  ;; http://d.hatena.ne.jp/kitokitoki/20110409/p3
  (setq ac-source-dictionary
        ;; '((candidates . ac-dictionary-candidates)
        '((candidates . ac-buffer-dictionary)
          (match . substring)
          (symbol . "d")))
  )
