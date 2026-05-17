;;; package --- All my packages and some configs
;;; Commentary:
;;  All lisp/ directory contains all the git submodules of all the packages
;;; Code:

;;set <pkg>-path variables for use in use-package load-path expressions
(cl-loop for file in (directory-files (concat user-emacs-directory "lisp/"))
	 for package = (file-name-sans-extension file)
	 unless (string-prefix-p "." file)
	 do (set
	     (intern (concat package "-path"))
	     (concat user-emacs-directory "lisp/" file)))

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;;god-mode
(use-package god-mode
  :load-path god-mode-path
  :config
  (god-mode)
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (defun my-god-mode-update-cursor-type ()
    (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
  (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)
  (god-mode))

;; the search and replace you deserve
(use-package visual-regexp
  :ensure t)

(use-package vertico
  :load-path vertico-path
  :config
  (vertico-mode)
  (setq vertico-cycle t))

(load (expand-file-name "extensions/vertico-sort.el" vertico-path))
(setq vertico-sort-function 'vertico-sort-history-length-alpha)

(use-package savehist
  :config
  (savehist-mode))

;;dired
(defun dired-find-file-other-window-cond ()
	(interactive)
	(if (and (> (length (window-list)) 1) (not (file-directory-p (dired-get-file-for-visit))))
			(dired-find-file-other-window)
		(dired-find-file)))

(use-package dired
	:config
	(setq dired-dwim-target t)
	:bind (
				 :map dired-mode-map
							("<return>" . dired-find-file-other-window-cond)))

;;syntax checker
(use-package flycheck
  :load-path flycheck-path
  :ensure t
  :config (global-flycheck-mode))

(use-package company
	:load-path company-mode-path
	:demand t
	:config
	(add-hook 'after-init-hook 'global-company-mode)
	(setq company-idle-delay 0)
	:custom
	search only in same-mode buffers
	(company-dabbrev-other-buffers t)
	(company-dabbrev-code-other-buffers t)
	Start completion after 2 letters
	(company-minimum-prefix-length 3)
	no company mode in shell and eshell
	(company-global-modes '(not eshell-mode shell-mode))
	use company with text and programming modes
	:hook ((text-mode . company-mode)
				 (prog-mode . company-mode))
	)

;;eglot bro it's eglot
;;eglot is built in
(use-package eglot
  :ensure t
  )

;;git for a /g/entlemen
(use-package magit
  :load-path magit-path
  :ensure t)

;;
(use-package counsel-etags
	:vc t
	:load-path counsel-etags-path
  :ensure t
  :bind (("C-]" . counsel-etags-find-tag-at-point))
  :init
  (add-hook 'prog-mode-hook
        (lambda ()
          (add-hook 'after-save-hook
            'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories))

;; Treesitter setup
(when (treesit-available-p) ;; treesitter might not be available
    (use-package treesit
      :load-path elisp-tree-sitter-path
      :config
      (setq treesit-language-source-alist
	    '((c "https://github.com/tree-sitter/tree-sitter-c.git")
	      (bash "https://github.com/tree-sitter/tree-sitter-bash")
	      (cmake "https://github.com/uyha/tree-sitter-cmake")
	      (css "https://github.com/tree-sitter/tree-sitter-css")
	      (elisp "https://github.com/Wilfred/tree-sitter-elisp")
	      (go "https://github.com/tree-sitter/tree-sitter-go")
	      (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
	      (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile")
	      (html "https://github.com/tree-sitter/tree-sitter-html")
	      (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	      (json "https://github.com/tree-sitter/tree-sitter-json")
	      (make "https://github.com/alemuller/tree-sitter-make")
	      (markdown "https://github.com/ikatyang/tree-sitter-markdown")
	      (python "https://github.com/tree-sitter/tree-sitter-python")
	      (toml "https://github.com/tree-sitter/tree-sitter-toml")
	      (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	      (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
	      (yaml "https://github.com/ikatyang/tree-sitter-yaml"))))
    )

;;org mode with feminine sensibilities
(use-package org-modern
  :load-path org-modern-path
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

;;following two modes are mainly for the workflow project
(use-package go-mode
  :load-path go-mode-path
	:config
	(setq go-ts-mode-indent-offset 2)
	(autoload 'go-mode "go-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
	:config
	(setq-default go-ts-mode-indent-offset 2)
  :hook
  (go-mode . outline-minor-mode)
  (go-mode . (lambda ()
							 (progn
								 (setq-local outline-regexp "//#[#^L]*")
								 (outline-hide-body)))))

;; emacs built in folding
;; TODO: check out integration with imenu
(use-package outline
  :config
  (setq outline-minor-mode-cycle t))

;; whitebox
(load-file (concat user-emacs-directory "lisp/whitebox.el"))

;; combobulate
(use-package combobulate
  :load-path combobulate-path
  :hook ((prog-mode . combobulate-mode)))
(use-package tempel
	:load-path tempel-path)

(use-package multiple-cursors
	:load-path multiple-cursors-path)

(provide 'packages)
;;; packages.el ends here
