(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (require 'use-package))

;; Replace M-x with C-x C-m
(global-set-key "\C-x\C-m" 'execute-extended-command)

(defun er-switch-to-previous-buffer ()
"Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; https://github.com/emacs-evil/evil-collection/issues/60
(setq evil-want-keybinding nil)
(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "<SPC>" #'er-switch-to-previous-buffer))

;; Vim bindings
(use-package evil
  :ensure t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-C-u-scroll t)
   (when evil-want-C-u-scroll
    (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up))
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; Vim bindings everywhere else
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-default-dark t))

(use-package powerline
  :ensure t
  :init
  (powerline-default-theme))

(use-package smartparens
  :ensure t
  :config
  (progn
     (require 'smartparens-config)
     (smartparens-global-mode 1)
     (show-paren-mode t)))

(use-package company
  ;; Navigate in completion minibuffer with `C-n` and `C-p`.
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  ;; Provide instant autocompletion.
  (setq company-idle-delay 0.3)
  ;; Use company mode everywhere.
  (global-company-mode t))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode 1))

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode t))

;; Enhance M-x to allow easier execution of commands
(use-package smex
  :init
  (smex-initialize)
  :config
  (global-set-key (kbd "\C-x\C-m") 'smex)
  (global-set-key (kbd "\C-x\C-M") 'smex-major-mode-commands))

;; 'y'/'n' instead of 'yes'/'no'.
(defalias 'yes-or-no-p 'y-or-n-p)

;; default to utf-8
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8
  coding-system-for-read 'utf-8
  coding-system-for-write 'utf-8)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Don't show the splash-screen
(setq inhibit-startup-message t)

;; Disable the beep sound
(setq ring-bell-function 'ignore)

;; Hide the menu-bar, tool-bar and scroll-bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display relative line numbers in every buffer
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

;; Default to an indentation size of 4 spaces
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)

;; vnoremap < <gv
(define-key evil-visual-state-map "<" (lambda ()
  (interactive)
  ; ensure mark is less than point
  (when (> (mark) (point))
    (exchange-point-and-mark)
  )
  (evil-normal-state)
  (evil-shift-left (mark) (point))
  (evil-visual-restore) ; re-select last visual-mode selection
))

;; vnoremap > >gv
(define-key evil-visual-state-map ">" (lambda ()
  (interactive)
  ; ensure mark is less than point
  (when (> (mark) (point))
    (exchange-point-and-mark)
  )
  (evil-normal-state)
  (evil-shift-right (mark) (point))
  (evil-visual-restore) ; re-select last visual-mode selection
))

(if (eq system-type 'darwin)
  (setq mac-option-modifier 'none))