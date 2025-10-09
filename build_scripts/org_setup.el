(use-package emacsql
  :straight (:host github
                   :repo "magit/emacsql"
                   :pin "fb05d0f72729a4b4452a3b1168a9b7b35a851a53"))

(use-package org :straight (:type built-in))

(use-package org-roam
  :straight (:host github
                   :repo "org-roam/org-roam"
                   :pin "9fd7c87b5b9037ec0d450c58ca7f69e8d25eeb24"))

(setq org-roam-link-use-id nil)
(setq org-roam-directory (file-truename "./content"))
(org-id-update-id-locations "./content")
(setq org-id-link-to-org-use-id t)
(org-roam-db-sync)

;; ПРЕВРАЩАЕТ ID ORG-ROAM В ССЫЛКИ
(setq org-id-extra-files (org-roam-list-files))

(defun org-html--reference (datum info &optional named-only)
 "Return an appropriate reference for DATUM.
DATUM is an element or a `target' type object. INFO is the
current export state, as a plist.
When NAMED-ONLY is non-nil and DATUM has no NAME keyword, return
nil. This doesn't apply to headlines, inline tasks, radio
targets and targets."
 (let* ((type (org-element-type datum))
 (user-label
 (org-element-property
 (pcase type
 ((or `headline `inlinetask) :CUSTOM_ID)
 ((or `radio-target `target) :value)
 (_ :name))
 datum))
 (user-label (or user-label
 (when-let ((path (org-element-property :ID datum)))
 (concat "ID-" path)))))
 (cond
 ((and user-label
 (or (plist-get info :html-prefer-user-labels)
 ;; Used CUSTOM_ID property unconditionally.
 (memq type '(headline inlinetask))))
 user-label)
 ((and named-only
 (not (memq type '(headline inlinetask radio-target target)))
 (not user-label))
 nil)
 (t
 (org-export-get-reference datum info)))))
;; / ПРЕВРАЩАЕТ ID ORG-ROAM В ССЫЛКИ

(use-package org-roam
  :straight (:host github
                   :repo "hniksic/emacs-htmlize"
                   :pin "8e3841c837b4b78bd72ad7f0436e919f39315a46"))


;; ORG-ROAM BACKLINKS
(defun commonplace/collect-backlinks-string (backend)
  "Insert backlinks into the end of the org file before parsing it."
  (when (org-roam-node-at-point)
    (goto-char (point-max))
    (let* ((backlinks (org-roam-backlinks-get (org-roam-node-at-point)))
           (current-file-dir (file-name-directory (buffer-file-name))))
      (when backlinks
        ;; Add a new header for the references only if there are backlinks
        (insert "#+OPTIONS: num:nil")
        (insert "\n* Заметки с ссылками на эту страницу \n")
        (dolist (backlink backlinks)
          (let* ((source-node (org-roam-backlink-source-node backlink))
                 (source-file (org-roam-node-file source-node))
                 (relative-path (file-relative-name source-file current-file-dir)))
            (insert
             (format "- [[file:%s][%s]]\n"
                     relative-path
                     (org-roam-node-title source-node)))))))))

(defun commonplace/add-extra-sections (backend)
  "Add backlinks section before exporting an org file."
  (when (org-roam-node-at-point)
    (save-excursion
      (goto-char (point-max))
      (commonplace/collect-backlinks-string backend))))

(add-hook 'org-export-before-processing-hook 'commonplace/add-extra-sections)
;; / ORG-ROAM BACKLINKS


;; Пометить битые ссылки, но не выдавать ошибки
(setq org-export-with-broken-links 'mark)
