(require 'evil)
(require 'goto-last-change)

(define-key evil-normal-state-map [insert] 'evil-insert)
(define-key evil-insert-state-map [C-return] 'yas/expand)
;; ace-jump
(define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-char-mode)
(define-key evil-normal-state-map (kbd "S-SPC") 'evil-ace-jump-char-to-mode)
(define-key evil-normal-state-map (kbd "C-SPC") 'evil-ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "C-S-SPC") 'evil-ace-jump-line-mode)
(evil-mode 1)

(provide 'setup-evil)
