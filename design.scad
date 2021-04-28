///Version
version="v0.1.0g";

///OpenSCAD version
echo(version=version());

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than $fs mm, e.g. 0.1
$fa = 3;    // Don't generate larger angles than $fa degrees, e.g. 5
epsilon=0.123;

thickness=3;
width=50;
height=10;
cwidth=14;
cheight=3;
radius=2;

//! bounding box
module bbox()
{
  cube([width,height,thickness], center=true);
}//bbox

//! plane label
module label()
{
  east=-width/2+radius;
  ouest=width/2-radius;
  south=-height/2+radius;
  north=height/2-radius;
  difference()
  {
    //plane
//    cube([width,height,thickness], center=true);
    hull()
    {
      translate([east,south,0]) cylinder(r=radius, h=thickness, center=true);
    }
    //uSD space
    translate([0,-(height-cheight)/2,-epsilon]) cube([cwidth,cheight,thickness+2*epsilon], center=true);
  }  
}//label

%bbox();
label();
