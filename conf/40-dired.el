;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 今日変更したファイルを色付け
;; http://masutaka.net/chalow/2011-12-17-1.html
(defface dired-todays-face '((t (:foreground "green"))) nil)
(defvar dired-todays-face 'dired-todays-face)
(defconst month-name-alist
  '(("1"  . "Jan") ("2"  . "Feb") ("3"  . "Mar") ("4"  . "Apr")
    ("5"  . "May") ("6"  . "Jun") ("7"  . "Jul") ("8"  . "Aug")
    ("9"  . "Sep") ("10" . "Oct") ("11" . "Nov") ("12" . "Dec")))
(defun dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (let ((month-name
          (cdr (assoc (format-time-string "%b") month-name-alist))))
     (if month-name
         (format
          (format-time-string
           "\\(%Y-%m-%d\\|%b %e\\|%%s %e\\) [0-9]....") month-name)
       (format-time-string
        "\\(%Y-%m-%d\\|%b %e\\) [0-9]....")))
   arg t))
(eval-after-load "dired"
  '(font-lock-add-keywords
    'dired-mode
    (list '(dired-today-search . dired-todays-face))))

;; C-x j で dired-jump
(global-set-key (kbd "C-x j") 'dired-jump)
