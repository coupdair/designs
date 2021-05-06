BIN=openscad
VIEW_SIZE=512,512
DESIGN=design.scad

all: version image stl

%.stl: %.scad
	$(BIN) -o -o $@ $<

#need 2015.03
%.png: %.scad
	$(BIN) --render --imgsize=$(VIEW_SIZE) -o $@ $<

version:
	@grep version $(DESIGN) | head -n 1 | cut -d'=' -f2 | sed "s/\"//g;s/;//g" | tee VERSION
	@openscad --version 2>&1 | cut -d' ' -f3 | sed 's/command/OpenSCAD not available/' | tee -a VERSION

image: version design.png
	@echo "display $(DESIGN).png &"

stl:   version design.stl
	@echo "blender $(DESIGN).stl &"

design:
	openscad $(DESIGN) &

