include <params.scad>;

$fn = 100;

module 3d_pei() {
    linear_extrude(0.5) 2d_pei();
}

module 2d_pei() {
    minkowski() {
        union() {
            translate([3, 3, 0]) square(size=[BED_X-6, BED_Y-6]);
            polygon([[BED_X/3, -5], [2*BED_X/3, -5], [3*BED_X/4, 3], [BED_X/4, 3]]);
        }
        translate([0, 0, 0]) circle(r=3);
    }
}

2d_pei();