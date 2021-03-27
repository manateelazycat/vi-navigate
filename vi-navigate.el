;;; vi-navigate.el --- Navigate read-only buffer like vi behavior

;; Filename: vi-navigate.el
;; Description: Navigate read-only buffer like vi behavior
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2018, Andy Stewart, all rights reserved.
;; Created: 2018-10-02 08:28:56
;; Version: 0.1
;; Last-Updated: 2018-10-02 08:28:56
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/vi-navigate.el
;; Keywords:
;; Compatibility: GNU Emacs 27.0.50
;;
;; Features that might be required by this library:
;;
;;
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Navigate read-only buffer like vi behavior.
;;
;; I like Emacs' default keystroke, which is easy to use.
;; I prefer use vi style keystroke if current buffer is read-only
;; that we can quickly navigated with one key press.
;;

;;; Installation:
;;
;; Put vi-navigate.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'vi-navigate)
;; (vi-navigate-load-keys)
;;

;;; Customize:
;;
;; `vi-navigate-key-alist'
;; `vi-navigate-sdcv-key-alist'
;; `vi-navigate-help-mode-key-alist'
;; `vi-navigate-hook-list'
;;
;; All of the above can customize by:
;;      M-x customize-group RET vi-navigate RET
;;

;;; Change log:
;;
;; 2018/10/02
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require


;;; Code:
(defgroup vi-navigate nil
  "Navigate read only buffer like vi behavior."
  )

(defcustom vi-navigate-key-alist
  '(("j" . next-line)
    ("k" . previous-line)
    ("h" . backward-char)
    ("l" . forward-char)
    ("J" . vi-navigate-scroll-up-one-line)
    ("K" . vi-navigate-scroll-down-one-line)
    ("H" . backward-word)
    ("L" . forward-word)
    ("e" . scroll-down)
    ("SPC" . scroll-up)
    )
  "Default key alist for vi-navigate."
  :group 'vi-navigate
  :type 'alist)

(defcustom vi-navigate-sdcv-key-alist
  '(
    ("y" . sdcv-search-pointer+)
    ("Y" . sdcv-search-pointer)
    ("i" . sdcv-search-input+)
    ("I" . sdcv-search-input)
    )
  "Default key alist for sdcv."
  :group 'vi-navigate
  :type 'alist)

(defcustom vi-navigate-help-mode-key-alist
  '(("f" . help-go-forward)
    ("b" . help-go-back)
    ("<tab>" . forward-button)
    )
  "Default key alist for help-mode"
  :group 'vi-navigate
  :type 'alist)

(defcustom vi-navigate-hook-list
  '(eww-mode-hook
    help-mode-hook
    package-menu-mode-hook
    top-mode-hook
    benchmark-init/tabulated-mode-hook
    benchmark-init/tree-mode-hook
    emms-playlist-mode-hook
    emms-browser-mode-hook
    emms-stream-mode-hook
    apt-utils-mode-hook
    Man-mode-hook
    apropos-mode-hook
    less-minor-mode-hook
    Info-mode-hook
    doc-view-mode-hook
    w3m-mode-hook
    pdf-view-mode-hook
    irfc-mode-hook
    )
  "Default hook list for vi-navigate."
  :group 'vi-navigate
  :type 'list)

(defun vi-navigate-scroll-up-one-line ()
  "Scroll up one line."
  (interactive)
  (scroll-up 1))

(defun vi-navigate-scroll-down-one-line ()
  "Scroll down one line."
  (interactive)
  (scroll-down 1))

(defun vi-navigate-load-keys ()
  (interactive)
  (dolist (hook vi-navigate-hook-list)
    (add-hook hook
              #'(lambda ()
                  (let* ((keymap-string (format "%s-map" major-mode))
                         (keymap (symbol-value (intern keymap-string))))
                    ;; Load default navigate keys.
                    (vi-navigate-set-key vi-navigate-key-alist keymap)

                    ;; Load sdcv keys if sdcv library was loaed.
                    (with-temp-message ""
                      (when (load "sdcv" t)
                        (vi-navigate-set-key vi-navigate-sdcv-key-alist keymap)))

                    ;; Add keys if current mode is `help-mode'.
                    (when (string-equal keymap-string "help-mode-map")
                      (vi-navigate-set-key vi-navigate-help-mode-key-alist keymap)))))))

(defun vi-navigate-set-key (key-alist &optional keymap key-prefix)
  "This function is to little type when define key binding.
`KEYMAP' is a add keymap for some binding, default is `current-global-map'.
`KEY-ALIST' is a alist contain main-key and command.
`KEY-PREFIX' is a add prefix for some binding, default is nil."
  (let (key def)
    (or keymap (setq keymap (current-global-map)))
    (if key-prefix
        (setq key-prefix (concat key-prefix " "))
      (setq key-prefix ""))
    (dolist (element key-alist)
      (setq key (car element))
      (setq def (cdr element))
      (cond ((stringp key) (setq key (read-kbd-macro (concat key-prefix key))))
            ((vectorp key) nil)
            (t (signal 'wrong-type-argument (list 'array key))))
      (define-key keymap key def))))

(provide 'vi-navigate)

;;; vi-navigate.el ends here
