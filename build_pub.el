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
              :html-postamble nil
              :with-title nil)
              ))

(setq org-export-global-macros '(
                                 ("timestamp" . "@@html:<span class=\"timestamp\">[$1]</span>@@")
                                 ("div" . "@@html:<div>$1</div>@@")
                                 ))

(org-publish-all t)
;; (org-publish-project "public")
(message "Build complete!")
