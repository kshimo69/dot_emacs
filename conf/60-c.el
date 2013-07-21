;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'c-eldoc nil t)
  (setq c-eldoc-cpp-command (executable-find "cpp-3"))
  (setq c-eldoc-includes " -I./ -I../ ")
  (add-hook 'c-mode-hook
            (lambda ()
              (set (make-local-variable 'eldoc-idle-delay) 0.20)
              (c-turn-on-eldoc-mode)
              ))
  (add-hook 'c++-mode-hook
            (lambda ()
              (set (make-local-variable 'eldoc-idle-delay) 0.20)
              (c-turn-on-eldoc-mode)
              ))
  )

;; (defun flymake-c-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-in-system-tempdir))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
;; (push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)

;; (add-hook 'c-mode-hook
;;           '(lambda ()
;;              (flymake-mode t)))

;; (defun flymake-cc-init ()
;;   (let* ((temp-file  (flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-in-system-tempdir))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
;; (push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

;; (add-hook 'c++-mode-hook
;;           '(lambda ()
;;              (flymake-mode t)))

;; (add-hook 'c-mode-common-hook '(lambda ()
;;           ;; ac-omni-completion-sources is made buffer local so
;;           ;; you need to add it to a mode hook to activate on
;;           ;; whatever buffer you want to use it with.  This
;;           ;; example uses C mode (as you probably surmised).
;;           ;; auto-complete.el expects ac-omni-completion-sources to be
;;           ;; a list of cons cells where each cell's car is a regex
;;           ;; that describes the syntactical bits you want AutoComplete
;;           ;; to be aware of. The cdr of each cell is the source that will
;;           ;; supply the completion data.  The following tells autocomplete
;;           ;; to begin completion when you type in a . or a ->
;;           (add-to-list 'ac-omni-completion-sources
;;                        (cons "\\." '(ac-source-semantic)))
;;           (add-to-list 'ac-omni-completion-sources
;;                        (cons "->" '(ac-source-semantic)))
;;           ;; ac-sources was also made buffer local in new versions of
;;           ;; autocomplete.  In my case, I want AutoComplete to use
;;           ;; semantic and yasnippet (order matters, if reversed snippets
;;           ;; will appear before semantic tag completions).
;;           (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
;;           ))

;; (add-hook 'c++-mode
;;           (lambda () (add-to-list
;;                       'ac-sources
;;                       'ac-source-semantic
;;                       )))

;; auto-complete-clang-async
;; http://d.hatena.ne.jp/uhiaha888/20130304/1362382317
;; $ apt-cyg -m http://ftp.iij.ad.jp/pub/cygwin/ install libllvm-devel libllvm3.1 llvm llvm-debuginfo llvm-doc clang clang-analyzer libclang libclang-devel python-clang
;; https://github.com/Golevka/emacs-clang-complete-async

;; auto-complete-clang-async-once patch
;; https://github.com/Golevka/emacs-clang-complete-async/issues/15
;; https://github.com/Golevka/emacs-clang-complete-async/commit/dcc54e9230cf2a0851232314a354c14bb1bc85c3

;; (when (require 'auto-complete-clang-async)
;;   (defun ac-cc-mode-setup ()
;;     (setq ac-clang-complete-executable "~/.emacs.d/share/clang-complete/clang-complete")
;;     (setq ac-sources (append '(ac-source-gtags
;;                                ac-source-clang-async
;;                                ) ac-sources))
;;     (ac-clang-launch-completion-process)
;;     )

;;   (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'c++-mode-hook 'ac-cc-mode-setup)
;;   )

(add-hook 'c-mode-hook
          '(lambda ()
             (setq indent-tabs-mode t)
             (setq c-basic-offset 4)
             (setq tab-width 4)
             ))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "bsd")
            (setq indent-tabs-mode t)    ;インデントはタブ
            (setq tab-width 4)           ;タブ幅は4
            (setq c-auto-newline nil)    ;全自動インデントは無効
            (c-toggle-hungry-state)      ;BSでいい感じに消してくれる
            (setq c-basic-offset 4)      ;オフセットは4つ
            ;; C-c C-sでインデントに効いてる変数を見つける
            (c-set-offset 'innamespace 0)     ;namespace{}の中はインデントしない
            (c-set-offset 'namespace-open 0)  ;namespaceの開き中括弧
            (c-set-offset 'namespace-close 0) ;namespaceの閉じ中括弧
            (c-set-offset 'defun-open 0)      ;関数定義開始の中括弧
            (c-set-offset 'defun-close 0)     ;関数定義終了の中括弧
            (c-set-offset 'defun-block-intro '+) ;関数内ブロック
            (c-set-offset 'else-clause 0)       ;if-elseのelse
            (c-set-offset 'extern-lang-open 0)  ;externの開始中括弧
            (c-set-offset 'extern-lang-close 0) ;externの終了中括弧
            (c-set-offset 'inextern-lang '+)    ;extern内の要素
            (c-set-offset 'friend 0)       ;friend宣言
            (c-set-offset 'inclass '+)     ;class定義内の要素
            (c-set-offset 'inline-open 0)  ;class内のinline methodの開き中括弧
            (c-set-offset 'inline-close 0) ;class内のinline methodの閉じ中括弧
            (c-set-offset 'label 0)        ;ラベル
            (c-set-offset 'member-init-intro '+) ;member初期化リストの1行目
            (c-set-offset 'member-init-cont '+)  ;member初期化リストの2行目以降
            (c-set-offset 'statement 0)          ;通常の文
            (c-set-offset 'statement-block-intro '+) ;新規文ブロックの1行目
            (c-set-offset 'statement-case-intro '+)  ;caseブロックの1行目
            (c-set-offset 'statement-case-open 0)    ;case文の開き中括弧
            (c-set-offset 'statement-cout '+) ;文の継続する行
            (c-set-offset 'stream-op '+)      ;<<演算子が続く行の2行目以降
            (c-set-offset 'string 0)          ;複数行に跨るliteralの内側
            (c-set-offset 'substatement '+)   ;if,while,forとかの1行目
            (c-set-offset 'substatement-open 0)  ;部分文の開き中括弧
            (c-set-offset 'topmost-intro 0)      ;最上位の言語構成要素の1行目
            (c-set-offset 'topmost-intro-cout 0) ;最上位の言語構成要素の2行目以降
            ))

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  ;; grr - still does not seem to work properly
  (make-variable-buffer-local 'tab-width)
  (make-variable-buffer-local 'indent-tabs-mode)
  (make-variable-buffer-local 'c-basic-offset)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))
(setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
                            auto-mode-alist))
(push '(".*/linux.*/.*\\.[ch]\\'" . linux-c-mode) auto-mode-alist)
(push '(".*/linux.*/.*\\.[ch]\\(-[a-z]+\\)?\\'" . linux-c-mode) auto-mode-alist)

;; ------------------------------------------------------------------------
;; @ compile
(setq compile-command "make -j8 ")

(require 'ansi-color)
(add-hook 'compilation-filter-hook
          '(lambda ()
             (ansi-color-apply-on-region (point-min) (point-max))))

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

;; ソースを開いていた場合はヘッダ、ヘッダを開いていた場合はソースを開く
(defun find-current-buffer-pair-file()
  (interactive)
  (if (or (string= (substring (buffer-file-name) -4 nil) ".cpp")
          (string= (substring (buffer-file-name) -2 nil) ".c") )
      (progn
        (setq openfile (buffer-file-name))
        (setq openfile (replace-regexp-in-string "src/\\(\\w+\\)\\.cpp$" "include/\\1.h" openfile))
        (setq openfile (replace-regexp-in-string "/\\(\\w+\\)\\.cpp$" "/\\1.h" openfile))
        (setq openfile (replace-regexp-in-string "src/\\(\\w+\\)\\.c$" "include/\\1.h" openfile))
        (setq openfile (replace-regexp-in-string "/\\(\\w+\\)\\.c$" "/\\1.h" openfile))
        (find-file openfile)
        )
    (progn
      (if (string= (substring (buffer-file-name) -2 nil) ".h")
          (progn
            (setq openfile (buffer-file-name))
            (setq openfile (replace-regexp-in-string "include/\\(\\w+\\)\\.h$" "src/\\1.cpp" openfile))
            (setq openfile (replace-regexp-in-string "/\\(\\w+\\)\\.h$" "/\\1.cpp" openfile))
            (setq openfile (replace-regexp-in-string "include/\\(\\w+\\)\\.h$" "src/\\1.c" openfile))
            (setq openfile (replace-regexp-in-string "/\\(\\w+\\)\\.h$" "/\\1.c" openfile))
            (find-file openfile)
            )
        )
      )
    )
  )

;; (global-set-key (kbd "C-c C") 'compile-directory)
;; (global-set-key (kbd "C-c c") 'compile)
(defun my-c++-mode-hook ()
  (define-key c++-mode-map (kbd "C-c C-c") 'recompile)
  (define-key c++-mode-map (kbd "C-c C") 'compile-directory)
  (define-key c++-mode-map (kbd "C-c c") 'compile)
  (define-key c++-mode-map (kbd "C-M-f") 'find-current-buffer-pair-file)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(defun my-c-mode-hook ()
  (define-key c-mode-map (kbd "C-c C-c") 'recompile)
  (define-key c-mode-map (kbd "C-c C") 'compile-directory)
  (define-key c-mode-map (kbd "C-c c") 'compile)
  (define-key c-mode-map (kbd "C-M-f") 'find-current-buffer-pair-file)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-hook)
