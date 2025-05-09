;;disable menu bar and tool bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;;enable indentation in org mode automatically
(add-hook 'org-mode-hook 'org-indent-mode)

;; enable php mode
(when (file-directory-p "~/.emacs.d/configs/")
  (load "~/.emacs.d/configs/php-mode-autoloads.el"))

;; set backup directory such that backup files (...~) don't pile everywhere
(setq backup-directory-alist '(("." . "~/.file_backups")))

;;telling sly where to find the sbcl compiler
(setq inferior-lisp-program "/usr/bin/sbcl")

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

;;enable web-mode on .asp files
(add-to-list 'auto-mode-alist '("\\.asp\\'" . web-mode))

;;disable sound
(setq visible-bell 1)

;;don't tell me about style errors in my packages
(setq warning-minimum-level :warning)
