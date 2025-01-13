(setq custom-file "~/.config/emacs/custom.el")

;; c3-
(load "~/.config/emacs/custom-packages/c3-ts-mode.el")
(add-to-list 'treesit-language-source-alist
	     '(c3 "https://github.com/c3lang/tree-sitter-c3"))

;; projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))
;; Nyan mode
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1))

;; Theme
(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

;; Flycheck
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode +1))

;; Which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; LSP mode and LSP UI
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :config
  ;; Optionally configure lsp-ui settings here
  )

;; Smex
(use-package smex
  :ensure t
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-x M-x") 'execute-extended-command))


;; treemacs
(use-package treemacs
  :ensure t
  :defer t
  )

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;; IDO Mode
(use-package ido-completing-read+
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

;; Font
(add-to-list 'default-frame-alist `(font . "Iosevka-16"))

;; Disable menu-bar, tool-bar, and scroll-bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display settings
(column-number-mode 1)
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)

;; Insert line function
(defun insertline ()
  (interactive)
  (move-beginning-of-line 1)
  (open-line 1))

(defun insertline-after ()
  (interactive)
  (move-end-of-line 1)
  (newline))

;; Override C-c C-c to compile in C mode
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'compile)))

;; Optional: Set custom compile command for C mode
(setq compile-command "make")

;; Global keybindings
(global-set-key (kbd "C-c C-v") 'project-compile)
(global-set-key (kbd "C-c C-c") 'compile)

(global-set-key (kbd "C-o") 'insertline-after)
(global-set-key (kbd "C-S-o") 'insertline)

(global-set-key (kbd "C-.") 'dired)
(global-set-key (kbd "C-<tab>") 'ido-switch-buffer)
(global-set-key (kbd "C-&") 'previous-buffer)
(global-set-key (kbd "C-c C-d d") 'duplicate-line)
(global-set-key (kbd "C-c C-d c") 'copy-line)

;; window movement
(windmove-default-keybindings)

;; Magit
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "M-g c") 'magit-clone)
  (global-set-key (kbd "M-g g") 'magit))

;; Dired
(use-package dired
  :ensure nil  ;; Dired is built-in, so we don't need to install it.
  :config
  ;; Basic dired keybindings
  (define-key dired-mode-map (kbd "C-h") 'dired-up-directory)  ;; Navigate up
  (define-key dired-mode-map (kbd "C-l") 'dired-find-file)     ;; Open file
  (define-key dired-mode-map (kbd "RET") 'dired-find-file)      ;; Open file with Enter
  (define-key dired-mode-map (kbd "C-c C-r") 'revert-buffer)    ;; Refresh the dired buffer

  ;; Marking files
  (define-key dired-mode-map (kbd "m") 'dired-mark)             ;; Mark file
  (define-key dired-mode-map (kbd "u") 'dired-unmark)           ;; Unmark file
  (define-key dired-mode-map (kbd "t") 'dired-toggle-marks)     ;; Toggle marks
  (define-key dired-mode-map (kbd "M") 'dired-mark-extension)   ;; Mark files by extension

  ;; Deleting files
  (define-key dired-mode-map (kbd "D") 'dired-do-delete)        ;; Delete files
  (define-key dired-mode-map (kbd "x") 'dired-do-execute)       ;; Execute a command on marked files

  ;; File operations
  (define-key dired-mode-map (kbd "C") 'dired-create-directory) ;; Create directory
  (define-key dired-mode-map (kbd "R") 'dired-do-rename)        ;; Rename file
  (define-key dired-mode-map (kbd "C-c C-c") 'dired-do-copy)    ;; Copy files
  (define-key dired-mode-map (kbd "C-c C-d") 'dired-do-symlink) ;; Create symlink

  ;; Searching
  (define-key dired-mode-map (kbd "/") 'dired-isearch-filenames)  ;; Search filenames
  (define-key dired-mode-map (kbd "g") 'revert-buffer)             ;; Reload dired buffer

  ;; File viewer
  (define-key dired-mode-map (kbd "v") 'dired-view-file)          ;; View file in external viewer
  (define-key dired-mode-map (kbd "q") 'kill-this-buffer)         ;; Quit dired

  ;; Other useful bindings
  (define-key dired-mode-map (kbd "C-M") 'dired-do-chmod)         ;; Change file permissions
  (define-key dired-mode-map (kbd "C-+") 'dired-omit-mode)        ;; Hide omitted files
  (define-key dired-mode-map (kbd "C-?") 'dired-do-compress)      ;; Compress files
)

(add-hook 'dired-mode-hook 'my-dired-keys)

;; Custom key to open init.el
(global-set-key (kbd "C-c C-x C-f")
                (lambda () (interactive) (find-file "~/.config/emacs/init.el")))

;; Corfu and Cape for completion
(use-package corfu
  :ensure t
  :config
  (global-corfu-mode 1)
  (setq corfu-auto t
        corfu-quit-no-match 'separator))

(use-package cape
  :ensure t)

;; Copy line function
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
Ease of use features:
- Move to start of next line.
- Appends the copy on sequential calls.
- Use newline as last char even on the last line of the buffer.
- If region is active, copy its lines."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(setq compilation-ask-about-save nil)

;; Load custom file after all configurations
(load-file custom-file)
(put 'downcase-region 'disabled nil)
