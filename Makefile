BIN=openscad
VIEW_SIZE=512,512

all: version

#%.stl: %.scad
#	$(BIN) -o $@ $<

#need 2015.03
%.png: %.scad
	$(BIN) --render --imgsize=$(VIEW_SIZE) -o $@ $<

version:
	grep version design.scad | head -n 1 | cut -d'=' -f2 | sed "s/\"//g;s/;//g" | tee VERSION
	openscad --version 2>&1 | cut -d' ' -f3 | tee -a VERSION

image: version design.png
	echo "display design.png &"

stl: version
	$(BIN) -o design.stl design.scad

design:
	openscad design.scad &
