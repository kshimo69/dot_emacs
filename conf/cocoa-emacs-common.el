;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

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

;; Mac OS X の HFS+ ファイルフォーマットではファイル名は
;; NFD (の様な物)で扱う
;; 以下はファイル名を NFC で扱う環境と共同作業等する場合の対処
(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs))

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
