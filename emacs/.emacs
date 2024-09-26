;; Set theme to misterioso (for better viewing experience)
(load-theme 'misterioso)

;; follow symlinks to git controlled files (ex. dotFiles)
(setq vc-follow-symlinks t)

;; tab rules
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Put tempfiles in "backups" directory under emacs user directory (includes ~ files)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;; Whitespace color corrections.
(require 'color)
(let* ((ws-lighten 55) ;; Amount in percentage to lighten up black.
       (ws-color (color-lighten-name "#000000" ws-lighten)))
  (custom-set-faces
   `(whitespace-newline                ((t (:foreground ,ws-color))))
   `(whitespace-missing-newline-at-eof ((t (:foreground ,ws-color))))
   `(whitespace-space                  ((t (:foreground ,ws-color))))
   `(whitespace-space-after-tab        ((t (:foreground ,ws-color))))
   `(whitespace-space-before-tab       ((t (:foreground ,ws-color))))
   `(whitespace-tab                    ((t (:foreground ,ws-color))))
   `(whitespace-trailing               ((t (:foreground ,ws-color))))))

;; Make these characters represent whitespace.
(setq-default whitespace-display-mappings
      '(
    ;; space -> · else .
    (space-mark 32 [183] [46])
    ;; new line -> ¬ else $
    (newline-mark ?\n [172 ?\n] [36 ?\n])
    ;; carriage return (Windows) -> ¶ else #
    (newline-mark ?\r [182] [35])
    ;; tabs -> » else >
    (tab-mark ?\t [187 ?\t] [62 ?\t])))

;; Set whitespace actions.
(setq-default whitespace-action
          '(cleanup auto-cleanup))

;; visual whitespace
(global-whitespace-mode 1)
(require 'whitespace)
