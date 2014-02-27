(require 'evil)
(require 'goto-last-change)
(require 'evil-leader)

(setq evil-insert-state-cursor '("red" box)
      evil-normal-state-cursor '("white" box)
      evil-visual-state-cursor '("green" box))


(define-key evil-normal-state-map [insert] 'evil-insert)
(define-key evil-insert-state-map [C-return] 'yas/expand)
;; ace-jump
;; (define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-char-mode)
;; (define-key evil-normal-state-map (kbd "S-SPC") 'evil-ace-jump-char-to-mode)
;; (define-key evil-normal-state-map (kbd "C-SPC") 'evil-ace-jump-word-mode)
;; (define-key evil-normal-state-map (kbd "C-S-SPC") 'evil-ace-jump-line-mode)

;; Setup evil-leader keys
(global-evil-leader-mode 1)
(evil-leader/set-leader "SPC")
(evil-leader/set-key
  "b"	'ido-switch-buffer
  "f"	'ido-find-file
  "g"	'magit-status
  "k"	'kill-this-buffer
  "w"	'window-configuration-to-register
  "r"	'jump-to-register
  "j"	'ace-jump-char-mode
  "J"	'ace-jump-word-mode)


(evil-mode 1)

(provide 'setup-evil)
