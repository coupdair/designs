echo(version=version());

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 2;    // Don't generate larger angles than 5 degrees

thickness=3;
diameter=46;

color("red")
    rotate_extrude()
        translate([diameter/2-thickness, 0])
            circle(thickness/2);
