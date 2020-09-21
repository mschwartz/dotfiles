;;; -*- lexical-binding: t -*-
;;; arm-mode.el --- Major mode for editing Advanced RISC Machine source code
;;; Version: 1
;;; Maintainer: Charles Jackson
;;; URL: https://github.com/charje/arm-mode

(defvar arm-mode-hook nil
  "Hook for ARM major mode.")
(defcustom arm-tab-width 4
  "Width of tabs for `arm-mode'.")
(defcustom arm-comment-char "@"
  "Character to denote inline comments.")
(defvar arm-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-;") #'arm-insert-comment)
    map)
  "Keymap for ARM major mode.")
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.arm\\'" . arm-mode))

;;;; font-lock, syntax highlighting
(defconst arm-font-lock-keywords-1
  (eval-when-compile
    (let ((suffixes (regexp-opt '("eq" "ne" "cs" "hs" "cc" "lo" "mi" "pl" "vs" "vc" "hi" "ls" "ge" "lt" "gt" "le" "al" "f32" "f64")))
          (suffix-instrs (regexp-opt '("add" "adc" "qadd" "qdadd" "sub" "sbc" "rsb" "rsc" "qsub" "qdsub" "mul" "mla" 
                                       "smull" "smlal" "smulxy" "smulwy" "smlaxy" "smlawy" "smlalx" "smuad" "smlad" "smlald" "smusd" "smlsd"
                                       "smlsld" "smmul" "smmla" "smmls" "mia" "miaph" "miaxy" "clz" "addsubx" "umull" "umlal" "umaal"
                                       "subaddx" "usad8" "usada8" "mov" "mvn" "movt" "mrs" "msr" "msr" "mra" "mar" "cpy" "tst" "teq" "and" "eor" "orr"
                                       "bic" "cmp" "cmn" "ssat" "ssat" "ssat16" "usat" "usat" "usat16" "pkhbt" "pkhtb" "sxth" "sxtb16" "sxtb"
                                       "uxth" "uxtb16" "uxtb" "sxtah" "sxtab16" "sxtab" "uxtah" "uxtab16" "uxtab" "rev" "rev16" "revsh" "sel"
                                       "b" "bl" "bx" "bxj" "beq" "bne" "bcs" "bhs" "bcc" "blo" "bmi" "bpl" "bvs" "bvc" "bhi" "bls" "bge"
                                       "blt" "bgt" "bfc" "bfi" "sbfx" "ubfx" "ble" "bal" "lsl" "lsr" "asr" "ror" "rrx" "dbg" "sev" "wfe" "wfi"
                                       "yield" "crd" "swi" "nop" "ldr" "ldm" "ldrex" "str" "stm" "strex" "swp" "ldc" "ldc2" "stc" "stc2" "svc"
                                       "d" "pop" "push" "strexd" "swpb" "smc" "subs" "adr")
                                     t))
          (non-suffix-instrs (regexp-opt '("it" "blx" "cb" "tbb" "tbh" "cpsid" "cpsie" "cps" "setend" "clrex" "cdp"
                                           "cdp2" "mrc" "mrc2" "mrrc" "mrrc2" "mcr" "mcr2" "mcrr" "mcrr2" "srs" "rfe"
                                           "bkpt" "dmb" "dsb" "isb")
                                         t))
          (prefixs (regexp-opt '("s" "q" "sh" "u" "uq" "uh")))
          (prefix-instrs (regexp-opt '("add16" "sub16" "add8" "sub8" "sax" "asx") t)))
      (list
       '("^\\s *\\.[[:alpha:]]+" . font-lock-keyword-face) ;.data, .text .global, etc
       '("\\(?:\\b\\|\\_>\\)\\s-+\\.[[:alpha:]]+" . font-lock-type-face) ;data types
       '("^\\([\\s ]*[[:alnum:]]*\\):\\(.*\\)" 1 font-lock-function-name-face) ;labels
       `(,(concat "\\_<v?" suffix-instrs "\\.?" suffixes "?\\_>") . font-lock-keyword-face) ;suffix instrctions
       `(,(concat "\\_<v?" prefixs prefix-instrs "\\.?" suffixes "?\\_>") . font-lock-keyword-face) ;prefix and suffix instructions
       `(,(concat "\\_<v?" non-suffix-instrs "\\_>") . font-lock-keyword-face)))) ;non suffixs instructions
  "Lowest level of syntax highlighting: keywords and labels.")
(defconst arm-font-lock-keywords-2
  (append (list
           '("\\_<\\(r\\|w\\|x\\|s\\|d\\)\\(?:3[0-1]\\|[1-2][0-9]\\|[0-9]\\)\\_>"
             . font-lock-variable-name-face) ;registers
           '("\\_<\\(e?lr\\|pc\\|w?sp\\|cpsr\\|fpsr\\)\\_>" . font-lock-builtin-face) ;special registers
           '("\\_<\\([wx]zr\\)\\_>" . font-lock-constant-face)) ;zero registers
          arm-font-lock-keywords-1)
  "Second level of syntax highlighting: keywords, labels, and registers.")
(defconst arm-font-lock-keywords-3
  (append arm-font-lock-keywords-2
          (list
           '("0x[[:xdigit:]]+\\_>" . font-lock-type-face))) ;hexidecimal
  "Third level of syntax highlighting: keywords, labels, registers, and hexidecimal numbers.")
(defvar arm-font-lock-keywords arm-font-lock-keywords-3
  "Default syntax highlighting: keywords, labels, registers, and hexidecimal numbers.")

;;;; syntax table
(defvar arm-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?: "_" st)
    (modify-syntax-entry ?= "_" st)
    (modify-syntax-entry ?. "." st)
    (modify-syntax-entry ?\' "\"" st)
    ;; comments
    (modify-syntax-entry ?/ ". 14" st)
    (modify-syntax-entry ?* ". 23" st)
    (modify-syntax-entry ?@ "< b" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax tables for `arm-mode'.")

(defun arm-mode-find-indent-level ()
	"Return the absolute ammount that an line of arm assembler should be indented."
	(save-excursion
	  (beginning-of-line)
	  (if (bobp)			       ;check for rule 1
		  0					   ;indent all the way to the left
		(if (looking-at "^\\s *\\(/\\*\\|@\\)") ;check for rule 5
			(save-excursion		;indentation of the next line
			  (forward-line 1)
			  (if (not (looking-at "^$")) ;if  not empty line
				  (current-indentation) ;then keep indentation the same as last 
				(progn
				  (forward-line -2)
				  (current-indentation))))	;then keep it the same as last line)
		  (if (looking-at "^.*:")			;check for rule 4
			  (current-indentation)			;don't mess with it
			(let ((not-indented t)
				  (new-indent 0))		;all for rule 2
			  (save-excursion
				(while not-indented
				  (when (bobp)
					(setq not-indented nil))
				  (forward-line -1)
				  (if (looking-at "^.*:") ;check for rule 2
					  (progn
						(setq not-indented nil)
						(setq new-indent (+ (current-indentation) arm-tab-width)))
					(when (or (looking-at "^.*:\\s-*\\.") ;data label
							  (looking-at "^.[^\\n]")) ;check for rule 3
					  (progn
						(setq not-indented nil) ;exit loop
						(setq new-indent (current-indentation))))))) ;don't mess with it
				new-indent))))))		;indent to the right

(defun arm-indent-line ()
  "Indent current line of ARM code as follows.
Indentation Rules:
1: If we are at the beginning of the buffer, indent to column 0.
2: If the previous line is a non-data label, indent to the right.
3: else indent the same as previous line of code.
4: if line contains a colon (label), insert a tab character
5: (secret) if the line is a comment allign it to the left"
  (interactive)
  (let ((new-indent (arm-mode-find-indent-level)))
	(if (< new-indent 0)
		(setq new-indent 0))
	(indent-line-to new-indent)))

(defun arm-insert-comment ()
  "Insert /*   */ if on an empty line.
Then call `comment-dwim'."
  (interactive)
  (let ((special (and (save-excursion
                        (move-beginning-of-line nil)
                        (looking-at "^\\s-*$"))
                      (not (use-region-p))))) ;empty line
    (when special
	  (insert "/*   */"))
    (comment-dwim nil)
    (when special
      (forward-char))))					;move to middle of /*   */

;; entry function
(define-derived-mode arm-mode prog-mode "ARM Assembler"()
  "Major mode for editing Advanced RISC Machine language files."
  (set (make-local-variable 'font-lock-defaults) '(arm-font-lock-keywords nil t))
  (set (make-local-variable 'indent-line-function) #'arm-indent-line)
  ;; comments
  (setq-local comment-start (concat arm-comment-char " "))
  (setq-local tab-always-indent nil)
  (setq-local comment-end ""))

(provide 'arm-mode)
