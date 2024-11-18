(defun my/link-gen (fname label) (format "[ <a href=\"%s\"/> %s </a> ]" fname label))

(defun my/preamble-gen (p) (concat
                            "<nav> <center>"
                            (my/link-gen "https://miptivan.github.io/index.html" "Home")
                            (my/link-gen "https://miptivan.github.io/about.html" "About")
                            (my/link-gen "https://github.com/miptivan" "Github")
                            (my/link-gen "https://miptivan.github.io/analysis.html" "Analysis")
                            "</center> </nav>"
                            ))

(defun my/postamble-gen (p) (concat
                              "<footer> <center>"
                            (my/link-gen "https://miptivan.github.io/index.html" "Home")
                            (my/link-gen "https://miptivan.github.io/about.html" "About")
                            (my/link-gen "https://github.com/miptivan" "Github")
                            (my/link-gen "https://miptivan.github.io/analysis.html" "Analysis")
                            "</center> </nav>"
                              "</center> </footer>"
                            ))

