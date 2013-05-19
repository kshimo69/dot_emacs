;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; http://philjackson.github.com/magit/
(when (require 'magit nil t)
  (global-set-key (kbd "C-c s") 'magit-status)
  )
;; http://github.com/bogolisk/egg
;; (require 'egg)
;; http://github.com/defunkt/gist.el
;; (auto-install-from-url "http://github.com/defunkt/gist.el/raw/master/gist.el")
(when (require 'gist nil t)
  (setq gist-view-gist t)
  )
