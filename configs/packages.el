;;TODO make all my modes eglot centric
;;the search and replace you deserve

;;; Code:
;;set <pkg>-path variables for use in use-package load-path expressions
(cl-loop for file in (directory-files (concat user-emacs-directory "lisp/"))
	 for package = (file-name-sans-extension file)
	 unless (string-prefix-p "." file)
	 do (set
	     (intern (concat package "-path"))
	     (concat user-emacs-directory "lisp/" file)))

(use-package visual-regexp
  :load-path visual-regexp-path
  :ensure t)

;; Enable vertico
(use-package vertico
  :load-path vertico-path
  :config
  (vertico-mode)
  (setq vertico-cycle t))

;;yasnippet
(use-package yasnippet
  :load-path yasnippet-path
  :config (yas-global-mode 1))

;;syntax checker
(use-package flycheck
  :load-path flycheck-path
  :ensure t
  :config (global-flycheck-mode))

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

(use-package company
  :load-path company-mode-path
  :ensure t
  :defer t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  :custom
  ;;search only in same-mode buffers
  (company-dabbrev-other-buffers t)
  (company-dabbrev-code-other-buffers t)
  ;;M-<num> to select option <num>
  (company-show-numbers t)
  ;;Start completion after 2 letters
  (company-minimum-prefix-length 3)
  ;;no company mode in shell and eshell
  (company-global-modes '(not eshell-mode shell-mode))
  ;;use company with text and programming modes
  :hook ((text-mode . company-mode)
	 (prog-mode . company-mode))
  )

;;eglot bro it's eglot
;;eglot is built in 
(use-package eglot
  :ensure t
  :defer t
  :config
  )

;;git for a /g/entleman
(use-package magit
  :load-path magit-path
  :ensure t)

(use-package go-mode
  :load-path go-mode-path)

