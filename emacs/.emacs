;;Set theme to solarized-dark
(load-theme 'misterioso)

;;tabing plays nicely for c files (Deprecated?)
(setq-default c-default-style "linux"
	      c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)

;;Put tempfiles in "backups" directory under emacs user directory (includes ~ files)
(setq backup-directory-alist
	  `(("." . ,(concat user-emacs-directory "backups"))))
