;; load directories
(add-to-list 'load-path "~/.emacs.d/iedit")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/tern/emacs")

;; setting up package archives
(require 'package)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; load libraries
(require 'auto-complete-config)
(require 'whitespace)

;; load resources
(load "iedit")
(load "iedit-lib")
(load "iedit-rect")

;; get auto-completion
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(autoload 'js2-mode "js2-mode" nil t)
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))

;; have backup files created in a specific directory
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacs_backups"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

;; tide mode
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;; ui changes
(line-number-mode 0)
(column-number-mode 1)
(global-linum-mode 1)
(x-focus-frame nil)

;; terminal coloring
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Style settings
(global-whitespace-mode 1)
(setq whitespace-line-column 100)
(setq whitespace-style '(face tabs trailing lines-tail))
(setq-default indent-tabs-mode nil)
(setq-default fill-column 100)
(setq require-final-newline t)

(defun delete-trailing-newlines ()
  "Deletes new lines at the end of the file, even the last one"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines))))

(defun indent-bufferk ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)
    ))

;; Insert a copyright header
(defun insert-header-hook ()
  (interactive)
  (save-excursion
    (save-restriction
      (goto-char (point-min))
      (if (and (string= "java" (file-name-extension (buffer-file-name)))
               (= 0 (count-matches "\\* Copyright (c) [0-9-]+")))
          (insert (amazon-copyright-statement))))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'delete-trailing-newlines)

;; have files open in appropriate major modes.
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; enable disabled commands
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; shortcuts
(global-set-key (kbd "M-g h") 'compile)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-x M-s") 'desktop-save)
(global-set-key (kbd "C-M-d") 'kill-whole-line)
(global-set-key (kbd "C-x 9")
                (lambda () (interactive)
                  (delete-other-windows)
                  (split-window-right)
                  (split-window-right)
                  (balance-windows)
                  ))

(setq inferior-lisp-program "/usr/bin/clisp")

;; syntax highlighting maximal
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; y or n always suffices
(fset 'yes-or-no-p 'y-or-n-p)

;; paste across programs
(setq x-select-enable-clipboard t)
(setq intrprogram-past-function 'x-cut-buffer)
(put 'set-goal-column 'disabled nil)

;; notify on bad style
(global-whitespace-mode 1)
(setq whitespace-style '(face tabs trailing lines-tail))
(setq-default indent-tabs-mode nil)

(setq org-startup-intended t)

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
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2 t)
 '(js2-bounce-indent-p t)
 '(js2-highlight-level 3)
 '(typescript-expr-indent-offset 0)
 '(typescript-indent-level 2))



(tool-bar-mode -1)
(scroll-bar-mode -1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default
    ((t (:inherit nil
         :stipple nil
         :background "black"
         :foreground "white"
         :inverse-video nil
         :box nil
         :strike-through nil
         :overline nil
         :underline nil
         :slant normal
         :weight normal
         :height 140
         :width normal
         :foundry "nil"
         :family "Inconsolata")))))
(setq default-frame-alist
      (append
       '((background-color . "black")
         (foreground-color . "white")
         (face-color   . "black" )
         (cursor-color . "white")
         (left-fringe  . 0)
         (right-fringe . 0)
         (face-background-color . "FFEEEEEE")
         ) default-frame-alist))
