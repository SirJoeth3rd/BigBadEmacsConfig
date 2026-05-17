(global-unset-key (kbd "C-s")) ;; I need C-s for my selection functions
(global-unset-key (kbd "C-d")) ;; delete-char is useless

;; make tab key do indent first then completion.
(setq tab-always-indent 'complete)

(defun set-keys-on-map (map &rest remaps)
  "Convenience function to set multiple keymaps."
  (let ((key (pop remaps))
       (fun (pop remaps)))
    (keymap-set map key fun)
    (when remaps (apply 'set-keys-on-map map remaps))))

(defvar universal-keymap-mode-map (make-sparse-keymap)
  "Universal overide keymap.")

(setq god-literal-key "SPC")

;;following keymaps must always be set
(set-keys-on-map
 universal-keymap-mode-map
 "C-k" 'next-line
 "C-f" 'god-mode-all
 "C-j" 'left-char
 "C-l" 'right-char
 "C-o" 'forward-word
 "C-u" 'backward-word
 "C-," 'xah-next-window-or-frame
 "C-;" 'end-of-line
 "C-:" 'beginning-of-line
 "C-3" 'delete-other-windows
 "C-#" 'kill-buffer-and-window
 "C-4" 'split-window-below
 "C-$" 'split-window-right
 "C-z" 'xah-comment-dwim
 "C-n" 'isearch-forward-regexp
 "C-e" 'universal-argument
 "C-8" 'xah-extend-selection ;; TODO -> first try combobulate
 "M-%" 'vr/replace
 "C-M-%" 'vr/query-replace
 "C-c C-c" 'recompile
 "C-c b" 'buffer-menu
 "C-d C-b" 'kill-current-buffer
 "C-c e" 'replace-elisp-with-result
 "M-ESC" 'delete-frame
 )


(define-minor-mode universal-keymap-mode
  "Keymaps that I ALWAYS want in place."
  :lighter "UniK"
  :keymap universal-keymap-mode-map
  :global t
  )

(universal-keymap-mode)

(defalias 'select-line
  (kmacro "C-: C-s C-s C-;"))

(defalias 'kill-line-custom
  (kmacro "C-s C-l <DEL> <DEL>"))

;;selection fucntions
(set-keys-on-map (current-global-map)
 "C-s C-s" 'set-mark-command
 "C-s C-w" 'mark-word
 "C-s C-b" 'mark-whole-buffer
 "C-s C-p" 'mark-page
 "C-s C-l" 'select-line ;; our select line function
 "C-d C-d" 'kill-line-custom)

;; The following is to solve a conundrum, TAB is sent as C-i to emacs.
;; I want C-i to mean previous-line and TAB to mean TAB.

(defun reset-ctrl-i ()
	"Splits C-i from TAB as two different keys."
	(interactive)
	(define-key input-decode-map [?\C-i] [control-i])
	(global-set-key (kbd "<control-i>") 'previous-line))

(add-hook 'after-make-frame-functions (lambda (frame) (reset-ctrl-i)))

(if (daemonp)
	nil            ;; If this is daemon server frames are handled by hook above.
	(reset-ctrl-i));; Else, configure the initial frame

;; in terminal mode TAB will always be C-i
;; so best we can do is map i to up in god-mode only
(keymap-set god-local-mode-map "i" 'previous-line)

;;unloading key in verilog mode
(when (boundp 'verilog-mode-map) (keymap-set verilog-mode-map "C-;" 'end-of-line))

(provide 'remaps)
;;; remaps.el ends here
