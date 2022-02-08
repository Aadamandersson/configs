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

;; Display column numbers
(column-number-mode)

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
  (evil-leader/set-leader "<SPC>"))

;; Vim bindings
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (when evil-want-C-u-scroll
    (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up))
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (evil-collection-init))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-default-dark t))

(use-package diminish
  :ensure t
  :diminish eldoc-mode)

(use-package magit
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
     (require 'smartparens-config)
     (smartparens-global-mode 1)
     (show-paren-mode t)))

(use-package company
  :ensure t
  :diminish company-mode
  ; Navigate in completion minibuffer with `C-n` and `C-p`
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode t))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package autorevert
  :diminish auto-revert-mode
  :init
  (global-auto-revert-mode))



(if (eq system-type 'darwin)
    (setq mac-command-modifier 'meta
	  mac-option-modifier 'none))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)
