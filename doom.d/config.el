;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(server-start)
(require 'org-protocol)

(projectile-add-known-project "~/Dropbox/Notes/org")
(setq projectile-project-search-path '("~/Projects/"))

(map!
  (:map vterm-mode-map
    ;; Easier window movement
    :i "C-h" #'evil-window-left
    :i "C-j" #'evil-window-down
    :i "C-k" #'evil-window-up
    :i "C-l" #'evil-window-right))

(setq org-directory "~/Dropbox/Notes/org/"
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      ;; The standard unicode characters are usually misaligned depending on the
      ;; font. This bugs me. Markdown #-marks for headlines are more elegant.
      org-bullets-bullet-list '("#")
      org-cycle-separator-lines 4
      org-archive-location "~/Dropbox/Notes/org/archive/%s_archive::")

(defvar +org-capture-todo-file "~/Dropbox/Notes/org/inbox.org")

(setq org-capture-templates
  '(("t" "Todo"           entry (file+headline +org-capture-todo-file "Tasks") "* TODO %?\ncaptured on: %U\n%i\n%a" :prepend t :kill-buffer t)
    ("w" "org-protocol"   entry (file+headline +org-capture-todo-file "Links") "* %:link\n\n  Title: %:description\n\n  %?%:initial\n\n  captured at: %U\n" :empty-lines 1)
))

(setq +doom-dashboard-banner-padding '(0 . 0)
      +doom-dashboard-banner-file "default.png"
      +doom-dashboard-banner-dir "~/.doom.d/banners/"
      +doom-dashboard-functions
       '(doom-dashboard-widget-banner
         doom-dashboard-widget-shortmenu))
