#!/bin/sh

# erzeugt Donnerstag, 09. Mai 2019 16:00 (C) 2019 von Leander Jedamus
# modifiziert Freitag, 10. Mai 2019 17:28 von Leander Jedamus
# modifiziert Donnerstag, 09. Mai 2019 16:00 von Leander Jedamus

prefix="create"

./create.sh -r 4 -o $prefix.tex -s eps
pdflatex $prefix.tex
evince $prefix.pdf

# vim:ai sw=2

