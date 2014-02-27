;; Highlight current line
(global-hl-line-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; Set default font face
(set-frame-font "Droid Sans Mono-10" nil t)

;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(load-theme 'sunburst t)

(provide 'appearance)
