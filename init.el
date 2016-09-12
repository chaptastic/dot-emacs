(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)

;; Disable toolbar
(tool-bar-mode -1)

(setq inhibit-splash-screen t)

;; (unless package-archive-contents (package-refresh-contents))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Always install packages if needed
(setq use-package-always-ensure t)

(use-package try
  :defer 2)

(use-package which-key
  :diminish which-key-mode
  :defer 2
  :config
  (which-key-mode))

;; (use-package zenburn-theme
;; ;;   :config
;; ;;   (load-theme 'zenburn t)
;;   )

(use-package leuven-theme
  ;; :config
  ;; (load-theme 'leuven t)
  )

(use-package color-theme-sanityinc-tomorrow
  :config
  (load-theme 'sanityinc-tomorrow-day t)
  )

(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :config
  (magit-file-mode t))

(use-package ag
  :config
  (setq ag-highlight-search t))

(use-package projectile
  :config
  (projectile-mode))

(use-package perspective
  :config
  (persp-mode))

(use-package persp-projectile)

;; (use-package nlinum
;;   :config
;;   (nlinum-mode))

(use-package smex)

(use-package ivy
  :diminish ivy-mode)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-h f" . counsel-describe-function)
	 ("C-h v" . counsel-describe-variable)
	 ("C-h l" . counsel-load-library)
	 ("C-h i" . counsel-info-lookup-symbol)
	 ("C-h u" . counsel-unicode-char)
	 ("C-c g" . counsel-git)
	 ("C-c k" . counsel-ag))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (setq projectile-completion-system 'ivy)
    (setq magit-completing-read-function 'ivy-completing-read)))

(use-package swiper
  :bind (("C-s" . swiper)))

(use-package avy
  :commands (avy-goto-char avy-goto-line avy-goto-word-1)
  :bind (("C-:" . avy-goto-char)
	 ("M-g f" . avy-goto-line)
	 ("M-g w" . avy-goto-word-1)))

(use-package expand-region
  :commands (er/expand-region)
  :bind (("C-=" . er/expand-region)))

(use-package multiple-cursors
  :commands (mc/mark-more-like-this-symbol
	     mc/mark-previous-like-this-symbol
	     mc/mark-all-like-this
	     mc/edit-line
	     mc/edit-beginnings-of-lines
	     mc/edit-ends-of-lines
	     mc/add-cursor-on-click)
  :bind (("C->" . mc/mark-next-like-this-symbol)
	 ("C-<" . mc/mark-previous-like-this-symbol)
	 ("C-c C-<" . mc/mark-all-like-this)
	 ("C-S-c C-S-c" . mc/edit-lines)
	 ("C-S-c C-S-a" . mc/edit-beginnings-of-lines)
	 ("C-S-c C-S-e" . mc/edit-ends-of-lines)
	 ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

(use-package wgrep)

(use-package git-gutter
  :bind (("C-x v =" . git-gutter:popup-hunk)
	 ("C-x n" . git-gutter:next-hunk)
	 ("C-x p" . git-gutter:previous-hunk)
	 ("C-x v s" . git-gutter:stage-hunk)
	 ("C-x v r" . git-gutter:revert-hunk))
  :config
  (global-git-gutter-mode t))

(use-package org)
(use-package web-mode)
(use-package yaml-mode)
(use-package sass-mode)
(use-package scss-mode
  :config
  (setq scss-compile-at-save nil))
(use-package coffee-mode)

(use-package inf-ruby)
(use-package robe
  :config
  (add-hook 'ruby-mode-hook 'robe-mode)
  (eval-after-load 'company
    '(push 'company-robe company-backends)))

(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flymake-easy)

(use-package flymake-ruby
  :commands (flymake-ruby-load)
  :init
  (add-hook 'ruby-mode-hook 'flymake-ruby-load))

(use-package flymake-css
  :commands (flymake-css-load)
  :init
  (add-hook 'css-mode-hook 'flymake-css-load))

(use-package flymake-sass
  :commands (flymake-sass-load)
  :init
  (add-hook 'sass-mode-hook 'flymake-sass-load))

(use-package flymake-coffee
  :commands (flymake-coffee-load)
  :init
  (add-hook 'coffee-mode-hook 'flymake-coffee-load))

(use-package projectile-rails
  :config
  (add-hook 'projectile-mode-hook 'projectile-rails-mode))

(use-package fsharp-mode
  :config
  (setq fsharp-compiler "/usr/local/bin/fsharpc")
  (setq inferior-fsharp-program "/usr/local/bin/fsharpi"))

(show-paren-mode 1)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

(setq vc-follow-symlinks t)
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq default-fill-column 80)
(setq electric-pair-mode t)
(setq electric-pair-text-pairs '((34 . 34) (40 . 41) (91 . 93) (123 . 125)))


;; Save customizations to custom.el in the init dir
(setq custom-file (f-join (f-dirname user-init-file) (concat "custom-" system-name ".el")))
(load custom-file)
