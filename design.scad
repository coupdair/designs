///Version
version="v0.1.0d";

///OpenSCAD version
echo(version=version());

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than $fs mm, e.g. 0.1
$fa = 3;    // Don't generate larger angles than $fa degrees, e.g. 5

thickness=3;
width=50;
height=10;
cwidth=14;
cheight=3;
radius=2;

//! bounding box
module bbox()
{
  cube([width,height,thickness]);
}//bbox

bbox();
