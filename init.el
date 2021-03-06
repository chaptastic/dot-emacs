(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)

;; Disable toolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :init
    (exec-path-from-shell-initialize)))

(use-package try
  :defer 2)

(use-package which-key
  :diminish which-key-mode
  :defer 2
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode))

;; THEMES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;; (use-package zenburn-theme
;;   :config
;;   (load-theme 'zenburn t))

;; (use-package leuven-theme
;;   :config
;;   (load-theme 'leuven t))

;; (use-package color-theme-modern
;;   :config
;;   (load-theme 'cobalt t))

(use-package color-theme-sanityinc-tomorrow
  :config
  (load-theme 'sanityinc-tomorrow-blue t))

;; (use-package sexy-monochrome-theme
;;   :config
;;   (load-theme 'sexy-monochrome t)
;;   (setq show-paren-style 'expression))

;; (use-package borland-blue-theme
;;   :config
;;   (load-theme 'borland-blue t))

;; (use-package atom-one-dark-theme
;;   :config
;;   (load-theme 'atom-one-dark t))

;; (use-package green-phosphor-theme
;;   :config
;;   (load-theme 'green-phosphor t))

;; (use-package material-theme
;;   :config
;;   (load-theme 'material t))

;; END THEMES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :config
  (magit-file-mode t))

(use-package ag
  :config
  (setq ag-highlight-search t))

(use-package projectile
  :defer nil
  :config
  (projectile-global-mode)
  ;; (defun maybe-projectile-find-file (arg)
  ;;   "Find a file with projectile-find-file unless an argument is specified"
  ;;   (interactive "p")
  ;;   (if (> arg 1)
  ;; 	(counsel-find-file)
  ;;     (projectile-find-file)))
  ;; (define-key projectile-mode-map (kbd "C-x C-f") 'maybe-projectile-find-file)
  )

(use-package perspective
  :config
  (persp-mode)
  (face-spec-set 'persp-selected-face
		 '((t (:inherit mode-line-buffer-id))))
)

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
	 ("C-x i" . counsel-imenu)
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

(use-package counsel-projectile)

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

(use-package crux
  :bind (("C-S-<return>" . crux-smart-open-line-above)
	 ("C-<return>" . crux-smart-open-line)
	 ("M-o" . crux-smart-open-line)
	 ("C-x 4 t" . crux-transpose-windows)
	 ("C-c D" . crux-delete-file-and-buffer)
	 ("C-c d" . crux-duplicate-current-line-or-region)
	 ("C-c C-r" . crux-rename-file-and-buffer)
	 ("C-^" . crux-top-join-lines)
	 ("C-a" . crux-move-beginning-of-line))
  :defer nil
  :config
  (crux-with-region-or-buffer indent-region)
  (crux-with-region-or-line comment-or-uncomment-region)
  (crux-with-region-or-line kill-ring-save))

(use-package undo-tree
  :config
  (global-undo-tree-mode t))

(use-package org)

(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

  (setq web-mode-comment-style 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  (face-spec-set 'web-mode-current-element-highlight-face
		 '((t (:underline t))))
  )

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
    '(push '(company-robe company-capf company-dabbrev-code company-etags company-keywords) company-backends)))

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
  (add-hook 'find-file-hook 'projectile-rails-on))

(use-package rbenv
  :init
  (setq rbenv-show-active-ruby-in-modeline nil)
  :config
  (global-rbenv-mode))

(use-package rspec-mode
  :config
  (defun rspec-spring-p ()
    t))

(use-package fsharp-mode
  :config
  (setq fsharp-compiler "/usr/local/bin/fsharpc")
  (setq inferior-fsharp-program "/usr/local/bin/fsharpi"))

(use-package tide
  :config
  (add-hook 'before-save-hook 'tide-format-before-save)
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (company-mode +1)))

(eval-after-load 'web-mode
  '(progn
     (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
     (add-hook 'web-mode-hook
	       (lambda ()
		 (let ((ext (file-name-extension buffer-file-name)))
		   (cond ((string-equal "erb" ext)
			  (setq indent-tabs-mode nil)
			  (setq web-mode-markup-indent-offset 2)
			  (setq tab-width 2))
			 ((string-equal "tsx" ext)
			  (setup-tide-mode))
			 ))))))

;; (use-package auctex
;;   :no-require t)
;; (use-package company-auctex)

(show-paren-mode 1)

(global-whitespace-mode 1)
(setq whitespace-style '(face trailing empty space-before-tab))

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

(setq vc-follow-symlinks t)
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq default-fill-column 80)
(setq electric-pair-mode t)
(setq electric-pair-text-pairs '((34 . 34) (40 . 41) (91 . 93) (123 . 125)))

(global-set-key (kbd "M-;") 'comment-line)

(winner-mode t)
(windmove-default-keybindings)

;; Remove trailing whitespace
(add-hook 'prog-mode-hook
	  (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; Don't convert to windows line endings
(setq inhibit-eol-conversion t)
(setq default-buffer-file-coding-system 'utf-8-unix)

;; Fix ruby indent
(setq ruby-deep-indent-paren nil)
(setq ruby-align-to-stmt-keywords nil)
(setq ruby-align-chained-calls t)

;; Save customizations to custom.el in the init dir
(setq custom-file (locate-user-emacs-file (concat "custom-" system-name ".el")))
(load custom-file)
