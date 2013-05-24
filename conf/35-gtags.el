;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'gtags-mode "gtags" "" t)
(setq gtags-path-style 'relative)
(setq gtags-read-only t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key (kbd "M-t") 'gtags-find-tag)
         (local-set-key (kbd "M-r") 'gtags-find-rtag)
         (local-set-key (kbd "M-s") 'gtags-find-symbol)
         (local-set-key (kbd "M-g") 'gtags-find-with-grep)
         (local-set-key (kbd "C-t") 'gtags-pop-stack)
         ))

;; update GTAGS
(defun update-gtags (&optional prefix)
  (interactive "P")
  (let ((rootdir (gtags-get-rootpath))
        (args (if prefix "-v" "-iv")))
    (when rootdir
      (let* ((default-directory rootdir)
             (buffer (get-buffer-create "*update GTAGS*")))
        (save-excursion
          (set-buffer buffer)
          (erase-buffer)
          (let ((result (process-file "gtags" nil buffer nil args)))
            (if (= 0 result)
                (message "update GTAGS error with exit status %d" result))))))))
;; (add-hook 'after-save-hook 'update-gtags)

;; 自動で gtags-mode になるように＆補完リスト作成
(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))
(add-hook 'c++-mode-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))
;; gtags not support python
;; (add-hook 'python-mode-hook
;;           '(lambda()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)
;;              ))

;; /usr/includeを参照しつつ別のパスでコードを書く場合
;; $ cd /usr/include
;; $ gtags ~/.include_gtags
;; $ export GTAGSROOT=/usr/include #gtagsを実行したパスを設定
;; $ export GTAGSDBPATH=/.include_gtags #GTAGSなどのインデックスファイルが存在するパスを設定
