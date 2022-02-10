(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (require 'use-package))

(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; 'y'/'n' instead of 'yes'/'no'.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Don't show the splash-screen or startup message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Disable the beep sound
(setq ring-bell-function 'ignore)

;; Hide the menu, tool and scroll-bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(blink-cursor-mode -1)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
		prog-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Display relative line numbers
(setq display-line-numbers-type 'relative)

;; Default to an indentation size of 4 spaces
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

;; https://github.com/emacs-evil/evil-collection/issues/60
(setq evil-want-keybinding nil)
(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "<SPC>" #'evil-jump-backward)
  (evil-leader/set-key "rn" #'lsp-rename)
  (evil-leader/set-key "a" #'lsp-execute-code-action))

;; Vim bindingse
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-fu)
  (when evil-want-C-u-scroll
    (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up))
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-default-dark t))

(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-buffer-file-name-style 'truncate-except-project
        doom-modeline-bar-width 8)
  (custom-set-faces '(mode-line ((t (:height 0.9))))
                    '(mode-line-inactive ((t (:height 0.9)))))
  (doom-modeline-mode 1))

(use-package magit
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode))

(use-package smartparens
  :ensure t
  :config
  (progn
     (require 'smartparens-config)
     (smartparens-global-mode 1)
     (show-paren-mode t)))

(use-package company
  :ensure t
  ; Navigate in completion minibuffer with `C-n` and `C-p`
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode t))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :bind-keymap ("C-c l" . lsp-command-map)
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (lsp-enable-which-key-integration)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover nil))


;;; Rust
(use-package rustic
  :ensure t
  :init
  (setq rustic-format-on-save t))

(use-package undo-fu
  :ensure t
  :config
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))


(if (eq system-type 'darwin)
    (setq mac-command-modifier 'meta
	  mac-option-modifier 'none))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)
