echo(version=version());

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than $fs mm, e.g. 0.1
$fa = 2;    // Don't generate larger angles than $fa degrees, e.g. 5

thickness=3;
diameter=46;
hole_diameter=15;

module spacer_border() {
color("green")
    rotate_extrude()
        translate([diameter/2-thickness, 0])
            circle(thickness/2);
}

module spacer_center() {
color("blue")
  cylinder(h=thickness, r=diameter/2-thickness, center=true);
 }

module spacer_hole() {
color("red")
  cylinder(h=thickness+0.1, r=hole_diameter/2, center=true);
}

module spacer() {
  difference() {
    union() {spacer_center(); spacer_border();}
    spacer_hole() ;
  }//difference
}//spacer

spacer() ;
