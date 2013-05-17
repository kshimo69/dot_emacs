;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

(setq revive:configuration-file (expand-file-name "~/.emacs.d/var/revive"))

;; C-x Sで保存 C-x Fで復元 C-x KでKill
(global-set-key (kbd "C-x S") 'save-current-configuration)
(global-set-key (kbd "C-x F") 'resume)
(global-set-key (kbd "C-x K") 'wipe)

;; 終了時に保存
(add-hook 'kill-emacs-hook 'save-current-configuration)
