;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'org-install nil t)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(setq org-agenda-start-with-clockreport-mode t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c r") 'org-remember)
(global-set-key (kbd "C-c c") 'org-capture)
(add-hook 'org-mode-hook '(lambda ()
                            (define-key org-mode-map (kbd "C-c C-p")
                              'outline-previous-visible-heading)
                            (define-key org-mode-map (kbd "C-c C-n")
                              'outline-next-visible-heading)
                            ))
(setq org-directory "~/org/")
(setq org-agenda-files (list "~/org/agenda.org"
                             "~/org/code-reading.org"
                             "~/org/mobileorg.org"
                             ))
;; (setq org-agenda-files (list org-directory))
(setq org-default-notes-file (concat org-directory "agenda.org"))
;; (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
;; (setq hl-line-face 'underline)

;; http://unknownplace.org/archives/orgmode-meets-blosxom.html
;; バッファ内のコードブロッックをそのコード用のモードと同じ色でハイライト
(setq org-src-fontify-natively t)
;; カーソルをコードに合わせて C-c ' するとそのモードで編集バッファが立ちあがる

;; TODO keywords as workflow state
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "CALENDAR(c)"
                  "SOMEDAY(s)" "REFERENCE(r)" "PROJECT(p)"
                  "|" "DONE(d!)")
        (sequence "NEW(n)" "ASSIGNED(a!)" "|" "FIXED(f!)")
        ))
;; record DONE time
(setq org-log-done 'time)
;; repeat task
(require 'org-habit nil t)

;; show TODOs
(setq org-agenda-custom-commands
      '(("x" "Unscheduled TODO" tags-todo "-SCHEDULED=>\"<now>\"" nil)))

;; http://d.hatena.ne.jp/rubikitch/20100819/org
(setq org-capture-templates
      '(("n" "Note" entry
         (file+headline nil "Note")
         "** %?\n   Added: %T\n   %i\n")
        ("t" "Todo" entry
         (file+headline nil "Tasks")
         "** TODO %?\n   Added: %T\n   %a\n   %i\n")
        ;; ("b" "Bug" entry
        ;;  (file+headline nil "Inbox")
        ;;  "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("b" "Bug" entry
         (file+headline nil "Tasks")
         "** NEW %?   :bug:\n   Added: %T\n   %a\n   %i\n")
        ;; ("i" "Idea" entry
        ;;  (file+headline nil "New Ideas")
        ;;  "** %?\n   %i\n   %a\n   %t")
        ("i" "Idea" entry
         (file+headline nil "New Ideas")
         "** SOMEDAY %?\n   Added: %T\n   %i\n")
        ("d" "Daily review" entry
         (file+headline nil "Tasks")
         "** TODO Daily Review[/] :review:\n%?   DEADLINE: %t\n%[~/org/daily_review.txt]")
        ("w" "Weekly review" entry
         (file+headline nil "Tasks")
         "** TODO Weekly Review %T[/] :review:\n%?%[~/org/weekly_review.txt]")
        ))

;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
;; http://d.hatena.ne.jp/tomoya/20090309/1236588957
(org-remember-insinuate)
(setq org-remember-templates
      '(("Note" ?n "** %^{Brief Description} %^g\n%?\n%i\nAdded: %T" nil "Note")
        ("Bug" ?b "** NEW %^{Brief Description} :bug%^g\n%?\n%i\n%a\nAdded: %T" nil "Tasks")
        ("Idea" ?i "** SOMEDAY %^{Brief Description} %^g\n%?\n%i\nAdded: %T" nil "New Ideas")
        ;; ("Todo" ?t "** %?\n   %i\n   %a\n   %T" nil "Tasks")
        ("Todo" ?t "** TODO %^{Brief Description} %^g\n%?\n%i\nAdded: %T" nil "Tasks")
        ("Daily review" ?d "** TODO Daily Review[/] :review:\n%?   DEADLINE: %t\n%[~/org/daily_review.txt]\n" nil "Tasks")
        ("Weekly review" ?w "** TODO Weekly Review %T[/] :review:\n%?%[~/org/weekly_review.txt]\n" nil "Tasks")
        ))

(defvar org-code-reading-software-name nil)
;; ~/memo/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: "
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%^{Brief Description}\n   %?\n   %a\n   %T"
             ,org-code-reading-file "Memo"))))
    (org-remember)))
(global-set-key (kbd "C-x m") 'org-remember-code-reading)


;; (defun org-next-visible-link ()
;;   "Move forward to the next link.
;; If the link is in hidden text, expose it."
;;   (interactive)
;;   (when (and org-link-search-failed (eq this-command last-command))
;;     (goto-char (point-min))
;;     (message "Link search wrapped back to beginning of buffer"))
;;   (setq org-link-search-failed nil)
;;   (let* ((pos (point))
;;          (ct (org-context))
;;          (a (assoc :link ct))
;;          srch)
;;     (if a (goto-char (nth 2 a)))
;;     (while (and (setq srch (re-search-forward org-any-link-re nil t))
;;                 (goto-char (match-beginning 0))
;;                 (prog1 (not (eq (org-invisible-p) 'org-link))
;;                   (goto-char (match-end 0)))))
;;     (if srch
;;         (goto-char (match-beginning 0))
;;       (goto-char pos)
;;       (setq org-link-search-failed t)
;;       (error "No further link found"))))

;; (defun org-previous-visible-link ()
;;   "Move backward to the previous link.
;; If the link is in hidden text, expose it."
;;   (interactive)
;;   (when (and org-link-search-failed (eq this-command last-command))
;;     (goto-char (point-max))
;;     (message "Link search wrapped back to end of buffer"))
;;   (setq org-link-search-failed nil)
;;   (let* ((pos (point))
;;          (ct (org-context))
;;          (a (assoc :link ct))
;;          srch)
;;     (if a (goto-char (nth 1 a)))
;;     (while (and (setq srch (re-search-backward org-any-link-re nil t))
;;                 (goto-char (match-beginning 0))
;;                 (not (eq (org-invisible-p) 'org-link))))
;;     (if srch
;;         (goto-char (match-beginning 0))
;;       (goto-char pos)
;;       (setq org-link-search-failed t)
;;       (error "No further link found"))))
;; (define-key org-mode-map (kbd "M-n") 'org-next-visible-link)
;; (define-key org-mode-map (kbd "M-p") 'org-previous-visible-link)
