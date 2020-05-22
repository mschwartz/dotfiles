;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq make-backup-files nil)
(setq evil-want-C-u-scroll t)
(xterm-mouse-mode)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" default)))
 '(package-selected-packages
   (quote
    (navigator paper-theme ewal-spacemacs-themes spacemacs-theme spacemacs-dark-theme spacemacs-dark helm-ag gruvbox which-key evil-nerd-commenter company-lsp lsp-ui lsp-mode gruvbox-theme evil-leader neotree use-package evil))))
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
  (global-evil-surround-mode))

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
  :pin melpa-stable
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

(use-package find-file-in-project :ensure t)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEY BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (unless (display-graphic-p)
;;   (require 'evil-terminal-cursor-changer)
;;   (evil-terminal-cursor-changer-activate) ; or (etcc-on)
;;             )
;; key bindings
(evil-leader/set-key
  "s" 'save-buffer
  "ci" 'evilnc-comment-or-uncomment-lines
  "cn" 'company-select-next
  "cp" 'company-select-previous
  "be" 'buffer-menu
  "ps" 'helm-projectile-ag
  "pa" 'helm-projectile-find-file-in-known-projects
  "h" 'evil-window-left
  "l" 'evil-window-right
  )

(define-key evil-normal-state-map (kbd "C-n") #'neotree-toggle)

;; (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
;; (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
;; (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
;; (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

;; (define-key evil-normal-state-map (kbd "C-h") #'windmove-left)
;; (define-key evil-normal-state-map (kbd "C-j") #'windmove-down)
;; (define-key evil-normal-state-map (kbd "C-k") #'windmove-up)
;; (define-key evil-normal-state-map (kbd "C-l") #'windmove-right)

;; (use-package dracula-theme
;;   :ensure t
;;   :load-path "themes"
;;   :init
;;   (setq dracula-theme-kit t)
;;   :config(load-theme 'dracula t)
;;   )


;; (use-package spacemacs-theme
;;   :ensure t
;;   :load-path "themes"
;;   :init
;;   :config
;;   (load-theme 'spacemacs-theme t)
;;   )
;; (load-theme 'spacemacs-theme t)
;; (load-theme 'paper-theme t)
(load-theme 'material t)
