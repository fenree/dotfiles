;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
; org presentations
;(package! catppuccin-theme)
(package! org-present)

(package! visual-fill-column)

(defun my/org-present-start ()
  (setq visual-fill-column-width 110)
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
  (visual-line-fill-column-mode 1)
  (setq header-line-format " ")
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                   (header-line (:height 4.0) variable-pitch)
                                   (org-document-title (:height 1.75) org-document-title)
                                   (org-code (:height 1.55) org-code)
                                   (org-verbatim (:height 1.55) org-verbatim)
                                   (org-block (:height 1.25) org-block)
                                   (org-block-begin-line (:height 0.7) org-block))))

(defun my/org-present-end ()
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (visual-line-fill-column-mode 0)
  (setq header-line-format nil)
  (setq-local face-remapping-alist '((default variable-pitch default)))
)

(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)



;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)
