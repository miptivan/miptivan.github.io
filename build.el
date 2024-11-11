;; Load the publishing system

;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'org-roam)
  (package-install 'org-roam))

(require 'ox-publish)
(require 'org-roam)
(setq org-roam-directory (file-truename "~/blog/content"))
(setq org-id-link-to-org-use-id t)

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

(require 'htmlize)

(defun my/link-gen (fname label) (format "[ <a href=\"%s\"/> %s </a> ]" fname label))

(defun my/preamble-gen (p) (concat
                            "<nav> <center>"
                            (my/link-gen "index.html" "Home")
                            (my/link-gen "about.html" "About")
                            (my/link-gen "https://github.com/miptivan" "Github")
                            (my/link-gen "math.html" "Math")
                            "</center> </nav>"
                            ))

(defun my/postamble-gen (p) (concat
                              "<footer> <center>"
                              (my/link-gen "index.html" "Home")
                              (my/link-gen "about.html" "About")
                              (my/link-gen "https://github.com/miptivan" "Github")
                              (my/link-gen "math.html" "Math")
                            "</center> </nav>"
                              "</center> </footer>"
   ))

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./content"
             :publishing-directory "./public"
             :publishing-function 'org-html-publish-to-html
             :html-preamble (my/preamble-gen "." )
             :html-postamble (my/postamble-gen ".")
             :html-head-extra "<link rel='stylesheet' type='text/css' href='../css/style.css' />"
             :with-title nil)))

;; org-roam backlinks
(defun commonplace/collect-backlinks-string (backend)
  "Insert backlinks into the end of the org file before parsing it."
  (when (org-roam-node-at-point)
    (goto-char (point-max))
    (let* ((backlinks (org-roam-backlinks-get (org-roam-node-at-point))))
      (when backlinks
        ;; Add a new header for the references only if there are backlinks
        (insert "#+OPTIONS: num:nil")
        (insert "\n* Заметки с ссылками на эту страницу \n")
        (dolist (backlink backlinks)
          (let* ((source-node (org-roam-backlink-source-node backlink))
                 (point (org-roam-backlink-point backlink)))
            (insert
             (format "- [[./%s][%s]]\n"
                     (file-name-nondirectory (org-roam-node-file source-node))
                     (org-roam-node-title source-node)))))))))

(defun commonplace/add-extra-sections (backend)
  (when (org-roam-node-at-point)
    (save-excursion
      (goto-char (point-max))
      (commonplace/collect-backlinks-string backend))))

(add-hook 'org-export-before-processing-hook 'commonplace/add-extra-sections)
;; / org-roam backlinks


;; Generate the site output
(org-publish-all t)

(message "Build complete!")
