;;; early-init.el --- early bird  -*- no-byte-compile: t -*-

;;big daddy setup, makes sure use-package is installed/used
;;makes emacs highly moveable between machines
(require 'package)

;;;; Code:
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(eval-when-compile
  (add-to-list 'load-path (concat user-emacs-directory "lisp/use-package"))
  (require 'use-package))

;;quick use-package doc
;; :init -> exprs pre package load
;; :config -> exprs post package load
;; :mode -> regex of files to load a mode for
;; :hook -> (a-mode . b-mode) expands to add-hook
;; :custom-face -> expands to set face attribute
 
;; A few more useful configurations...
(use-package emacs
  :init
  ;;following is for corfu
  ;;TAB cycle if only few candidates
  (setq completion-cycle-threshold 3)
  ;;enable indentation and completion using TAB
  (setq tab-always-indent 'complete)
  
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-safe-themes
   '("551629d1e63bb66423dd80b3ec2d1a67611d1fa570e7238201e65b25a3b3834f"
     "1a6d120936f9df3f44953124dbf9e56b399e021702ca7d1844e6c5e1658b692b"
     "ccd6472c71a889ce68e95598425452ddefbc84270d1ab99109054ef6443013f7"
     "bc3bbb671aef0ce2dd25fc33ab3ec5ade4376dedbebefd013a94670cdbc5fe67"
     "5ed59be4d14ed7891023875aeb3f7e08f2443354034d46cd10f9c7bceeac78a2"
     "71c3d6a8773ef1b1a76087272e34beeb297f59ab1895b855e59636bf846768a3"
     "7655a886e0abf125f803c467c3fd3774833b5f2172fddd5b00dde2ef281d741b"
     "d2beb37da70c76b1370c41f0c66e72b21df4fef9d563a080ff8cc59e7a7fd28f"
     "24fb1ea02dbd77413ed852a3b469d0e2805c5176954fccf39e89b66cfc8c391b"
     "f89afb3270a6a35797c916f28dd45c95c78a3d776674498aa44a5931d6165df5"
     "56c6522b9f8bee815b0eece87e503689dbc97017c4b08f4280c2c40f1b91b1d6"
     "8a2f30ae1a50c03750b0c2ab76e853a56707673bd11ff58bab6cecbf76dfbc68"
     "ad72c4b82c64b0af9568c174355ae4fd385561f2510ec52c6dcb82ca350a55d9"
     "cf301603c9b8fce423d206631d05b160dced315157a0bc6a96002554d60ee766"
     "3bb8300f5fa7518160f8a9d53efadb36246af28c013bac541161d62a02b0da18"
     "1a8873bebd8d6033b9187671d3d2184402dd728d6a38f9c067bc60dacc1a3ce3"
     "0cbb44039d42be765b4d36ad08cc96dca42a8a6d738abd5352902e0979aa3277"
     "f9a32e663453d5426aec71a39d7e690069da78b8f6d10455d55896b5f2e35a42"
     "2faea0ac65720ba2ca6a50a6d7ce52b4080d2c9a5acaa2d194e45666cefb5fd6"
     "a13a855010dc9236439b795fa74d2371fbda97c8362f2b1c355d6687e7aba25d"
     "a5270d86fac30303c5910be7403467662d7601b821af2ff0c4eb181153ebfc0a"
     "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d"
     "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd"
     "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b"
     "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe"
     default))
 '(package-selected-packages
   '(cider company dirvish eglot elm-mode elpy esup flycheck
	   flycheck-clang-analyzer general go-mode gruvbox-theme
	   hy-Mode hy-mode js2-mode lsp-mode magit php-mode quelpa
	   quelpa-use-package request sly spice-mode svelte-mode tide
	   tree-sitter tree-sitter-langs treesit tuareg
	   typescript-mode use-package vertico-posframe visual-regexp
	   web-mode which-key yasnippet yasnippet-snippets))
 '(safe-local-variable-values '((git-commit-major-mode . git-commit-elisp-text-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;include the config files
(add-to-list 'load-path "~/.emacs.d/configs/")

;; load individual files
(load "packages")   ;;load in packages, if too bg it gets its own file
(load "functions")  ;;all custom functions
(load "settings")   ;;all settings
(load "remaps")     ;;key remaps (loaded last with reason)

;;starts the server allowing us to use emacs clients and create multiple
;; connected editors
(server-start)
