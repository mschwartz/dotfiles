;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (when (fboundp 'set-fontset-font)
;;   (setq user-emacs-directory "/Users/mschwartz/.cache/user-emacs-directory/")
;;   )

;; (unless (fboundp 'set-fontset-font)
;;   (setq user-emacs-directory "/home/mschwartz/.cache/user-emacs-directory/")
;;   )

(setq warning-minimum-level :emergency)
(add-to-list 'load-path "~/.emacs.d/lisp")

(desktop-save-mode 1)
(save-place-mode 1)
					;(require 'joseph-dired-single)
;; (diredp-toggle-find-file-reuse-dir 1)
;; (require 'dired-single)
;; (autoload 'dired-single-buffer "dired-single" "" t)
;; (autoload 'dired-single-buffer-mouse "dired-single" "" t)
;; (autoload 'dired-single-magic-buffer "dired-single" "" t)
;; (autoload 'dired-single-toggle-buffer-name "dired-single" "" t)
					;(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up the package and use-package methods and URLs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

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

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

(setq use-package-ensure-function 'quelpa)

(package-install 'flycheck)

(global-flycheck-mode)

(use-package find-file-in-project
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up the mode line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dired-subtree
  :ensure t)


(load-library "font-lock+")

(require 'font-lock)
(require 'font-lock+)
;; (use-package all-the-icons)
;; (use-package all-the-icons-dired
;;   :hook (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook (lambda () (require 'all-the-icons)))
  :config
  (setq all-the-icons-scale-factor 1.0))

(use-package all-the-icons-dired
  :ensure t
  :config
  :hook (dired-mode . (lambda ()
			(interactive)
			(unless (file-remote-p default-directory)
			  (all-the-icons-dired-mode)))))

(use-package all-the-icons-dired
  :after ranger
  :init
  (add-hook 'ranger-mode-hook 'all-the-icons-dired-mode)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package all-the-icons-ivy
  :after (ivy all-the-icons)
  :defer t
  :init
  (add-hook 'counsel-projectile-mode-hook 'all-the-icons-ivy-setup)
  (add-hook 'ivy-mode-hook 'all-the-icons-ivy-setup)
  :config
  (progn
    (defun all-the-icons-ivy-file-transformer (s)
      "Return a candidate string for filename S preceded by an icon."
      (format "%s %s"
	      (propertize "\t" 'display (all-the-icons-ivy-icon-for-file s))
	      s))
    (defun all-the-icons-ivy--buffer-transformer (b s)
      "Return a candidate string for buffer B named S preceded by an icon.
 Try to find the icon for the buffer's B `major-mode'.
 If that fails look for an icon for the mode that the `major-mode' is derived from."
      (let ((mode (buffer-local-value 'major-mode b)))
	(format "%s %s"
		(propertize "\t" 'display (or
					   (all-the-icons-ivy--icon-for-mode mode)
					   (all-the-icons-ivy--icon-for-mode (get mode 'derived-mode-parent))))
		(all-the-icons-ivy--buffer-propertize b s))))
    (all-the-icons-ivy-setup)))

(use-package telephone-line
  :ensure t)
					;(require 'telephone-line)
(setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
	(accent . (telephone-line-vc-segment
		   telephone-line-erc-modified-channels-segment
		   telephone-line-process-segment))
	(nil    . (
		   telephone-line-buffer-segment))))
(telephone-line-mode 1)
;; (setq telephone-line-lhs
;;       '((evil   . (telephone-line-evil-tag-segment))
;;         (accent . (telephone-line-vc-segment
;;                    telephone-line-erc-modified-channels-segment
;;                    telephone-line-process-segment))
;;         (nil    . (telephone-line-minor-mode-segment
;;                    telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))
(telephone-line-mode 1)
					;use-package doom-modeline
					;  :ensure t
					;:init (doom-modeline-mode 1))

;; (use-package smart-mode-line
;;   :ensure t)

;; (use-package smart-mode-line-powerline-theme
;;   :ensure t)

;; (setq sml/no-confirm-load-theme t)
;; ;; (setq sml/theme 'powerline)
;; (setq sml/theme 'light)
;; (sml/setup)


(add-to-list 'load-path "~/.local/share/icons-in-terminal/")
(require 'icons-in-terminal)
(insert (icons-in-terminal 'oct_flame)) ; C-h f icons-in-terminal[RET] for more info

(when (fboundp 'set-fontset-font)
  (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up the themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e"
     "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279"
     "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a"
     default))
 '(display-line-numbers-type 'visual t)
 '(package-selected-packages nil))
'()
 '(package-selected-packages nil)
 '()
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 143 :width normal)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-mode :ensure t)
;; (use-package lsp-treemacs :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dart
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dart-mode
  :ensure t
  )
(use-package lsp-dart
  :ensure t
  ;; :config
  ;; (setq lsp-dart-server-command "/opt/flutter/bin/dart /opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot")
  :hook (dart-mode . lsp))

(add-hook 'dart-mode 'lsp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up nasm mode for nasm source file extension
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package nasm-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.nasm\\'" . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.asm\\'" . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . nasm-mode))
(add-hook 'nasm-mode-hook (lambda()
			    (setq intent-tabs-mode nil)
			    (setq tab-width 16)
			    ;; (setq tab-stop-list (number-sequence 2 60 2))
			    ))

;; (defun my-asm-mode-hook ()
;;   ;; you can use `comment-dwim' (M-;) for this kind of behaviour anyway
;;   (local-unset-key (vector asm-comment-char))
;;   ;; (local-unset-key "<return>") ; doesn't work. "RET" in a terminal.  http://emacs.stackexchange.com/questions/13286/how-can-i-stop-the-enter-key-from-triggering-a-completion-in-company-mode
;;   (electric-indent-local-mode)  ; toggle off
;; 					;  (setq tab-width 4)
;;   (setq indent-tabs-mode nil)
;;   ;; asm-mode sets it locally to nil, to "stay closer to the old TAB behaviour".
;;   ;; (setq tab-always-indent (default-value 'tab-always-indent))

;;   (defun asm-calculate-indentation ()
;;     (or
;;      ;; Flush labels to the left margin.
;; 					;   (and (looking-at "\\(\\.\\|\\sw\\|\\s_\\)+:") 0)
;;      (and (looking-at "[.@_[:word:]]+:") 0)
;;      ;; Same thing for `;;;' comments.
;;      (and (looking-at "\\s<\\s<\\s<") 0)
;;      ;; %if nasm macro stuff goes to the left margin
;;      (and (looking-at "%") 0)
;;      (and (looking-at "c?global\\|section\\|default\\|align\\|INIT_..X") 0)
;;      ;; Simple `;' comments go to the comment-column
;; 					;(and (looking-at "\\s<\\(\\S<\\|\\'\\)") comment-column)
;;      ;; The rest goes at column 4
;;      (or 4)))
;;   )

;; (add-hook 'asm-mode-hook #'my-asm-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up arm asm mode for nasm source file extension
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

					;(add-to-list 'load-path "~/.emacs.d/elpa/arm-mode")
					;(require 'arm-mode)
					;(use-package arm-mode
					;   :ensure t)
					;(add-to-list 'load-path "~/.emacs.d/elpa/arm-mode")
(require 'arm-mode)
;; (add-to-list 'auto-mode-alist '("\\.S\\'" . arm-mode))
;; (add-to-list 'auto-mode-alist '("\\.s\\'" . arm-mode))
;; (add-to-list 'auto-mode-alist '("\\.H\\'" . arm-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up JavaScript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package web-mode
;;   :ensure t
;;   )
;; (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(use-package format-all
  :ensure t
  )
(use-package rjsx-mode
  :ensure t)

;; (add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . rjsx--mode))
(setq js-indent-level 2)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up Forth
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package forth-mode
  :ensure t)
(autoload 'forth-mode "gforth.el")
;; (autoload 'forth-block-mode "gforth.el")
(add-to-list 'auto-mode-alist '("\\.fth$" . forth-mode))
(add-to-list 'auto-mode-alist '("\\.f$" . forth-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up TypeScript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package tide
  :ensure t
  )

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq typescript-indent-level 2)

(use-package typescript-mode
  :mode "\\.tsx?$"
  :hook
  (typescript-mode . lsp)
  :custom
  (typescript-indent-level 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up C/C++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq c-basic-offset 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up Rust
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode
  :ensure t
  :config
  (setq tab-width 4)
  (setq indent-level 4)
  (setq rust-indent-offset 4)
  )

;; (setq-default tab-width 2)
(setq indent-tab-mode nil)
;; (setq rust-format-on-save t)
(add-hook 'rust-mode-hook (lambda() (setq indent-tabs-mode nil)))
(add-hook 'rust-mode-hook (lambda() (setq tab-width 2)))
(add-hook 'rustic-mode-hook
          (lambda() (setq tab-width 2)))

;; --debug-init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EVIL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-nerd-commenter
  :ensure t)

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
;; YAML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-yaml
  :ensure t
  )

(use-package yaml-mode
  :ensure t
  )
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (c++-mode . lsp)
	 (rust-mode . lsp)
	 (rustic-mode . lsp)
	 (js2-mode .  'lsp)
	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration)
	 )
  :commands lsp)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  )

(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'ccls) (lsp))))

(setq ccls-executable "/usr/bin/ccls")


;; (use-package lsp-mode
;;   :ensure t
;;   :config
;;   (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error"))
;;   (add-hook 'c++-mode-hook #'lsp)
;; 					;  (add-hook 'c++-mode-hook #'lsp)
;; 					;  (add-hook 'c++-mode-hook #'lsp)
;;   )

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up neotree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


(setq neo-theme (if (display-graphic-p) 'icons 'icons))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dired+
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEY BINDING METHODS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

					; F12 does m-x
(global-set-key [f12] 'execute-extended-command)
(global-set-key [f12] 'execute-extended-command)
					;(defun indent-buffer ()
					;  (interactive)
					;  (save-excursion
					;    (indent-region (point-min) (point-max) nil)))

					;(use-package find-file-in-project :ensure t)
(defun indent-buffer
    (format-all-buffer))
					;(use-package find-file-in-project :ensure t)
(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))

;; (unless (display-graphic-p)
;;   (require 'evil-terminal-cursor-changer)
;;   (evil-terminal-cursor-changer-activate) ; or (etcc-on)
;;             )
;; key bindings
;; (global-set-key [(control x) (k)] 'kill-this-buffer)

;; (defun volatile-kill-buffer ()
;;   "Kill current buffer unconditionally."
;;   (interactive)
;;   (let ((buffer-modified-p nil))
;;     (kill-buffer (current-buffer))))
;; (defun volatile-kill-buffer ()
;;   "Kill current buffer unconditionally."
;;   (interactive)
;;   (let ((buffer-modified-p nil))
;;     (kill-this-buffer)))

(defun kill-this-buffer-volatile ()
  "Kill current buffer, even if it has been modified."
  (interactive)
  (set-buffer-modified-p nil)
  (kill-this-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEY BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(evil-leader/set-key
  "r" 'reload-init-file
  "s" 'save-buffer
					;  "f" 'indent-buffer
  "f" 'format-all-buffer
  "bd" 'kill-this-buffer-volatile
  "be" 'buffer-menu
  "ci" 'evilnc-comment-or-uncomment-lines
  "cn" 'company-select-next
  "cp" 'company-select-previous
  "ps" 'helm-projectile-ag
  "pa" 'helm-projectile-find-file-in-known-projects
  "h" 'ff-find-related-file
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
  "et" (lambda() (interactive) (find-file "~/dotfiles/tmux.conf"))
  )

(define-key evil-normal-state-map (kbd "C-n") #'neotree-project-dir)
(define-key evil-normal-state-map (kbd "M-x") 'execute-extended-command)


(use-package material-theme
  :ensure t)
(load-theme 'material t)
;; (server-start)

;; (setq backup-directory-alist
;;       `(("." . ,(concat user-emacs-directory "backups"))))

(setq make-backup-files nil) ; stop creating those backup~ files
(setq create-lockfiles nil)



;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

(setq sgml-xml-mode t)

(global-set-key [f1] nil)
(global-set-key [f2] nil)
