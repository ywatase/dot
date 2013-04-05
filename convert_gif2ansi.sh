#!/bin/bash

main () {
  for F_NAME in "$@"
  do
	if ! [ -e $F_NAME ] ; then
		continue
	fi
	F_BASENAME=$(basename $F_NAME .gif)
	CMD=png2ansi2.py
	case $F_BASENAME in
		"monk_stand"| "maken_stand")
			CMD=png2ansi3.py
			;;
		"viking_stand" )
			CMD=png2ansi4.py
			;;
		*)
			;;
	esac
	python $CMD $F_NAME | perl -nle 'next if $i++ % 3; s/(.){3}/\1/g; print'  > $F_BASENAME.dat
	perl ./ansi_escape.pl $F_BASENAME.dat
	perl ./ansi_escape.pl $F_BASENAME.dat  > $F_BASENAME.txt
  done
}
main "$@"
