(add-to-list 'load-path (expand-file-name "~/blog_pub/build_scripts" (file-name-directory load-file-name)))

(load "init_straight_pub")
(load "org_setup")
(load "sections_pub")

(defun my-org-html-link-transform (link desc info)
  "Преобразует ссылки вида ../img/ в /img/ для публикации."
  (let ((path (org-element-property :path link)))
    (if (string-prefix-p "../../img" path)
        (org-element-put-property link :path (concat "img/" (substring path 7)))))
  nil)

(require 'ox-publish)

  (setq org-publish-project-alist
        (list
          (list "public"
              :recursive t
              :base-directory "./content"
              :base-extension "org"
              :publishing-directory "./docs"
              :publishing-function 'org-html-publish-to-html
              :html-preamble (my/preamble-gen ".")
              :html-postamble nil)
              ))

(setq org-export-global-macros '(
                                 ("timestamp" . "@@html:<span class=\"timestamp\">[$1]</span>@@")
                                 ("div" . "@@html:<div>$1</div>@@")
                                 ))

(org-publish-all t)

;; Возвращение орг роама в исходную директорию
(setq org-roam-link-use-id nil)
(setq org-roam-directory (file-truename "../blog/content"))
;; (org-id-update-id-locations "../blog/content")
(setq org-id-link-to-org-use-id t)
(org-roam-db-sync)
;; / Возвращение орг роама в исходную директорию

;; (org-publish-project "public")
(message "Build complete!")
