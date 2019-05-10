#!/bin/sh

# erzeugt Donnerstag, 09. Mai 2019 16:00 (C) 2019 von Leander Jedamus
# modifiziert Freitag, 10. Mai 2019 14:05 von Leander Jedamus
# modifiziert Donnerstag, 09. Mai 2019 16:00 von Leander Jedamus

./create.sh
pdflatex create.tex
evince create.pdf

# vim:ai sw=2

