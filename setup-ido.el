(require 'ido)
(ido-mode t)
;; Better buffer switching with ido
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

(provide 'setup-ido)
