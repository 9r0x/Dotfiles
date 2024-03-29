;; Startup
; Increase the garbage collection threshold to ease startup
(setq gc-cons-threshold (* 200 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 20 1024 1024))))

;; GUI
; Disable unwanted GUI
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (tooltip-mode 0)
  (menu-bar-mode 0)
  (setq frame-title-format nil)
  (setq initial-frame-alist '((tool-bar-lines . 0) (width . 80) (height . 30))))
(setq-default mode-line-format nil
	      cursor-type 'hbar)
(blink-cursor-mode -1)

; Startup message
(setq inhibit-startup-message t
      initial-scratch-message ""
      inhibit-splash-screen t
      user-full-name "Shukai Ni"
      window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)

(defun display-startup-echo-area-message ()
  (message "Oh dear! Oh dear! I shall be too late!"))

(lab-themes-load-style 'light)
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . light))
(ac-config-default)
(ac-flyspell-workaround)
(add-hook 'after-init-hook 'global-display-line-numbers-mode)
(add-hook 'after-init-hook 'show-paren-mode)
(add-hook 'after-init-hook 'savehist-mode)
(add-hook 'after-init-hook 'global-flycheck-mode)

; Font
(add-to-list 'default-frame-alist
             '(font . "Fira Code-12"))
(load "~/.emacs.d/lisp/fira-code-mode")
(let (
      ($replacePairs
       [
        ["，" ","]
        ["。" "."]
        ["；" ";"]
        ["：" ":"]
        ["【" "["]
        ["】" "]"]
        ["（" "("]
        ["）" ")"]
        ["！" "!"]
        ["、" "\\"]
        ["／" "/"]
        ["《" "<"]
        ["》" ">"]
        ["‘" "'"]
        ["’" "'"]
        ["“" "\""]
        ["”" "\""]
        ]
       ))
  (mapcar (lambda(x) (define-key key-translation-map
                       (kbd (elt x 0)) (kbd (elt x 1)))) $replacePairs))


;; Behavior
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq ns-right-option-modifier 'option)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5
      )
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Package-related config
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'flyspell-correct-word)))


;; Add divider when window no. > 1
(add-hook 'window-state-change-hook
	  (lambda () (if (= (count-windows) 1)
			 (window-divider-mode 0)
		       (window-divider-mode))))

;; View byte array file as od dump
(load "~/.emacs.d/lisp/view-byte-array")