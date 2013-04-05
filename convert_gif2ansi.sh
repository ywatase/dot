#!/bin/bash

main () {
  for F_NAME in "$@"
  do
	if ! [ -e $F_NAME ] ; then
		continue
	fi
	F_FILENAME=$(basename $F_NAME)
	F_BASENAME=$(basename $F_FILENAME .gif)
	PALETTE=palette.default.json
	case $F_BASENAME in
		"monk_stand"| "maken_stand"|"viking_stand" )
			PALETTE="palette.type1.json"
			;;
		*)
			;;
	esac
	./png2ansi.pl -p $PALETTE $F_NAME | ./resize.pl 3  > dat/$F_BASENAME.dat
	./ansi_escape.pl dat/$F_BASENAME.dat
	./ansi_escape.pl dat/$F_BASENAME.dat  > motd/$F_BASENAME.txt
  done
}
main "$@"
