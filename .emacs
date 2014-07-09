;; load directories
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")

;; load libraries
(require 'auto-complete-config)
(require 'android-mode)
(require 'whitespace)

;; load resources
(load "jde")
(load "iedit")
(load "iedit-lib")
(load "iedit-rect")

;; get auto-completion
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'jde-mode) ; new major mode needs ac as well

;; have backup files created in a specific directory
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacs_backups"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

;; ui changes
(line-number-mode 0)
(column-number-mode 1)
(global-linum-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq default-frame-alist
      (append
       '((background-color . "black")
         (foreground-color . "white")
         (face-color   . "black" )
         (cursor-color . "white")
         (left-fringe  . 0)
         (right-fringe . 0)
         (face-background-color . "#FFFFEEEE")
         ) default-frame-alist))
; terminal coloring
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; open all .tex files in latex-mode
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; enable disabled commands
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; shortcuts
(global-set-key (kbd "M-g h") 'compile)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-x M-s") 'desktop-save)

(setq inferior-lisp-program "/usr/bin/clisp")

;; syntax highlighting maximal
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(custom-set-faces)

;; y or n always suffices
(fset 'yes-or-no-p 'y-or-n-p)

;; paste across programs
(setq x-select-enable-clipboard t)
(setq intrprogram-past-function 'x-cut-buffer)
(put 'set-goal-column 'disabled nil)

;; android mode settings
(setq android-mode-sdk-dir
      "/etc/android-sdks/android-sdk-linux/platforms/android-17/android.jar")
(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list 'gud-jdb-classpath
                         "/etc/android-sdks/android-sdk-linux/platforms/android-17/android.jar")
            ))

;; notify on bad style
(global-whitespace-mode 1)
(setq whitespace-style '(face tabs trailing lines-tail))
(setq-default indent-tabs-mode nil)

(put 'upcase-region 'disabled nil)

; Web browsing
(setq browse-url-browser-function 'w3-browse-url)
 (autoload 'w3-browse-url "w3" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

