;;set the capslock-f key to toggel cmd and insert mode
;;(global-set-key (kbd "C-f") 'xah-fly-mode-toggle)

;;control movement keys act like normal movement
(keyboard-translate ?\C-i ?\C-p)

;;the general package is like use-package but for keybindings
(use-package general)

(general-unbind
  "C-d" ;;to serve as prefix for delete commands
  "C-s" ;;prefix for select statements
  )

;;This big key map is movement keys I want in all buffers
;; but it works well with godmode
(general-define-key
 :keymaps 'override
 "C-f" 'god-mode-all
 "C-p" 'previous-line
 "C-k" 'next-line
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
 )

;;these are placed seperately since C-c
;;is for user defined functions
(general-define-key
 :prefix "C-c"
 :keymaps 'override
 "C-t" 'open-terminal-in-workdir
 "C-b" 'buffer-menu)

;;my delete keybinds
(general-define-key
 :prefix "C-d"
 :keymaps 'override
 "C-l" 'kill-whole-line
 "C-w" 'kill-word
 "C-c" 'kill-comment
 "C-s" 'kill-sentence
 "C-p" 'kill-paragraph
 "C-b" 'kill-current-buffer
 "C-r" 'kill-region
 "C-d" 'delete-char)

(defalias 'select-line
   (kmacro "C-: C-s C-s C-;"))

;;my selection fucntions
(general-define-key
 :prefix "C-s"
 :keymaps 'override
 "C-s" 'set-mark-command
 "C-w" 'mark-word
 "C-b" 'mark-whole-buffer
 "C-p" 'mark-page
 "C-l" 'select-line) ;; our select line function

;;following is needed to make god mode play nice with i
;;also can place god mode specific keymaps here
(general-define-key
 :keymaps 'god-local-mode-map
 "i" 'previous-line)

