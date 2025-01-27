#!/bin/sh
emacs -Q --script build_pub.el

./links.sh
./create_gitignore.sh
