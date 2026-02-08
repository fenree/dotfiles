;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
                                        ;(setenv "PLANTUML_INCLUDE_PATH" (expand-file-name "~/.plantuml"))
(setq doom-font (font-spec :family "IosevkaNerdFontMono" :size 24)
                                        ;(set-face-attribute 'default nil :font "IosevkaNerdFontMono" :weight 'light :height 240)
                                        ;(set-face-attribute 'fixed-pitch nil :font "IosevkaNerdFontMono" :weight 'light :height 260)
                                        ;(set-face-attribute 'variable-pitch nil :font "IosevkaNerdFont" :weight 'light :height 1.6)
      ;;
      ;; See 'C-h v doom-font' for documentation and more examples of what they
      ;; accept. For example:
      ;;
      ;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
      ;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
      ;; refresh your font settings. If Emacs still can't find your font, it likely
      ;; wasn't installed correctly. Font issues are rarely Doom issues!

      ;; There are two ways to load a theme. Both assume the theme is installed and
      ;; available. You can either set `doom-theme' or manually load a theme with the
      ;; `load-theme' function. This is the default:
                                        ;(setq doom-theme 'catppuccin)
                                        ;(setq catppuccin-flavor 'mocha)
                                        ;(load-theme 'catppuccin t t)

      ;; This determines the style of line numbers in effect. If set to `nil', line
      ;; numbers are disabled. For relative line numbers, set this to `relative'.
      display-line-numbers-type 'relative)

(setq org-directory "~/org/")
(after! org
  (setq
   org-export-with-toc nil
   org-export-with-drawers nil
   org-export-with-properties nil
   org-export-with-todo-keywords nil
   org-export-with-tags nil
   org-export-with-priority nil
   org-export-with-timestamps nil
   org-export-with-section-numbers nil
   org-export-with-sub-superscripts nil
   org-html-postamble nil))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;navigation, windows and tabs


;; splits
(map! :n "SPC C--" #'(lambda () (interactive) (split-window-vertically) (windmove-down)))
(map! :n "SPC -" #'(lambda () (interactive) (split-window-horizontally) (windmove-right)))

(defmacro tmux-nav (direction)
  (pcase-let* ((dir-str (symbol-name direction))
               (fname (intern (concat "tmux-nav-" dir-str)))
               (windmove (intern (concat "windmove-" dir-str)))
               (`(,key ,tmux-flag)
                (pcase direction
                  ('left  '("h" "L"))
                  ('right '("l" "R"))
                  ('up    '("k" "U"))
                  ('down  '("j" "D")))))
    `(progn
       (defun ,fname ()
         (interactive)
         (cond
          ((equal major-mode 'vterm-mode)
           (vterm-send-key ,key nil nil t ))

          (t
           (condition-case nil
               (windmove)
             (error
              (call-process "tmux" nil nil nil "select-pane" ,(concat "-" tmux-flag)))))))

       (map! ,(concat "C-"   key)   #',fname)
       (map! ,(concat "C-S-" key) #',windmove))))

(tmux-nav left)
(tmux-nav down)
(tmux-nav up)
(tmux-nav right)

(after! plantuml-mode
  (setq plantuml-jar-args
        (list "-Djava.awt.headless=true"
              (concat "-Dplantuml.include.path=~/.config/plantuml"))))

(after! ox-gfm
  (map! :n "SPC m g f m" #'org-gfm-export-to-markdown)

  )
