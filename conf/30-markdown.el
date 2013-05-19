;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://moya-notes.blogspot.jp/2013/02/emacs24-config-on-mac.html?m=1
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))
;; (setq markdown-command "/usr/local/bin/markdown")
;; Markdown2HTML した際 (C-c C-c v や C-c C-c e)、参照する CSS の設定
;; (setq markdown-css-path "file://localhost/Users/morikawa/.emacs.d/local-lisp/markdown2html_mac.css")
