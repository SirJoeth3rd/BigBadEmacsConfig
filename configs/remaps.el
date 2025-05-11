(global-unset-key (kbd "C-s")) ;; I need C-s for my selection functions
(global-unset-key (kbd "C-d")) ;; delete-char is useless

(defun set-keys-on-map (map &rest remaps)
  "Convenience function to set multiple keymaps."
  (let ((key (pop remaps))
       (fun (pop remaps)))
    (keymap-set map key fun)
    (when remaps (apply 'set-keys-on-map map remaps))))

(global-set-key (kbd "C-c C-b") 'buffer-menu)

(set-keys-on-map mode-specific-map "C-c C-b" 'buffer-menu)

(set-keys-on-map (current-global-map)
 "C-f" 'god-mode-all
 "C-k" 'next-line
 "C-p" 'previous-line
 "C-j" 'left-char
 "C-l" 'right-char
 "C-o" 'forward-word
 "C-u" 'backward-word
 "C-." 'xah-forward-right-bracket
 "C->" 'xah-backward-left-bracket
 "C-," 'xah-next-window-or-frame
 "C-;" 'end-of-line
 "C-:" 'beginning-of-line
 "C-3" 'delete-other-windows
 "C-4" 'split-window-below
 "C-$" 'split-window-right
 "C-z" 'xah-comment-dwim
 "C-n" 'isearch-forward ;;change this to regex
 "C-e" 'universal-argument
 "C-8" 'xah-extend-selection
 "M-%" 'vr/replace
 "C-M-%" 'vr/query-replace
 "C-c C-c" 'recompile
 "C-c b" 'buffer-menu
 "C-d C-b" 'kill-current-buffer
 )

(defalias 'select-line
   (kmacro "C-: C-s C-s C-;"))

;;selection fucntions
(set-keys-on-map (current-global-map)
 "C-s C-s" 'set-mark-command
 "C-s C-w" 'mark-word
 "C-s C-b" 'mark-whole-buffer
 "C-s C-p" 'mark-page
 "C-s C-l" 'select-line) ;; our select line function

;; only remap i in god-mode locally
(keymap-set god-local-mode-map "i" 'previous-line)

