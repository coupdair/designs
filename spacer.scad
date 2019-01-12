echo(version=version());

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than $fs mm, e.g. 0.1
$fa = 2;    // Don't generate larger angles than $fa degrees, e.g. 5

thickness=3;
//spacer
diameter=46;
hole_diameter=15;
//hook
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
  difference() {
    //outer
    cylinder(h=thickness, r=hook_diameter/2-thickness/2+0.1, center=true);
    //inner
    cylinder(h=thickness+0.1, r=hook_in/2+thickness/2-0.1, center=true);
  }
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
module hook() {
union(){
hook_border() ;
hook_ring() ;
hook_in() ;
}
}

hook_translate=diameter/2+hook_diameter/2-thickness;
module hookL() {
translate([hook_translate,0,0]) {
hook();
//#hook_box();
}
}//hookL
module hookR() {
translate([-hook_translate,0,0]) {
hook();
//#hook_box();
}
}//hookR

module handle_border() {
color("green")
 rotate([90,0,90])
   linear_extrude(height = 12, center = true, convexity = 10)
            circle(thickness/2);
}
module handle_fill(sx,sy) {
color("red")
  cube([sx,sy,thickness],true);
}

handle_border();
handle_fill();

handle_translateX=diameter/2;
handle_translateY=hook_diameter/2-thickness/2;
module handle_borders() {
translate([handle_translateX, handle_translateY]) handle_border();
translate([-handle_translateX, handle_translateY]) handle_border();
translate([handle_translateX, -handle_translateY]) handle_border();
translate([-handle_translateX, -handle_translateY]) handle_border();
}//handle_borders

handlef_translateX=hook_translate-hook_in/2-thickness;
handlef_translateY=0;
sx=(hook_diameter/2-thickness/2)-(hook_in/2+thickness/2)+0.2;
sy=hook_diameter-thickness;
handle_fill(sx,sy);

handlefr_translateX=hook_translate-hook_in/2-thickness;
handlefr_translateY=hook_diameter/2-thickness/2-1;
rotate([0,0,90]) handle_fill(sx,sy);
module handle_fills() {
//translate ones
translate([handlef_translateX, handlef_translateY]) handle_fill(sx,sy);
translate([handlef_translateX-thickness/2, handlef_translateY]) handle_fill(sx,sy);
translate([-handlef_translateX, handlef_translateY]) handle_fill(sx,sy);
translate([-handlef_translateX+thickness/2, handlef_translateY]) handle_fill(sx,sy);
//rotate ones
    translate([handlefr_translateX, handlefr_translateY])
rotate([0,0,90]) handle_fill(sx,sy);
    translate([handlefr_translateX, -handlefr_translateY])
rotate([0,0,90]) handle_fill(sx,sy);
    translate([-handlefr_translateX, handlefr_translateY])
rotate([0,0,90]) handle_fill(sx,sy);
    translate([-handlefr_translateX, -handlefr_translateY])
rotate([0,0,90]) handle_fill(sx,sy);
}//handle_fills


module handles(){
handle_fills();
handle_borders();
}

union(){
hookL();
hookR();
handles();
spacer() ;
//#spacer_box() ;
}//design
