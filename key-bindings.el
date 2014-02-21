;; Map undo/redo
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-z") 'undo)

;; jump to tag doesn't ask for symbol name
(defun jump-to-tag ()
  (interactive)
  (find-tag (thing-at-point 'symbol)))
(global-set-key (kbd "C-]") 'jump-to-tag)
(global-set-key (kbd "C-t") 'pop-tag-mark)

;; find-function
(global-set-key (kbd "C-h C-f") 'find-function)

(provide 'key-bindings)
