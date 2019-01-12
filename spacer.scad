echo(version=version());

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than $fs mm, e.g. 0.1
$fa = 2;    // Don't generate larger angles than $fa degrees, e.g. 5

thickness=3;
diameter=46;
hole_diameter=15;
hook_diameter=16;
hook_in=6;

module spacer_border() {
color("green")
    rotate_extrude()
        translate([diameter/2-thickness/2, 0])
            circle(thickness/2);
}

module spacer_center() {
color("blue")
  cylinder(h=thickness, r=diameter/2-thickness/2, center=true);
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
module spacer_box() {
    cylinder(h=thickness, r=diameter/2, center=true);
}

module hook_border() {
color("green")
    rotate_extrude()
        translate([hook_diameter/2-thickness/2, 0])
            circle(thickness/2);
}
module hook_ring() {
color("red")
 // difference() {
    cylinder(h=thickness, r=hook_diameter/2/*-thickness/2*/, center=true);
    cylinder(h=thickness, r=hook_in/2/*+thickness/2*/, center=true);
//  }
 }

module hook_in() {
color("blue")
    rotate_extrude()
        translate([hook_in/2+thickness/2, 0])
            circle(thickness/2);
}
module hook_box() {
difference() {
     cylinder(h=thickness, r=hook_diameter/2, center=true);
     cylinder(h=thickness+0.1, r=hook_in/2, center=true);
  }
}

hook_border() ;
//translate([0,0,-thickness/2])  hook_ring() ;
hook_in() ;
#hook_box();

//spacer() ;
//#spacer_box() ;