(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#1f2430" "#f28779" "#bae67e" "#ffd580" "#73d0ff" "#d4bfff" "#5ccfe6" "#cbccc6"])
 '(custom-enabled-themes (quote (doom-horizon)))
 '(custom-safe-themes
   (quote
    ("5aef652e40fa5f111e78997285f6e4c892112da0c2f919eb663baaa330a8521f" "9f9fc38446c384a4e909b7220d15bf0c152849ef42f5b1b97356448612c77953" "26e07f80888647204145085c4fed78e0e6652901b62a25de2b8372d71de9c0a1" "22a514f7051c7eac7f07112a217772f704531b136f00e2ccfaa2e2a456558d39" "00c5138bb71c95ca37a0fc845656498a8b4ff271ba4e0e0845732d188359d55a" default)))
 '(exwm-floating-border-color "#11131a")
 '(fci-rule-color "#1c1e23")
 '(highlight-tail-colors
   ((("#2e3737" "green" "green")
     . 0)
    (("#253542" "cyan" "blue")
     . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#3d434d" "#ffcc66"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#3d434d" "#bae67e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#3d434d" "#171b24"))
 '(objed-cursor-color "#f28779")
 '(package-selected-packages
   (quote
    (lsp-mode visual-fill-column dired-hide-dotfiles all-the-icons-dired dired-single evil-collection evil helpful doom-themes auto-package-update org-bullets hydra ivy-rich counsel rainbow-delimiters doom-modeline all-the-icons ivy use-package)))
 '(pdf-view-midnight-colors (cons "#cbccc6" "#1f2430"))
 '(rustic-ansi-faces
   ["#1f2430" "#f28779" "#bae67e" "#ffd580" "#73d0ff" "#d4bfff" "#5ccfe6" "#cbccc6"])
 '(vc-annotate-background "#1f2430")
 '(vc-annotate-color-map
   (list
    (cons 20 "#bae67e")
    (cons 40 "#d1e07e")
    (cons 60 "#e8da7f")
    (cons 80 "#ffd580")
    (cons 100 "#ffc573")
    (cons 120 "#ffb666")
    (cons 140 "#ffa759")
    (cons 160 "#f0af90")
    (cons 180 "#e2b7c7")
    (cons 200 "#d4bfff")
    (cons 220 "#deacd2")
    (cons 240 "#e899a5")
    (cons 260 "#f28779")
    (cons 280 "#bb6c63")
    (cons 300 "#84514e")
    (cons 320 "#4d3639")
    (cons 340 "#1c1e23")
    (cons 360 "#1c1e23")))
 '(vc-annotate-very-old-color nil)
 '(which-key-mode t))

;; MELPA Package Support

;; ===================================

;; Enables basic packaging support

; Initialize package sources

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;;===================================
;; Maunaly Defined Packages

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)


(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-horizon t))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.0))


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))


(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


(use-package org
  :config
  (setq org-ellipsis " ⤵"
        org-hide-emphasis-markers t))

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Org/Tasks.org"
	  "~/Org/Habits.org"
	  "~/Org/Birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)))

     ;; Save Org buffers after refiling!
       (advice-add 'org-refile :after 'org-save-all-org-buffers)


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))


(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))
;;==============================================

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))


;;====================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message

(global-visual-line-mode t)         ;; Enable visual mode

(tool-bar-mode -1)                  ;; Disable the toolbar

(scroll-bar-mode -1)                ;; Disable visible scrollbar

(set-fringe-mode 10)                ;; Give some breathing room

(menu-bar-mode -1)                  ;; Disable the menu bar     

(column-number-mode)
(global-display-line-numbers-mode t)

;; Set up the visible bell
(setq visible-bell t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; ===================================
;; User-Defined .emacs ends here

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
