;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://www.namazu.org/~tsuchiya/sdic/index.html
(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key (kbd "C-c W") 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point
  "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key (kbd "C-c w") 'sdic-describe-word-at-point)

;; http://d.hatena.ne.jp/khiker/20100303/sdic_inline
;; (auto-install-from-emacswiki "sdic-inline.el")
;; (auto-install-from-emacswiki "pos-tip.el")
;; (auto-install-from-emacswiki "sdic-inline-pos-tip.el")
(when (require 'sdic-inline nil t)
  ;; sdic-inline モードの起動
  (sdic-inline-mode t)
  ;; 辞書ファイルの設定
  ;; (setq sdic-inline-dictionary-encoding 'euc-jp)
  (setq sdic-inline-eiwa-dictionary "~/.emacs.d/share/sdic/gene.sdic")
  (setq sdic-inline-waei-dictionary "~/.emacs.d/share/sdic/jedict.sdic")
  ;; major-mode を基準にオン・オフを判断しなくする。
  (setq sdic-inline-enable-modes nil)
  ;; w3m-mode でも動作するようにする。
  (add-to-list 'sdic-inline-enable-modes 'w3m-mode)
  ;; テキスプロパティを基準にオン・オフを判断しなくする。
  (setq sdic-inline-enable-faces nil)
  ;; 空白の上にポイントがあったら検索しない
  (setq sdic-inline-word-at-point-strict t)
  ;; 過去形や活用を除去して検索する
  (setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
  ;; どんなファイル名でも有効にする
  (setq sdic-inline-enable-filename-regex ".*$")
  ;; popupを有効に
  (require 'popup nil t)

  ;; http://www.emacswiki.org/emacs/sdic-inline-pos-tip.el
  (require 'sdic-inline-pos-tip nil t)
  ;; リージョン選択時だけ単語の意味を表示
  (defun sdic-inline-pos-tip-show-when-region-selected (entry)
    (cond
     ((and transient-mark-mode mark-active)
      (funcall 'sdic-inline-pos-tip-show entry))
     (t
      ; (funcall 'sdic-inline-display-minibuffer entry)
        )))
  ;; (setq sdic-inline-display-func 'sdic-inline-pos-tip-show)
  (setq sdic-inline-display-func 'sdic-inline-pos-tip-show-when-region-selected)
  ;; (define-key sdic-inline-map (kbd "C-c C-p") 'sdic-inline-pos-tip-show)
  (add-hook 'sdic-inline-hook '(lambda ()
                                 (define-key sdic-inline-map (kbd "C-c C-p")
                                   nil)
                                 ))
  (global-set-key (kbd "C-c w") 'sdic-inline-pos-tip-show)
  )
