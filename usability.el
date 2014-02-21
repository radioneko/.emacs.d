(defun my-save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer(once only), then kill this Emacs process.
With prefix ARG, silently save all file-visiting buffers, then kill."
  (interactive "P")
  (save-some-buffers arg t)
  (and (or (not (fboundp 'process-list))
       ;; process-list is not defined on MSDOS.
       (let ((processes (process-list))
         active)
         (while processes
           (and (memq (process-status (car processes)) '(run stop open listen))
            (process-query-on-exit-flag (car processes))
            (setq active t))
           (setq processes (cdr processes)))
         (or (not active)
         (progn (list-processes t)
            (yes-or-no-p "Active processes exist; kill them and exit anyway? ")))))
       ;; Query the user for other things, perhaps.
       (run-hook-with-args-until-failure 'kill-emacs-query-functions)
       (or (null confirm-kill-emacs)
       (funcall confirm-kill-emacs "Really exit Emacs? "))
       (kill-emacs)))

;; Get rid of annoying "not-all-buffers-were-saved" message
(fset 'save-buffers-kill-emacs 'my-save-buffers-kill-emacs)

;; Automatically indent yanked text
(defun yank-autoindent ()
  (dolist (command '(yank yank-pop))
     (eval `(defadvice ,command (after indent-region activate)
              (and (not current-prefix-arg)
                   (member major-mode '(emacs-lisp-mode lisp-mode
                                                        clojure-mode    scheme-mode
                                                        haskell-mode    ruby-mode
                                                        rspec-mode      python-mode
                                                        c-mode          c++-mode
                                                        objc-mode       latex-mode
                                                        plain-tex-mode))
                   (let ((mark-even-if-inactive transient-mark-mode))
                     (indent-region (region-beginning) (region-end) nil)))))))

;; Hacks to avoid enormous number of split windows
;; from http://stackoverflow.com/questions/1381794/too-many-split-screens-opening-in-emacs
(setq pop-up-windows nil)

(defun my-display-buffer-function (buf not-this-window)
  (if (and (not pop-up-frames)
           (one-window-p)
           (or not-this-window
               (not (eq (window-buffer (selected-window)) buf)))
           (> (frame-width) 162))
      (split-window-horizontally))
  ;; Note: Some modules sets `pop-up-windows' to t before calling
  ;; `display-buffer' -- Why, oh, why!
  (let ((display-buffer-function nil)
        (pop-up-windows nil))
    (display-buffer buf not-this-window)))

(setq display-buffer-function 'my-display-buffer-function)

(provide 'usability)
