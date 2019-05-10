#!/bin/sh

# erzeugt Donnerstag, 09. Mai 2019 15:53 (C) 2019 von Leander Jedamus
# modifiziert Freitag, 10. Mai 2019 17:55 von Leander Jedamus
# modifiziert Donnerstag, 09. Mai 2019 21:53 von Leander Jedamus

# Anzahl Spalten
spalten=4

# Dateiendung der Grafikdateien
suffix="eps"

# Output LaTeX-Datei
output_file="create.tex"

#set -x

usage()
{
  echo "usage: $0 -r <nr_of_rows> -o <output_file> -s <graphic_suffix> -d <dir>"
  exit 1
};# usage

if [ -z $6 ]; then
  usage
else if [ -z $5 ]; then
  usage
else if [ -z $4 ]; then
  usage
else if [ -z $3 ]; then
  usage
else if [ -z $2 ]; then
  usage
else if [ -z $1 ]; then
  usage
fi fi fi fi fi fi
if [ $1 != "-r" ]; then
  usage
else
  shift
  nr=$1
  shift
  spalten=$(( $nr ))
  if [ $spalten -lt 2 ]; then
    echo "<nr_of_rows> < 2!"
    usage
  else
    if [ $1 != "-o" ]; then
      usage
    else
      shift
      output_file=$1
      shift
      if [ $1 != "-s" ]; then
        usage
      else
        shift
	suffix=$1
	shift
      fi
    fi
  fi
fi

# files enthält die Grafikdateien, die in dem PDF angezeigt werden sollen
files=""
while [ ! -z $1 ]; do
  if [ $1 != "-d" ]; then
    usage
  else
    shift
    if [ -z $1 ]; then
      usage
    else
      files="$files $1/*.$suffix"
      shift
      continue
    fi
  fi
done

echo "nr_of_rows = $spalten, output_file=$output_file, suffix=$suffix, files=$files"

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
echo "% modifiziert Freitag, 10. Mai 2019 17:22 von Leander Jedamus"
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

