;;
;; Auto complete/yasnippet
;;

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name "/auto-complete/dict" site-lisp-dir))
(ac-config-default)
(global-auto-complete-mode t)
;; Adjust autocomplete bindings
(define-key ac-completing-map [down] nil)
(define-key ac-completing-map [up] nil)
(define-key ac-completing-map "\C-n" 'ac-next)
(define-key ac-completing-map "\C-p" 'ac-previous)


; don't expand yasnippets from auto-complete
(when (boundp 'ac-source-yasnippet)
  (setq ac-source-yasnippet
	(mapcar '(lambda (el)
		   (unless (eq (car el) 'action) el))
		ac-source-yasnippet)))

(provide 'setup-auto-complete)
