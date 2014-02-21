;; ido buffer switching
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; jump to tag doesn't ask for symbol name
(defun jump-to-tag ()
  (interactive)
  (find-tag (thing-at-point 'symbol)))
(global-set-key (kbd "M-.") 'jump-to-tag)

;; find-function
(global-set-key (kbd "C-h C-f") 'find-function)

(provide 'key-bindings)
