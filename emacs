;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp")

;; (require 'font-lock+)
(setq make-backup-files nil)
(setq vc-follow-symlinks nil)
(setq evil-want-C-u-scroll t)
(setq-default major-mode 'text-mode)
(setq-default evil-cross-lines t) ;; cursor right at end of line goes to start of next line
(electric-pair-mode 1)

(xterm-mouse-mode 1)
(require 'mouse-drag)
(global-set-key[mouse-4] 'scroll-down-line)
(global-set-key[mouse-5] 'scroll-up-line)
;; (define-key key-translation-map (kbd "<mouse-4>") 'scroll-down-line)
;; (define-key key-translation-map (kbd "<mouse-5>") 'scroll-up-line)

(setq-default display-line-numbers-type 'visual
              display-line-numbers-current-absolute t
              display-line-numbers-width 4
              display-line-numbers-widen t)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
					;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Ensure that use-package is installed.
;;
;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package all-the-icons
  :ensure t)

;use-package doom-modeline
;  :ensure t
;:init (doom-modeline-mode 1))

(use-package smart-mode-line
  :ensure t)

(use-package smart-mode-line-powerline-theme
  :ensure t)

;; (setq sml/theme 'powerline)
(setq sml/theme 'light)
(setq sml/no-confirm-load-theme t)
(sml/setup)


(add-to-list 'load-path "~/.local/share/icons-in-terminal/")
(require 'icons-in-terminal)
(insert (icons-in-terminal 'oct_flame)) ; C-h f icons-in-terminal[RET] for more info

(set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
(set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
(set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
(set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
(set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
(set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" default)))
 '(package-selected-packages
   (quote
    (all-the-icons-ivy all-the-icons nasm-mode zones navigator paper-theme ewal-spacemacs-themes spacemacs-theme spacemacs-dark-theme spacemacs-dark helm-ag gruvbox which-key evil-nerd-commenter company-lsp lsp-ui lsp-mode gruvbox-theme evil-leader neotree use-package evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(add-to-list 'auto-mode-alist '("\\.nasm\\'" . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.asm\\'" . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . nasm-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EVIL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ",")
  )

(require 'evil)
(evil-mode t)
(evil-select-search-module 'evil-search-module 'evil-search)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(defgroup navigate nil
  "seamlessly navigate between Emacs and tmux"
  :prefix "navigate-"
  :group 'evil)

					; Without unsetting C-h this is useless
(global-unset-key (kbd "C-h"))

					; This requires windmove commands
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(defun tmux-navigate (direction)
  (let
      ((cmd (concat "windmove-" direction)))
    (condition-case nil
	(funcall (read cmd))
      (error
       (tmux-command direction)))))

(defun tmux-command (direction)
  (shell-command-to-string
   (concat "tmux select-pane -"
	   (tmux-direction direction))))

(defun tmux-direction (direction)
  (upcase
   (substring direction 0 1)))

(define-key evil-normal-state-map
  (kbd "C-h")
  (lambda ()
    (interactive)
    (tmux-navigate "left")))
(define-key evil-normal-state-map
  (kbd "C-j")
  (lambda ()
    (interactive)
    (tmux-navigate "down")))
(define-key evil-normal-state-map
  (kbd "C-k")
  (lambda ()
    (interactive)
    (tmux-navigate "up")))
(define-key evil-normal-state-map
  (kbd "C-l")
  (lambda ()
    (interactive)
    (tmux-navigate "right")))

(provide 'navigate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PROJECTILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package projectile
  :ensure t
  :pin melpa
  :defer t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HELM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))

(use-package helm-projectile
  :bind (("C-S-P" . helm-projectile-switch-project)
	 :map evil-normal-state-map
	 ("C-p" . helm-projectile))
  :ensure t
  )

(use-package helm-ag
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPANY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAGIT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package magit
  :ensure t
  )

;; bind vim keys to magit: https://github.com/emacs-evil/evil-magit
(use-package evil-magit
  :ensure t
  )
(require 'evil-magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (c++-mode . lsp)
					;	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration)
	 )
  :commands lsp)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  )
;; if you are helm user
					;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
					;(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
					;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
					;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package neotree
  :ensure t
  :config
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (ffip-project-root))
	  (file-name (buffer-file-name)))
      (if project-dir
	  (progn
	    (neotree-dir project-dir)
	    (neotree-find file-name))
	(message "Could not find git project root."))))

  (evil-leader/set-key
    ;; "n"  'neotree-toggle
    "t"  'neotree-project-dir)

  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
	    (lambda ()
	      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	      (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
	      (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
	      (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
	      (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
	      (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
	      (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)

	      (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
	      (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)
	      (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
	      (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))


(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error"))
  (add-hook 'c++-mode-hook #'lsp)
					;  (add-hook 'c++-mode-hook #'lsp)
					;  (add-hook 'c++-mode-hook #'lsp)
  )

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [f12] 'indent-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEY BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(use-package find-file-in-project :ensure t)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))

;; (unless (display-graphic-p)
;;   (require 'evil-terminal-cursor-changer)
;;   (evil-terminal-cursor-changer-activate) ; or (etcc-on)
;;             )
;; key bindings
(evil-leader/set-key
  "r" 'reload-init-file
  "s" 'save-buffer
  "f" 'indent-buffer
  "ci" 'evilnc-comment-or-uncomment-lines
  "cn" 'company-select-next
  "cp" 'company-select-previous
  "be" 'buffer-menu
  "ps" 'helm-projectile-ag
  "pa" 'helm-projectile-find-file-in-known-projects
  "j" (lambda() (interactive) (join-line -1))
  "l" 'evil-ex-nohighlight
  ;; "h" 'evil-window-left
  ;; "l" 'evil-window-right
  "ee" (lambda() (interactive) (find-file "~/.emacs"))
  "e3" (lambda() (interactive) (find-file "~/.config/i3/config"))
  "ea" (lambda() (interactive) (find-file "~/dotfiles/zsh/aliases.zsh"))
  "ez" (lambda() (interactive) (find-file "~/.zshrc"))
  "en" (lambda() (interactive) (find-file "~/dotfiles/zsh/env.sh"))
  "ef" (lambda() (interactive) (find-file "~/dotfiles/zsh/functions.sh"))
  "ef" (lambda() (interactive) (find-file "~/dotfiles/tmux.conf"))
  )

(define-key evil-normal-state-map (kbd "C-n") #'neotree-project-dir)

(load-theme 'material t)
