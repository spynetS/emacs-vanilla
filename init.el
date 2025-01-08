(setq cus "~/.config/emacs/custom.el")

 
(load "~/.config/emacs/rc.el")
(rc/require 'nyan-mode 'ido-completing-read+ 'magit 'corfu 'cape)
(rc/require-theme 'gruber-darker)

(menu-bar-mode 0)
(tool-bar-mode 0)
(display-battery-mode 1)
(display-time-mode 1)

;; ido
(ido-mode 1)
(ido-everywhere 1)

(ido-ubiquitous-mode 1)


(add-to-list 'default-frame-alist `(font . "Iosevka-16"))

(column-number-mode 1)
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)


(defun insertline ()
  (interactive)
  (move-beginning-of-line 1)
  (open-line 1)
  )
;; Override C-c C-c to compile in C mode
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'compile)))

;; Optional: Set custom compile command for C mode
(setq compile-command "gcc -Wall -o main main.c")

(global-set-key (kbd "C-c C-c") 'compile)
(global-set-key (kbd "C-o") 'insertline)
(global-set-key (kbd "C-.") 'dired)
(global-set-key (kbd "C-<tab>") 'ido-switch-buffer)
(global-set-key (kbd "C-&") 'previous-buffer)
(global-set-key (kbd "C-c d") 'duplicate-line)

;; magit
(global-set-key (kbd "C-g C-gzk") 'magit-clone)
(global-set-key (kbd "M-g c") 'magit-clone)


(defun my-dired-keys ()					
  "Set custom keys for Dired navigation."		
  (define-key dired-mode-map (kbd "h") 'dired-up-directory)
  (define-key dired-mode-map (kbd "l") 'dired-find-file)) 
(add-hook 'dired-mode-hook 'my-dired-keys)

;; corfu
(global-corfu-mode 1)
;; Enable auto completion and configure quitting
(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t


(load-file custom-file)
