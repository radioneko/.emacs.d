;;
;; Lisp mode hooks
;;
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            (folding-mode 1)
	    (auto-complete-mode 1)
	    (define-key emacs-lisp-mode-map
	      "\C-x\C-e" 'pp-eval-last-sexp)
	    (local-set-key (kbd "RET") 'newline-and-indent)))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(provide 'setup-lisp-mode)
