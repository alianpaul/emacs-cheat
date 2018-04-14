;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

(package-initialize)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(setq inhibit-splash-screen 1)

(global-linum-mode 1)

;;complete anything
(global-company-mode 1)

;;cursor type,
;;setq buffer local variable, we use setq-default to make it global
(setq-default cursor-type 'bar)

;;disable backup files
(setq make-backup-files nil)

;;open a buffer contain recent editted files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;delete origin selected content when we yank
(delete-selection-mode 1)

;;full screen when emasc is opened
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;;hightlight current line
(global-hl-line-mode 1)

;;hightlight matching parenthesis
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;Install packages automatically
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

 ;; cl - Common Lisp Extension
(require 'cl)

(defvar my/packages '(
		      ;; --- Auto-completion ---
		      company
		      ;; --- Better Editor ---
		      hungry-delete
		      swiper
		      counsel
		      smartparens
		      ;;smex
		      ;; --- Major Mode ---
		      ;;js2-mode
		      ;; --- Minor Mode ---
		      ;;nodejs-repl
		      ;;exec-path-from-shell
		      ;; --- Themes ---
		      ;;cyberpunk-theme
		      ;;monokai-theme
		      solarized-theme
		      ;; --- org-mode export ---
		      htmlize
		      ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;(load-theme 'cyberpunk 1)
(load-theme 'solarized-light 1)

(require 'hungry-delete)
(global-hungry-delete-mode)

;;swiper
;;(ivy-mode 1)
;;(setq ivy-use-virtual-buffers t)
;;(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(smartparens-global-mode t)

;;;;Org mode;;;;
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;;;;Font;;;;
;; Setting English Font
;;(set-face-attribute 'default nil :font "Consolas")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Microsoft Yahei"
                                       )))
(setq face-font-rescale-alist '(("Microsoft Yahei" . 1.2) ))
