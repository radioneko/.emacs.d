;; Turn off GUI menus and other crap
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;
;; Some very important setting
;;
(setq inhibit-splash-screen t)		; disable splash screen
(fset 'yes-or-no-p 'y-or-n-p)		; y/n instead of yes/no
(setq make-backup-files nil)		; let VCS and undo do their work
(line-number-mode 1)
(column-number-mode 1)			; show column number
(delete-selection-mode t)		; overwrite selection with new input
(setq auto-save-default nil)		; disable autosaves
(setq x-select-enable-primary nil)	; use primary selection
(setq x-select-enable-clipboard t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(require 'appearance)

(require 'cl)

;; Save position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

;;
;; el-get packages
;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq
 el-get-sources
 '((:name magit                         ; git meet emacs, and a binding
          :after (progn
                   (global-set-key (kbd "C-x C-z") 'magit-status)))))
(setq
 my:el-get-packages
 '(el-get               ; el-get is self-hosting
   auto-complete        ; complete as you type with overlays
   irony-mode           ; smart completion
   multiple-cursors	; multiple cursors
   expand-region	; expand region
   ace-jump-mode	; fast navigation
   dash			; modern iterators
))

(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; Automatically require setup scripts for most el-get packages
;; (let ((setup-dir user-emacs-directory))
;;   (loop for pkg in my:el-get-packages do
;; 	(let ((setup-pkg (if (symbolp pkg) pkg (intern pkg)))
;; 	      (setup-el (format "setup-%s.el" pkg)))
;; 	  (when (file-exists-p (expand-file-name setup-el setup-dir))
;; 	    (eval-after-load pkg `(require (quote ,(intern (format "setup-%s" pkg)))))))))

(let ((setup-dir user-emacs-directory))
  (dolist (fname (directory-files setup-dir))
    (when (string-match "setup-\\([^.]\+\\)\.el" fname)
	(let ((pkg (intern (match-string 1 fname))))
	  (eval-after-load pkg `(require (quote ,(intern (format "setup-%s" pkg)))))))))


;; Improve emacs usability for me
(require 'usability)

;; Load packages
(require 'auto-complete)
(require 'irony)
(require 'yasnippet)
(require 'ace-jump-mode)
(require 'undo-tree)
(require 'ido)

(require 'window-numbering)
(window-numbering-mode 1)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; find-function
(global-set-key (kbd "C-h C-f") 'find-function)

(defun jump-to-tag ()
  (interactive)
  (find-tag (thing-at-point 'symbol)))
(global-set-key (kbd "M-.") 'jump-to-tag)

;; Align comments and stuff
(defun my-align-region (start end)
  (interactive "r")
  (align start end)
  (align-regexp start end "\\(\\s-+\\)\\/[*/]" 1 1 nil))

(global-set-key (kbd "C-c a") 'my-align-region)

;; speedbar hackz
(require 'speedbar)
(defconst my-speedbar-buffer-name " SPEEDBAR")

(defun my-speedbar-no-separate-frame ()
  (interactive)
  (when (not (buffer-live-p speedbar-buffer))
    (setq speedbar-buffer (get-buffer-create my-speedbar-buffer-name)
	  speedbar-frame (selected-frame)
	  dframe-attached-frame (selected-frame)
	  speedbar-select-frame-method 'attached
	  speedbar-verbosity-level 0
	  speedbar-last-selected-file nil)
    (set-buffer speedbar-buffer)
    (speedbar-mode)
    (speedbar-reconfigure-keymaps)
    (speedbar-update-contents)
    (speedbar-set-timer 1)
    (add-hook 'kill-buffer-hook
	      (lambda () (when (eq (current-buffer) speedbar-buffer)
			   (setq speedbar-frame nil
				 dframe-attached-frame nil
				 speedbar-buffer nil)
			   (speedbar-set-timer nil))) t t))
  (set-window-buffer (selected-window)
		     (get-buffer my-speedbar-buffer-name)))



