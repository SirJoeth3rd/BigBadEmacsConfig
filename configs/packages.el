;;TODO make all my modes eglot centric
;;the search and replace you deserve
(use-package visual-regexp
  :ensure t)

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)
  ;; vertico cycling
  (setq vertico-cycle t))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;;yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(use-package yasnippet
  :config (yas-global-mode 1))

;;Highlight matching paren
(use-package paren
  :ensure nil
  :init
  (setq show-paren-delay 0)
  :config
  (show-paren-mode +1))

;;syntax checker
(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

;;god-mode
(use-package god-mode
  :config
  (god-mode)
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (defun my-god-mode-update-cursor-type ()
    (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
  (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)
  (god-mode))

;;shows minibuffer with all available key combinations
(use-package which-key
  :config (which-key-mode))

;;just the color theme
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-hard))

;;dirvish, basically dired++
(use-package dirvish
  :config
  (dirvish-override-dired-mode))

(use-package company
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
(use-package eglot
  :ensure t
  :defer t
  :config
  (add-to-list 'eglot-server-programs
	       '(svelte-mode . ("svelteserver" "--stdio"))))

;;git for a /g/entleman
(use-package magit
  :ensure t)

