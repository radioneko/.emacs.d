;; irony smart completion
(require 'irony)
(when (file-exists-p "/usr/lib/clang/3.3/include/")
  (setq irony-libclang-additional-flags
        '("-isystem" "/usr/lib/clang/3.3/include/")))
(irony-enable 'ac)

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

(provide 'setup-irony)
