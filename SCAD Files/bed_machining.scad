include <params.scad>;

module bed() {
    translate([0, 0, 8]) union() {
        // Bed plate (6mm thick)
        color("silver") translate([0, -13, 0]) translate([-BED_X/2, -BED_Y, 10]) cube([BED_X, BED_Y, 6]);
    }
}

module bed_cutout() {
    square([BED_X, BED_Y]);
}

module countersink_holes() {
    r = 3.2;
    translate([5, BED_Y-5]) circle(r=3.2);
    translate([BED_X-5, BED_Y-5]) circle(r=3.2);
    translate([BED_X/2, 5]) circle(r=3.2);
}

module plunge_holes() {
    translate([5, BED_Y-5]) circle(r=1.7);
    translate([BED_X-5, BED_Y-5]) circle(r=1.7);
    translate([BED_X/2, 5]) circle(r=1.7);
}

$fn = 80;
bed_cutout();