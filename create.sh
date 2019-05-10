#!/bin/sh

# erzeugt Donnerstag, 09. Mai 2019 15:53 (C) 2019 von Leander Jedamus
# modifiziert Samstag, 11. Mai 2019 01:04 von Leander Jedamus
# modifiziert Freitag, 10. Mai 2019 21:50 von Leander Jedamus
# modifiziert Donnerstag, 09. Mai 2019 21:53 von Leander Jedamus

usage()
{
  echo "usage: $0\t-r|--rows <nr_of_rows> -o|--output <output_file>"
  echo "\t\t\t-s|--suffix <graphic_suffix> -d|--dir <dir1> ..."
  exit 1
};# usage

files=""
spalten=4
output_file="create.tex"
suffix=""
SP=""

TEMP=`getopt -o r:o:s:d: --longoptions rows:,output:,suffix:,dir: \
     -n 'opt.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

while true; do
  case $1 in
    -r|--rows)   spalten=$(( $2 ))
                 if [ $spalten -lt 2 ]; then
	           echo "<nr_of_rows> < 2!"
		   usage
	         fi
                 shift 2;;
    -o|--output) output_file=$2
                 shift 2;;
    -s|--suffix) suffix=$2
                 shift 2;;
    -d|--dir)    if [ -z $suffix ]; then
                   echo "set -s first!"
		   usage
                 fi
                 files="$files$SP$2/*.$suffix"
	         SP=" "
		 shift 2;;
    --)          shift ; break;;
    *)           echo "Internal error!" ; exit 1 ;;
  esac
done

if [ -z $suffix ]; then
  suffix="png"
fi
if [ -z "$files" ]; then
  files="./*.$suffix"
fi

echo "nr_of_rows = $spalten, output_file=$output_file, suffix=$suffix, files=$files"
exit 0

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

