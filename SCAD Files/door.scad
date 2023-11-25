include <params.scad>;

module door_latch() {
    translate([0, 0, -5])
    difference() {
        hull() {
            sphere(r=3);
            translate([0, 7, 0]) sphere(r=3);
            translate([0, 7, 28]) sphere(r=3);
            translate([0, 0, 28]) sphere(r=3);
            translate([5, 0, 7]) sphere(r=3);
            translate([5, 0, 21]) sphere(r=3);
            translate([5, 3, 7]) sphere(r=3);
            translate([5, 3, 21]) sphere(r=3);
        }
        
        // Hard cuts
        translate([-4.01, -5, -10]) cube([4, 20, 50]);
        translate([-5.01, -4.01, -10]) cube([20, 4, 50]);
        
        // Screw holes
        translate([-5, 5, 3])  rotate([0, 90, 0]) cylinder(r=1.7, h=50);
        translate([2, 5, 3])  rotate([0, 90, 0]) cylinder(r=3, h=50);
        translate([-5, 5, 25])  rotate([0, 90, 0]) cylinder(r=1.7, h=50);
        translate([2, 5, 25])  rotate([0, 90, 0]) cylinder(r=3, h=50);
        
        // Magnet holes
        translate([-0.02, 0.65, 7]) cube([6.5, 3.4, 6.5]);
        translate([-0.02, 0.65, 15]) cube([6.5, 3.4, 6.5]);
    }
}

module door_handle() {
    rotate([180, -90, 0]) translate([-153, -188, -10]) import("STLs_to_mod/Door_Handle_x1.STL");
}

$fn = 80;
door_latch();
//door_handle();