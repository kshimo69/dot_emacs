;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 透明
;; (set-frame-parameter nil 'alpha 80)
(set-frame-parameter (selected-frame) 'alpha '(80 50))

;; Mac用設定
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(setq grep-find-use-xargs 'bsd)
(setq browse-url-generic-program "open")

;; Ctrl/Cmd/Optionがシステムに渡されるのを防ぐ
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

;; 文字コード
;;(set-language-environment 'Japanese)
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)

;; Mac OS X の HFS+ ファイルフォーマットではファイル名は
;; NFD (の様な物)で扱う
;; 以下はファイル名を NFC で扱う環境と共同作業等する場合の対処
(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

;; inline-patch
;;(mac-add-key-passed-system 'shift)

;; バックスラッシュの入力
(define-key global-map [?¥] [?\\])

;; ドラッグ&ドロップした時は新しくファイルを開く
(define-key global-map [ns-drag-file] 'ns-find-file)

;; http://d.hatena.ne.jp/suztomo/20080923/1222149517
;; fullscreen
;; (when (eq window-system 'ns)
;;   (add-hook 'window-setup-hook
;;             (lambda ()
;;               ;; (set-frame-parameter nil 'fullscreen 'fullboth)
;;               (ns-toggle-fullscreen)
;;               )))
;; (global-set-key (kbd "M-<RET>") 'ns-toggle-fullscreen)

;; フォントの設定
(set-face-attribute 'default nil
                    ;; :family "monaco"
                    :family "Ricty Discord for Powerline"
                    :height 140)
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0208
 '("Ricty Discord for Powerline" . "iso10646-1"))
 ;; '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0212
 '("Ricty Discord for Powerline" . "iso10646-1"))
 ;; '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'mule-unicode-0100-24ff
 '("Ricty Discord for Powerline" . "iso10646-1"))
 ;; '("monaco" . "iso10646-1"))
(setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.2)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3)))

;; コンパイル時の文字コード
(add-hook 'compilation-filter-hook
          '(lambda ()
             ;; シェルモードの入出力文字コード
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
             (set-buffer-file-coding-system    'utf-8-unix)
             ))

