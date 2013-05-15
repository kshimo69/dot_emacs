;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; githubにあるemacs24対応版を使用する
;; (auto-install-from-url "https://raw.github.com/emacs-jp/migemo/master/migemo.el")

(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)

  ;; for cmigemo
  (setq migemo-command "cmigemo")
  ;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary (expand-file-name "~/.emacs.d/share/migemo/utf-8/migemo-dict"))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)

  (load-library "migemo")
  (migemo-init)
  )
