;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 14))

(setq doom-theme 'ewal-doom-one)
;; (setq doom-theme 'doom-solarized-light)

(setq light-theme 'doom-solarized-light)

(setq my/light-theme light-theme
      my/dark-theme doom-theme)

(defun my/toggle-dark-theme ()
  (interactive)
  (if (eq my/dark-theme doom-theme)
      (load-theme my/light-theme t)
    (load-theme doom-theme t)))

(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "Dark theme" "d" #'my/toggle-dark-theme))

(load-theme doom-theme t)

(setq +doom-dashboard-banner-padding '(0 . 0)
      +doom-dashboard-banner-file "default.png"
      +doom-dashboard-banner-dir "~/.doom.d/banners/"
      +doom-dashboard-functions
       '(doom-dashboard-widget-banner
         doom-dashboard-widget-shortmenu))

(setq user-full-name    "Russell Smith"
      user-mail-address "russ@bashme.org")

(global-auto-revert-mode t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2 indent-tabs-mode nil)
(setq backup-by-copying t) ; Stop shinanigans with links
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(setq +workspaces-on-switch-project-behavior t)

(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2)
(global-company-mode t)

(setq deft-directory "~/Dropbox/Notes/org")
(setq deft-current-sort-method 'title)

(setq org-directory "~/Dropbox/Notes/org/"
      org-capture-todo-file "inbox.org"
      org-agenda-files (ignore-errors (directory-files "~/Dropbox/Notes/org/" t "\\.org$" t))
      org-agenda-skip-scheduled-if-done t
      org-tags-column -80
      org-archive-location "~/Dropbox/Notes/org/archive/%s_archive::")

(after! org
  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))

  (after! org (setq org-agenda-dim-blocked-tasks t
                    org-agenda-use-time-grid t
                    org-agenda-hide-tags-regexp ":\\w+:"
                    org-agenda-compact-blocks t
                    org-agenda-block-separator nil
                    org-agenda-skip-scheduled-if-done t
                    org-agenda-skip-deadline-if-done t
                    org-enforce-todo-checkbox-dependencies nil
                    org-habit-show-habits t))

  (setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))))

(load-library "find-lisp")
(after! org (setq org-agenda-files
                  (find-lisp-find-files "~/Dropbox/Notes/org/" "\.org$")))

(add-hook 'org-mode-hook (lambda ()
  (display-line-numbers-mode -1)
  (hide-mode-line-mode -1)
))

(require 'rubocopfmt)
(add-hook 'ruby-mode-hook #'rubocopfmt-mode)
(use-package rubocopfmt
  :hook
  (enh-ruby-mode . rubocopfmt-mode))

(map! :leader :desc "Org-Roam-Today" "m m t" #'org-roam-today)
;; (use-package company-org-roam
;;   :when (featurep! :completion company)
;;   :after org-roam
;;   :config
;;   (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

(use-package! lsp-tailwindcss)

(add-hook 'vue-mode-hook #'lsp!)
(setq-hook! 'web-mode-hook +format-with 'prettier-prettify)

;; Trying to fix indentation in the different blocks
;; https://github.com/AdamNiederer/vue-mode/issues/100#issuecomment-571819507
(setq mmm-js-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
(setq mmm-typescript-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))

;; Disables the coloring behind the different blocks in single file components
(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

;; (require 'eglot)
;; (require 'web-mode)
;; (define-derived-mode genehack-vue-mode web-mode "ghVue"
;;   "A major mode derived from web-mode, for editing .vue files with LSP support.")
;; (add-to-list 'auto-mode-alist '("\\.vue\\'" . genehack-vue-mode))
;; (add-hook 'genehack-vue-mode-hook #'eglot-ensure)
;; (add-to-list 'eglot-server-programs '(genehack-vue-mode "/home/russ/.asdf/shims/vls"))

(setq +magit-hub-features t)

(projectile-add-known-project "~/Dropbox/Notes/org")
(setq projectile-project-search-path '("~/Projects/"))
(setq projectile-globally-ignored-file-suffixes '("#" "~" ".swp" ".o" ".so" ".exe" ".dll" ".elc" ".pyc" ".jar" "*.class"))
(setq projectile-globally-ignored-directories '(".git" "node_modules" "__pycache__" ".vs"))
(setq projectile-globally-ignored-files '(".DS_Store"))

(defun my/create-org-frame ()
  "Create a new frame running org."
  (select-frame
   (make-frame '((name . "Org"))))
  (my-new-daily-review))

(defun my-new-daily-review ()
  "Create Org file from skeleton file with current time as name."
  (interactive)
  (let ((template (concat "~/Dropbox/Notes/org/templates/daily-review.org"))
	(filename (format-time-string "~/Dropbox/Notes/org/%Y-%m-%d.org")))
    (if (file-exists-p filename)
      (find-file filename)
      (and (copy-file template filename)
           (find-file filename)))))
