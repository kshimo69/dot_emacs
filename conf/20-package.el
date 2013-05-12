;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; パッケージ管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; 自動インストールの設定
;; (require 'cl)

;; (defvar installing-package-list
;;   '(
;;     ;; ここに使っているパッケージを書く。
;;     markdown-mode
;;     google-c-style
;;     yaml-mode
;;
;;     auto-install
;;     goto-last-change
;;     migemo
;;     open-junk-file
;;     point-undo
;;     recentf-ext
;;     ))

;; (let ((not-installed (loop for x in installing-package-list
;; 			   when (not (package-installed-p x))
;; 			   collect x)))
;;   (when not-installed
;;     (package-refresh-contents)
;;     (dolist (pkg not-installed)
;;       (package-install pkg))))
