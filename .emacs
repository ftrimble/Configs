;; load directories
(add-to-list 'load-path "~/.emacs.d/edit-server")
(add-to-list 'load-path "~/.emacs.d/iedit")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/tern/emacs")

;; setting up package archives
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; load libraries
(require 'auto-complete-config)
(require 'whitespace)
(require 'edit-server)

;; edit-server
(edit-server-start)
(autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
(autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
(add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

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

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-tsserver-process-environment '("MAX_OLD_SPACE_SIZE=16000"))
(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tsserver.log"))



;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions nil :placeOpenBraceOnNewLineForFunctions nil))
(setq tide-sync-request-timeout 1)

;; if you use typescript-mode
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)))

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; ui changes
(line-number-mode 0)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(x-focus-frame nil)

;; terminal coloring
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Style settings
(global-whitespace-mode 1)
(setq whitespace-line-column 120)
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
      (if (and (string= "ts" (file-name-extension (buffer-file-name)))
               (= 0 (count-matches "\\* Copyright (c) [0-9-]+")))
          (insert "/**
 * Copyright (c) 2021 - Present. Blend Labs, Inc. All rights reserved
 * Blend Confidential - Restricted
 */
")))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'delete-trailing-newlines)
(add-hook 'before-save-hook 'insert-header-hook)

;; have files open in appropriate major modes.
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; golang stuff
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))

(setenv "GOPATH" "/home/forest/workspace/gopath")
(add-to-list 'exec-path "/home/forest/workspace/gopath/bin")

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

;; fixing lint automatically in javascript
(defun eslint-fix-file ()
  (interactive)
  (when (eq major-mode 'js2-mode)
    (message "eslint --fixing the file" (buffer-file-name))
    (shell-command (concat "eslintAutoFix.sh " (buffer-file-name)))
    )
  )

(defun eslint-fix-file-and-revert ()
  (interactive)
  (eslint-fix-file)
  (revert-buffer t t))

(add-hook 'after-save-hook #'eslint-fix-file-and-revert)

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
(global-set-key "\C-z" 'query-replace-regexp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2 t)
 '(js2-bounce-indent-p t)
 '(js2-highlight-level 3)
 '(line-number-mode nil)
 '(package-selected-packages
   '(typescript-mode go-autocomplete exec-path-from-shell go-mode tide js2-mode iedit edit-server company auto-complete))
 '(tool-bar-mode nil)
 '(typescript-expr-indent-offset 0)
 '(typescript-indent-level 2))

(setenv "PATH" (concat (getenv "PATH") ":/Users/forest/bin:/Users/forest/.nvm/versions/node/v18.14.2/bin"))
(setq exec-path (append exec-path '("/home/forest/.nvm/versions/node/v18.14.2/bin")))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "nil" :family "Monaco")))))
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
