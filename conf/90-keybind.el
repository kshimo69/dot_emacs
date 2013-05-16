;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; C-hをバックスペースに
(global-set-key (kbd "C-h") 'delete-backward-char)

;; C-h に割り当てられている関数 help-command を C-x C-h に割り当てる
(global-set-key (kbd "C-x C-h") 'help-command)
(global-set-key (kbd "<f1>") 'help-for-help)

;;改行後に自動インデント
(global-set-key (kbd "C-m") 'newline-and-indent)

;; Scroll buffer without moving the cursor
(global-set-key (kbd "M-p") '(lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "M-n") '(lambda () (interactive) (scroll-up 1)))

;; C-q をプリフィックスキー化
(global-set-key (kbd "C-q") (make-sparse-keymap))

;; ;; quoted-insert は C-q C-q へ割り当て
;; (global-set-key (kbd "C-q C-q") 'quoted-insert)

;; window-resizer は C-q C-r (resize) で
(global-set-key (kbd "C-q C-r") 'window-resizer)

;; C-x o にはもううんざり
(global-set-key (kbd "C-q l") 'windmove-right)
(global-set-key (kbd "C-q h") 'windmove-left)
(global-set-key (kbd "C-q j") 'windmove-down)
(global-set-key (kbd "C-q k") 'windmove-up)

;; C-q C-qでウインドウ分割 or 移動
;; http://d.hatena.ne.jp/rubikitch/20100210/emacs
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-q C-q") 'other-window-or-split)

;; カーソル位置の単語をコピー
(global-set-key (kbd "M-c") 'ffap-copy-string-as-kill)

;; 範囲指定してない時にC-wで前の単語を削除
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))
;; minibuffer用
(define-key minibuffer-local-completion-map (kbd "C-w") 'backward-kill-word)

;; fullscreen
(defun toggle-fullscreen ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)
    ))
(global-set-key (kbd "M-<RET>") 'toggle-fullscreen)

;; 起動時に縦分割
;; (setq w (selected-window))
;; (split-window w nil t)

;; ;; C-+とC--でフォントサイズを変える
;; ;; http://emacs-fu.blogspot.com/2008/12/zooming-inout.html
;; (defun djcb-zoom (n)
;;   "with positive N, increase the font size, otherwise decrease it"
;;   (set-face-attribute 'default (selected-frame) :height
;;                       (+ (face-attribute 'default :height)
;;                          (* (if (> n 0) 1 -1) 10))))
;; (global-set-key (kbd "C-+")      '(lambda nil (interactive) (djcb-zoom 1)))
;; (global-set-key [C-kp-add]       '(lambda nil (interactive) (djcb-zoom 1)))
;; (global-set-key (kbd "C--")      '(lambda nil (interactive) (djcb-zoom -1)))
;; (global-set-key [C-kp-subtract]  '(lambda nil (interactive) (djcb-zoom -1)))

;; 略語展開、補完を行うコマンドをまとめる
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially   ;ファイル名の一部
        try-complete-file-name             ;ファイル名全体
        ;; try-expand-all-addrevs             ;静的略語展開
        try-expand-dabbrev                 ;動的略語展開(カレントバッファ)
        try-expand-dabbrev-all-buffers     ;動的略語展開(全バッファ)
        try-expand-dabbrev-from-kill       ;動的略語展開(キルリング)
        try-complete-lisp-symbol-partially ;Lispシンボルの一部
        try-complete-lisp-symbol           ;Lispシンボル全体
        ))
(global-set-key (kbd "M-/") 'hippie-expand)
