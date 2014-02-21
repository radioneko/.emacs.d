;;
;; C-mode configuration
;;

;; irony smart completion
(require 'auto-complete)
(require 'yasnippet)

(require 'irony)
; hack to substitute :value parameter to popup-make-item with string
; representation (it is passed as '((r . TYPE) TEXT))
(defadvice popup-make-item (around popup-make-item-advice activate)
  (ad-set-args 0
	       (let ((arg-id nil))
		 (mapcar '(lambda (a)
			    (if (eq arg-id :value)
				(progn
				  (setq arg-id nil)
				  (if (stringp a) a (cadr a)))
			      (setq arg-id a)))
			 (ad-get-args 0))))
  ad-do-it)


(when (file-exists-p "/usr/lib/clang/3.3/include/")
  (setq irony-libclang-additional-flags
        '("-isystem" "/usr/lib/clang/3.3/include/")))
(irony-enable 'ac)


(defun compile-with-make ()
  (interactive)
  (compile "make"))
(global-set-key (kbd "<f9>") 'compile-with-make)

;; make compilation window small
(defun find-bottommost-window ()
  (let ((w nil) (bot 0))
    (dolist (win (window-list))
      (let ((b (+ (window-top-line win) (window-height))))
	(when (> b bot)
	  (setq w win bot b))))
    w))

(defun new-tool-window (name)
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer name)
          (shrink-window (- h 10))))))

(defun find-tool-window (name)
  (or
   (get-buffer-window name)
   (and (one-window-p) (new-tool-window name))
   (let ((w (find-bottommost-window)))
     (select-window w)
     (switch-to-buffer name)
     w)))

(defun my-compilation-hook ()
  (find-tool-window "*compilation*"))

(add-hook 'compilation-mode-hook 'my-compilation-hook)

(add-hook 'c-mode-common-hook
  (lambda ()
    (c-set-style "linux")
    (setq show-trailing-whitespace t)
    (setq indent-tabs-mode t)
    (setq c-basic-offset 4)
    (setq tab-width 4)
    (local-set-key (kbd "RET") 'newline-and-indent)
    (undo-tree-mode 1)
    ; enable irony
    (yas/minor-mode-on)
    (auto-complete-mode 1)
    (when (member major-mode irony-known-modes)
      (irony-mode 1))
))

(provide 'setup-cc-mode)
