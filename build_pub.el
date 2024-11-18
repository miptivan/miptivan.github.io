(add-to-list 'load-path (expand-file-name "~/blog_pub/build_scripts" (file-name-directory load-file-name)))

(load "init_straight_pub")
(load "org_setup")
(load "sections_pub")

(require 'ox-publish)

  (setq org-publish-project-alist
        (list
          (list "public"
              :recursive t
              :base-directory "./content"
              :base-extension "org"
              :publishing-directory "./docs"
              :publishing-function 'org-html-publish-to-html
              :html-preamble (my/preamble-gen "." )
              :html-postamble (my/postamble-gen ".")
              :with-title nil)
              ))

(org-publish-all t)
;; (org-publish-project "public")
(message "Build complete!")
