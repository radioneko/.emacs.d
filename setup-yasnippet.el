;; yasnippet bound to M-TAB
(require 'yasnippet)
(setq yas-snippet-dirs
      (list
       (expand-file-name "snippets" user-emacs-directory)))

;; Expand snippets by M-Tab key
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "M-TAB") 'yas-expand)
(setq yas-fallback-behavior 'return-nil)
(yas-global-mode 1)

; don't expand yasnippets from auto-complete
;(when (boundp 'ac-source-yasnippet)
;  (makunbound 'ac-source-yasnippet))
;; (when (boundp 'ac-source-yasnippet)
;;   (setq ac-source-yasnippet
;;   	(mapcar '(lambda (el)
;;   		   (unless (eq (car el) 'action) el))
;;   		ac-source-yasnippet)))

;; This function is used in my snippets
(defun cc-variable-name (text)
  "Extract first variable name from declaration string"
  (let* ((decl (substring text 0 (string-match "[=,]" text))))
    (replace-regexp-in-string "[[:space:]]+" ""
			      (yas-substr decl "[0-9A-Za-z_]+[[:space:]]*$"))))

(defun latex-const-name (text)
  (replace-regexp-in-string "_" "" text))

(defun latex-const-value (text)
  (replace-regexp-in-string "_" "\\\\_" text))

(provide 'setup-yasnippet)
