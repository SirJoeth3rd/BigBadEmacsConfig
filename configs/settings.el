;;-*- lexical-binding:t -*-

;;disable menu bar and tool bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq truncate-lines 't)

;;enable indentation in org mode automatically
(add-hook 'org-mode-hook 'org-indent-mode)

;; set backup directory such that backup files (...~) don't pile everywhere
(setq backup-directory-alist '(("." . "~/.file_backups")))

;;this mode automatically updates files that have changed on the disk
(global-auto-revert-mode 1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Remember recently opened files
(recentf-mode 1)

;;enable upcase and downcase region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;enable line numbers
(global-display-line-numbers-mode)

;;use web-mode on .asp files
(add-to-list 'auto-mode-alist '("\\.asp\\'" . web-mode))

;;disable sound
(setq visible-bell 1)

;;don't tell me about style errors in my packages
(setq warning-minimum-level :warning)

;; keep a history of commands which vertico can use
(savehist-mode 1)

;; highlight matching parentheses
(setq show-paren-delay 0)
(show-paren-mode +1)

;; which key shows possible options as you type in minibuffer
;; this will only work for emacs v 30+
(which-key-mode)
(which-key-setup-side-window-right-bottom) ;;Elisp isn't japanese
(setq which-key-idle-delay 0.5)

;;TODO: do some work to integrate which-key with god-mode

;;the tao theme
(add-to-list 'load-path (concat user-emacs-directory "lisp/tao-theme"))
(add-to-list 'custom-theme-load-path
	     (concat user-emacs-directory "lisp/tao-theme"))
(load-theme 'tao-yin)

(setq initial-buffer-choice "~/welcome.org")

;;; following is to detect .bashrc in emacs, very usefull for
;;; inferior lisp processes. 
(setq shell-command-switch "-ic")

;; which langauges can you use in org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((haskell . t)
   (python . t)
   (dot . t)))

;; setting org-minor-mode regexp for some langauges
(defun outline-mode-hook (rgx)
  "Create an outline mode hook function with regexp RGX."
  (lambda ()
    (progn
      (outline-minor-mode)
      (setq-local outline-regexp rgx))))

(add-hook 'c-mode-hook (outline-mode-hook " *//#[#^L]*"))

(provide 'settings)
;;; settings.el ends here

