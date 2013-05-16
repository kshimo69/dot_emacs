;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ coding system

;; 日本語入力のための設定
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
;; (setq default-buffer-file-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
;; コマンドプロンプトを使うならsjis
(setq file-name-coding-system 'shift_jis)
(setq locale-coding-system 'shift_jis)  ;; term内の文字コード
;; (setq file-name-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)

;; (set-keyboard-coding-system 'cp932)
;; (prefer-coding-system 'utf-8-dos)
;; (set-file-name-coding-system 'cp932)
;; (setq default-process-coding-system '(cp932 . cp932))

;; ------------------------------------------------------------------------
;; @ ime

;; 標準IMEの設定
(setq default-input-method "W32-IME")

;; IME状態のモードライン表示
(setq-default w32-ime-mode-line-state-indicator "[Aa]")
(setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))

;; IMEの初期化
(w32-ime-initialize)

;; IME OFF時の初期カーソルカラー
;; (set-cursor-color "red")

;; IME ON/OFF時のカーソルカラー
;; (add-hook 'input-method-activate-hook
;;           (lambda() (set-cursor-color "green")))
;; (add-hook 'input-method-inactivate-hook
;;           (lambda() (set-cursor-color "red")))

;; バッファ切り替え時にIME状態を引き継ぐ
(setq w32-ime-buffer-switch-p nil)

;; ------------------------------------------------------------------------
;; @ encode

;; 機種依存文字
;; (require 'cp5022x)
;; (define-coding-system-alias 'euc-jp 'cp51932)

;; decode-translation-table の設定
(coding-system-put 'euc-jp :decode-translation-table
                   (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'iso-2022-jp :decode-translation-table
                   (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'utf-8 :decode-translation-table
                   (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

;; encode-translation-table の設定
(coding-system-put 'euc-jp :encode-translation-table
                   (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'iso-2022-jp :encode-translation-table
                   (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'cp932 :encode-translation-table
                   (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'utf-8 :encode-translation-table
                   (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

;; charset と coding-system の優先度設定
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;; PuTTY 用の terminal-coding-system の設定
(apply 'define-coding-system 'utf-8-for-putty
       "UTF-8 (translate jis to cp932)"
       :encode-translation-table
       (get 'japanese-ucs-jis-to-cp932-map 'translation-table)
       (coding-system-plist 'utf-8))
(set-terminal-coding-system 'utf-8-for-putty)

;; East Asian Ambiguous
(defun set-east-asian-ambiguous-width (width)
  (while (char-table-parent char-width-table)
    (setq char-width-table (char-table-parent char-width-table)))
  (let ((table (make-char-table nil)))
    (dolist (range
             '(#x00A1 #x00A4 (#x00A7 . #x00A8) #x00AA (#x00AD . #x00AE)
                      (#x00B0 . #x00B4) (#x00B6 . #x00BA) (#x00BC . #x00BF)
                      #x00C6 #x00D0 (#x00D7 . #x00D8) (#x00DE . #x00E1) #x00E6
                      (#x00E8 . #x00EA) (#x00EC . #x00ED) #x00F0
                      (#x00F2 . #x00F3) (#x00F7 . #x00FA) #x00FC #x00FE
                      #x0101 #x0111 #x0113 #x011B (#x0126 . #x0127) #x012B
                      (#x0131 . #x0133) #x0138 (#x013F . #x0142) #x0144
                      (#x0148 . #x014B) #x014D (#x0152 . #x0153)
                      (#x0166 . #x0167) #x016B #x01CE #x01D0 #x01D2 #x01D4
                      #x01D6 #x01D8 #x01DA #x01DC #x0251 #x0261 #x02C4 #x02C7
                      (#x02C9 . #x02CB) #x02CD #x02D0 (#x02D8 . #x02DB) #x02DD
                      #x02DF (#x0300 . #x036F) (#x0391 . #x03A9)
                      (#x03B1 . #x03C1) (#x03C3 . #x03C9) #x0401
                      (#x0410 . #x044F) #x0451 #x2010 (#x2013 . #x2016)
                      (#x2018 . #x2019) (#x201C . #x201D) (#x2020 . #x2022)
                      (#x2024 . #x2027) #x2030 (#x2032 . #x2033) #x2035 #x203B
                      #x203E #x2074 #x207F (#x2081 . #x2084) #x20AC #x2103
                      #x2105 #x2109 #x2113 #x2116 (#x2121 . #x2122) #x2126
                      #x212B (#x2153 . #x2154) (#x215B . #x215E)
                      (#x2160 . #x216B) (#x2170 . #x2179) (#x2190 . #x2199)
                      (#x21B8 . #x21B9) #x21D2 #x21D4 #x21E7 #x2200
                      (#x2202 . #x2203) (#x2207 . #x2208) #x220B #x220F #x2211
                      #x2215 #x221A (#x221D . #x2220) #x2223 #x2225
                      (#x2227 . #x222C) #x222E (#x2234 . #x2237)
                      (#x223C . #x223D) #x2248 #x224C #x2252 (#x2260 . #x2261)
                      (#x2264 . #x2267) (#x226A . #x226B) (#x226E . #x226F)
                      (#x2282 . #x2283) (#x2286 . #x2287) #x2295 #x2299 #x22A5
                      #x22BF #x2312 (#x2460 . #x24E9) (#x24EB . #x254B)
                      (#x2550 . #x2573) (#x2580 . #x258F) (#x2592 . #x2595)
                      (#x25A0 . #x25A1) (#x25A3 . #x25A9) (#x25B2 . #x25B3)
                      (#x25B6 . #x25B7) (#x25BC . #x25BD) (#x25C0 . #x25C1)
                      (#x25C6 . #x25C8) #x25CB (#x25CE . #x25D1)
                      (#x25E2 . #x25E5) #x25EF (#x2605 . #x2606) #x2609
                      (#x260E . #x260F) (#x2614 . #x2615) #x261C #x261E #x2640
                      #x2642 (#x2660 . #x2661) (#x2663 . #x2665)
                      (#x2667 . #x266A) (#x266C . #x266D) #x266F #x273D
                      (#x2776 . #x277F) (#xE000 . #xF8FF) (#xFE00 . #xFE0F)
                      #xFFFD
                      ))
      (set-char-table-range table range width))
    (optimize-char-table table)
    (set-char-table-parent table char-width-table)
    (setq char-width-table table)))
(set-east-asian-ambiguous-width 2)

;; emacs-w3m
(eval-after-load "w3m"
  '(when (coding-system-p 'cp51932)
     (add-to-list 'w3m-compatible-encoding-alist '(euc-jp . cp51932))))

;; Gnus
(eval-after-load "mm-util"
  '(when (coding-system-p 'cp50220)
     (add-to-list 'mm-charset-override-alist '(iso-2022-jp . cp50220))))

;; SEMI (cf. http://d.hatena.ne.jp/kiwanami/20091103/1257243524)
(eval-after-load "mcs-20"
  '(when (coding-system-p 'cp50220)
     (add-to-list 'mime-charset-coding-system-alist
                  '(iso-2022-jp . cp50220))))

;; 全角チルダ/波ダッシュをWindowsスタイルにする
(let ((table (make-translation-table-from-alist '((#x301c . #xff5e))) ))
  (mapc
   (lambda (coding-system)
     (coding-system-put coding-system :decode-translation-table table)
     (coding-system-put coding-system :encode-translation-table table)
     )
   '(utf-8 cp932 utf-16le)))

;; ------------------------------------------------------------------------
;; @ font

;; (set-face-font 'default "Ricty Diminished for Powerline-12")
(set-face-font 'default "Migu 1M-10")

;; ------------------------------------------------------------------------
;; @ frame

;; cp932エンコード時の表示を「P」とする
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;; 透明
(set-frame-parameter (selected-frame) 'alpha '(95 80))

;; ------------------------------------------------------------------------
;; @ image-library
;; (setq image-library-alist
;;       '((xpm "libxpm.dll")
;;         (png "libpng14.dll")
;;         (jpeg "libjpeg.dll")
;;         (tiff "libtiff3.dll")
;;         (gif "libungif4.dll")
;;         (svg "librsvg-2-2.dll")
;;         (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
;;         (glib "libglib-2.0-0.dll")
;;         (gobject "libgobject-2.0-0.dll"))
;;       )

;; ------------------------------------------------------------------------
;; @ print

(setq ps-print-color-p t
      ps-lpr-command "gswin32c.exe"
      ps-multibyte-buffer 'non-latin-printer
      ps-lpr-switches '("-sDEVICE=mswinpr2" "-dNOPAUSE" "-dBATCH" "-dWINKANJI")
      printer-name nil
      ps-printer-name nil
      ps-printer-name-option nil
      ps-print-header nil          ; ヘッダの非表示
      )

;; ------------------------------------------------------------------------
;; @ tabbar

;; (require 'tabbar)

;; ;; tabbar有効化
;; (tabbar-mode)

;; ;; タブ切替にマウスホイールを使用（0：有効，-1：無効）
;; (tabbar-mwheel-mode -1)

;; ;; タブグループを使用（t：有効，nil：無効）
;; (setq tabbar-buffer-groups-function nil)

;; ;; ボタン非表示
;; (dolist (btn '(tabbar-buffer-home-button
;;                tabbar-scroll-left-button
;;                tabbar-scroll-right-button))
;;   (set btn (cons (cons "" nil) (cons "" nil))))

;; ;; タブ表示 一時バッファ一覧
;; (defvar tabbar-displayed-buffers
;;   '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*"
;;     "*Faces*" "*Apropos*" "*Customize*" "*shell*" "*Help*")
;;   "*Regexps matches buffer names always included tabs.")

;; ;; 作業バッファの一部を非表示
;; (setq tabbar-buffer-list-function
;;       (lambda ()
;;         (let* ((hides (list ?\  ?\*))
;;                (re (regexp-opt tabbar-displayed-buffers))
;;                (cur-buf (current-buffer))
;;                (tabs (delq
;;                       nil
;;                       (mapcar
;;                        (lambda (buf)
;;                          (let ((name (buffer-name buf)))
;;                            (when (or (string-match re name)
;;                                      (not (memq (aref name 0) hides)))
;;                              buf)))
;;                        (buffer-list)))))
;;           (if (memq cur-buf tabs)
;;               tabs
;;             (cons cur-buf tabs)))))

;; ;; キーバインド設定
;; (global-set-key (kbd "<C-tab>")   'tabbar-forward-tab)
;; (global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)

;; ;; タブ表示欄の見た目（フェイス）
;; (set-face-attribute 'tabbar-default nil
;;                     :background "SystemMenuBar")

;; ;; 選択タブの見た目（フェイス）
;; (set-face-attribute 'tabbar-selected nil
;;                     :foreground "red3"
;;                     :background "SystemMenuBar"
;;                     :box (list
;;                           :line-width 1
;;                           :color "gray80"
;;                           :style 'released-button)
;;                     :overline "#F3F2EF"
;;                     :weight 'bold
;;                     :family "ＭＳ Ｐゴシック"
;;                     )

;; ;; 非選択タブの見た目（フェイス）
;; (set-face-attribute 'tabbar-unselected nil
;;                     :foreground "black"
;;                     :background "SystemMenuBar"
;;                     :box (list
;;                           :line-width 1
;;                           :color "gray80"
;;                           :style 'released-button)
;;                     :overline "#F3F2EF"
;;                     :family "ＭＳ Ｐゴシック"
;;                     )

;; ;; タブ間隔の調整
;; (set-face-attribute 'tabbar-separator nil
;;                     :height 0.1)

;; ------------------------------------------------------------------------
;; @ setup-cygwin
;; (setq cygwin-mount-cygwin-bin-directory
;;       (concat (getenv "CYGWIN_DIR") "\\bin"))
;; (require 'setup-cygwin)
;; (file-name-shadow-mode -1)

;; ------------------------------------------------------------------------
;; @ shell
(require 'shell)
(setq explicit-shell-file-name "bash.exe")
(setq shell-command-switch "-c")
(setq shell-file-name "bash.exe")

;; (M-! and M-| and compile.el)
(setq shell-file-name "bash.exe")
(modify-coding-system-alist 'process ".*sh\\.exe" 'cp932)

;; shellモードの時の^M抑制
(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;; shell-modeでの補完 (for drive letter)
(setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")

;; エスケープシーケンス処理の設定
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)

(setq shell-mode-hook
      (function
       (lambda ()

         ;; シェルモードの入出力文字コード
         ;; (set-buffer-process-coding-system 'sjis-dos 'sjis-unix)
         ;; (set-buffer-file-coding-system    'sjis-unix)
         (set-buffer-process-coding-system 'utf-8-dos 'utf-8-unix)
         (set-buffer-file-coding-system    'utf-8-unix)
         )))

;; ------------------------------------------------------------------------
;; @ compile
(setq compile-command "make -j8 ")

;; (require 'ansi-color)
(add-hook 'compilation-filter-hook
          '(lambda ()
             (ansi-color-apply-on-region (point-min) (point-max))))

;; コンパイル時の文字コード
(add-hook 'compilation-filter-hook
          '(lambda ()
             ;; シェルモードの入出力文字コード
             ;; (set-buffer-process-coding-system 'sjis-dos 'sjis-unix)
             ;; (set-buffer-file-coding-system    'sjis-unix)
             (set-buffer-process-coding-system 'utf-8-dos 'utf-8-unix)
             (set-buffer-file-coding-system    'utf-8-unix)
             ))

;; ディレクトリを指定してコンパイル
(defun compile-directory (filename command &optional comint)
  (interactive
   (list
    (read-file-name "Directory: " nil default-directory)
    (let ((command (eval compile-command)))
      (if (or compilation-read-command current-prefix-arg)
          (compilation-read-command command)
        command))
    (consp current-prefix-arg)))
  (unless (equal command (eval compile-command))
    (setq compile-command command))
  (save-some-buffers (not compilation-ask-about-save) nil)
  (setq-default compilation-directory filename)
  (setq default-directory filename)
  (compilation-start command comint))

(global-set-key (kbd "C-c C") 'compile-directory)
(global-set-key (kbd "C-c c") 'compile)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(defun my-c++-mode-hook ()
  (define-key c++-mode-map (kbd "C-c C-c") 'recompile))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)
(defun my-c-mode-hook ()
  (define-key c-mode-map (kbd "C-c C-c") 'recompile))

;; ------------------------------------------------------------------------
;; @ menu-tree
;; (setq menu-tree-coding-system 'utf-8)
;; (require 'menu-tree)

;; ------------------------------------------------------------------------
;; @ w32-symlinks

;; (custom-set-variables '(w32-symlinks-handle-shortcuts t))
;; (require 'w32-symlinks)

;; (defadvice insert-file-contents-literally
;;   (before insert-file-contents-literally-before activate)
;;   (set-buffer-multibyte nil))

;; (defadvice minibuffer-complete (before expand-symlinks activate)
;;   (let ((file (expand-file-name
;;                (buffer-substring-no-properties
;;                 (line-beginning-position) (line-end-position)))))
;;     (when (file-symlink-p file)
;;       (delete-region (line-beginning-position) (line-end-position))
;;       (insert (w32-symlinks-parse-symlink file)))))
