use <extrusion.scad>;
include <params.scad>;

module frame() {
    // Bottom square area
    translate([10, 5, 5]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
    translate([5, 10, 5]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
    //translate([10, EXTRUSION_LEN+15, 5]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
    translate([EXTRUSION_LEN+15, 10, 5]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
    
    // Stood up corners
    translate([5, 5, 0]) extrusion(EXTRUSION_LEN);
    translate([EXTRUSION_LEN+15, 5, 0]) extrusion(EXTRUSION_LEN);
    translate([EXTRUSION_LEN+15, EXTRUSION_LEN+15, 0]) extrusion(EXTRUSION_LEN);
    translate([5, EXTRUSION_LEN+15, 0]) extrusion(EXTRUSION_LEN);
    
    // Top of bottom half
    //translate([10, 5, 135]) rotate([0, 90, 0]) extrusion(140);
    translate([5, 10, EXTRUSION_LEN-5]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
    //translate([10, 155, 135]) rotate([0, 90, 0]) extrusion(140);
    translate([EXTRUSION_LEN+15, 10, EXTRUSION_LEN-5]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
}

frame();