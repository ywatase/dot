#!/usr/bin/python
# -*- coding: UTF-8 -*-

# PNG to ANSI text
#
# Fredrik Hultin 2009
#   http://nurd.se/~noname

import gd, sys

if len(sys.argv) < 2 or sys.argv[-1] == "-d":
	print "  PNG2ANSI"
	print "  Usage:"
	print "    %s [-d] <file>" % sys.argv[0]
	print "  Options:"
	print "    -d   double horizontal \"pixels\""
	sys.exit()

hp = 1 + (sys.argv[1] == "-d")

image = gd.image(sys.argv[-1])
pal = gd.image((1, 1))

w, h = image.size()

pal.colorAllocate((0, 0, 0)) 		# black
pal.colorAllocate((128, 0, 0))		# red
pal.colorAllocate((0, 128, 0))		# green
pal.colorAllocate((128, 128, 0))	# yellow
pal.colorAllocate((0, 0, 128))		# blue
pal.colorAllocate((128, 0, 128))	# magenta
pal.colorAllocate((0, 128, 128))	# cyan
pal.colorAllocate((128, 128, 128))	# white

pal.colorAllocate((0, 0, 0)) 		# black
pal.colorAllocate((256, 0, 0))		# red
pal.colorAllocate((0, 256, 0))		# green
pal.colorAllocate((256, 256, 0))	# yellow
pal.colorAllocate((0, 0, 128))		# blue
pal.colorAllocate((256, 0, 256))	# magenta
pal.colorAllocate((0, 256, 256))	# cyan
pal.colorAllocate((256, 256, 256))	# white

for y in range(h):
	for x in range(w):
		color = image.colorComponents(image.getPixel((x, y)))
		index = pal.colorClosest(color)
		out = "%d" % (index)
		if index >= 8:
			out = "%d" % (index - 8)
		else:
			out = "%d" % (index)
		for i in range(hp):
			sys.stdout.write(out)
			
	sys.stdout.write('\n')
