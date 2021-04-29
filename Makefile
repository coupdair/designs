BIN=openscad
VIEW_SIZE=512,512
DESIGN=design.scad

all: version view image

#%.stl: %.scad
#	$(BIN) -o $@ $<

#need 2015.03
%.png: %.scad
	$(BIN) --render --imgsize=$(VIEW_SIZE) -D"with_face=false" -o $@ $<

version:
	@grep version design.scad | head -n 1 | cut -d'=' -f2 | sed "s/\"//g;s/;//g" | tee VERSION
	@openscad --version 2>&1 | cut -d' ' -f3 | tee -a VERSION

image: version design.png
	@echo "display design.png &"

stl: version
	$(BIN) -D"with_face=false" -o design.stl $(DESIGN)
	@echo "blender design.stl &"

design:
	openscad $(DESIGN) &

view: version
	$(BIN) --render --imgsize=$(VIEW_SIZE) -D"with_face=true" -o view.png $(DESIGN)
	@echo "display view.png &"
