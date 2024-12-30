(defun my/link-gen (fname label) (format "[ <a href=\"%s\"/> %s </a> ]" fname label))

(defun my/preamble-gen (p) (concat
                            "<!-- SIDEBAR -->
                                 <a aria-current=\"page\" class=\"\" href=\"/\">
                                     <img alt=\"me\" src=\"img/me.jpg\" width=\"150\" height=\"150\">
                                     <div class=\"name\">Ivan Borisov</div>
                                 </a>

                                 <div class=\"whoami\">Computer science student at ITMO University. Interested in programming, Linux and Emacs.</div>

                                 <div class=\"links\">
                                     <span><a href=\"https://t.me/vandaisky\">Telegram</a></span>
                                     <span><a href=\"https://github.com/miptivan\">GitHub</a></span>
                                     <span><a href=\"https://instagram.com/vandaisky\">Instagram</a></span>
                                 </div>

                                 <div><ul class=\"menu\">
                                     <li><a href=\"https://miptivan.github.io/index.html\">Home</a></li>
                                     <li><a href=\"https://miptivan.github.io/about.html\">About</a></li>
                                     <li><a href=\"https://miptivan.github.io/analysis.html\">Analysis</a></li>
                                 </ul></div>
                             <!-- / SIDEBAR -->"
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

