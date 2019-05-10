#!/bin/sh

# erzeugt Donnerstag, 09. Mai 2019 15:53 (C) 2019 von Leander Jedamus
# modifiziert Freitag, 10. Mai 2019 14:00 von Leander Jedamus
# modifiziert Donnerstag, 09. Mai 2019 21:53 von Leander Jedamus

# Anzahl Spalten
spalten=4

# Dateiendung der Grafikdateien
gr="eps"

# Output LaTeX-Datei
output_file="create.tex"

# files enthält die Grafikdateien, die in dem PDF angezeigt werden sollen
files=""
for dir in graphics_universe/eps_01 graphics_universe/eps_02 graphics_universe/eps_03 graphics_universe/eps_04; do
  files="$files $dir/*.$gr"
done
files="cartoon_clips/*.$gr $files"

(

# erzeuge Spalten für tabular:
nr=1
tabular=""
while [ $nr -le $spalten ]; do
  tabular="${tabular}c"
  nr=$(( $nr + 1 ))
done

echo '\\documentclass[12pt]{scrartcl}'
echo "% erzeugt Donnerstag, 09. Mai 2019 15:49 (C) 2019 von Leander Jedamus"
echo "% modifiziert Donnerstag, 09. Mai 2019 21:50 von Leander Jedamus"
echo ""

# enthält \includegraphics
echo '\\usepackage{graphicx}'
echo ""

# Anfang Dokument
echo '\\begin{document}'

# Erste tabular
echo '  \\begin{tabular}{'"$tabular"'}'

nr=1
for file in $files; do

  # für jedes file eine minipage
  echo '    \\begin{minipage}[b]{3cm}'
  echo '      \\resizebox{3cm}{!}{\\includegraphics[width=3cm]{'"$file"'}}'
  filename=`echo $file | sh sed.sh`
  echo "      $filename"
  echo -n '    \\end{minipage}'

  # neue Spalte oder neue tabular?
  if [ $nr -lt $spalten ]; then
    echo " &"
    nr=$(( $nr + 1 ))
  else
    echo ' \\\\'
    echo '  \\end{tabular}\\\\'
    echo '  \\begin{tabular}{'"$tabular"'}'
    nr=1
  fi

done

# tabular zu Ende schreiben
while [ $nr -lt $spalten ]; do
    echo -n " &"
    nr=$(( $nr + 1 ))
done
echo ' \\\\'
echo '  \\end{tabular}'

# Ende Dokument
echo '\\end{document}'
) > $output_file

# vim:ai sw=2

