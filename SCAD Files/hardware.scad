//$fa = 2;
$fs = 0.5;

include <params.scad>;

module bearing_stack() {
    // Bearing stack total height is 9mm
    color("silver") union() {
    // Bottom shim
    cylinder(h=0.5, r=3);
    // Bottom bearing
    translate([0, 0, 0.5]) cylinder(h=0.8, r=4.05);
    translate([0, 0, 1.3]) cylinder(h=2.2, r=3.5);
    
    // Top bearing
    translate([0, 0, 3.5]) cylinder(h=2.2, r=3.5);
    translate([0, 0, 5.7]) cylinder(h=0.8, r=4.05);
    // Top shim
    translate([0, 0, 6.5]) cylinder(h=0.5, r=3);
    }
}

module spacer() {
    difference() {
        color("orange") cylinder(r=3, h=7);
        
        translate([0, 0, -1]) cylinder(r=1.7, h=50);
    }
}

// Generate a rail of given length, with the carriage at percentage 'pos' along it's length, where pos is between 0 and 1
module mgn5_rail(length, pos) {
    // rail
    // TODO
    color("gray") difference() {
        translate([0, -2.5, 0]) cube([length, 5, 3.6]);
        
        // Screw holes
        for (i = [5:15:length]) {
            translate([i, 0, 3.6-0.8]) cylinder(r=1.8, h=4);
            translate([i, 0, -2]) cylinder(r=1.2, h=10);
        }
    }
    
    // carriage
    difference() {
        translate([length*pos - MGN5_CARR_LEN/2, -6, 1.5]) cube([MGN5_CARR_LEN, 12, 4.5]);
        
        // Screw holes in carriage
        translate([length*pos, 4, 4.5]) cylinder(r=1, h=1.6);
        translate([length*pos, -4, 4.5]) cylinder(r=1, h=1.6);
    }
}

module mgn7_rail(length, pos) {
    // rail
    // TODO
    color("Gray") difference() {
        translate([0, -3.5, 0]) cube([length, 7, 4.8]);
        
        // Screw holes
        for (i = [5:15:length]) {
            translate([i, 0, 3.6-0.8]) cylinder(r=1.8, h=4);
            translate([i, 0, -2]) cylinder(r=1.2, h=10);
        }
    }
    
    // carriage
    difference() {
        translate([length*pos - MGN7_CARR_LEN/2, -8.5, 1.5]) cube([MGN7_CARR_LEN, 17, 6.5]);
        
        // Screw holes in carriage
        translate([length*pos+6.5, 6, 5.5]) cylinder(r=1, h=2.6);
        translate([length*pos+6.5, -6, 5.5]) cylinder(r=1, h=2.6);
        translate([length*pos-6.5, 6, 5.5]) cylinder(r=1, h=2.6);
        translate([length*pos-6.5, -6, 5.5]) cylinder(r=1, h=2.6);
    }
    
}

module st3h_rail(length, pos) {
    // rail
    // TODO
    color("Gray") difference() {
        translate([0, -1.5, 0]) cube([length, 3, 2.6]);
        
        // Screw holes
        for (i = [5:10:length]) {
            translate([i, 0, 3.6-0.8]) cylinder(r=1.8, h=4);
            translate([i, 0, -2]) cylinder(r=.8, h=10);
        }
    }
    
    // carriage
    difference() {
        translate([length*pos - ST3H_CARR_LEN/2, -4, 1]) cube([ST3H_CARR_LEN, 8, 3]);
        
        // Screw holes in carriage
        translate([length*pos+2.75, 0, 2.7]) cylinder(r=1, h=2.6);
        translate([length*pos-2.75, 0, 2.7]) cylinder(r=1, h=2.6);
    }
    
}

module rail_stop() {
    
    // 3mm tall, 10mm wide, 2.2mm hole, and about 6mm deep
    module shape() {
        difference() {
            cube([6, 10, 3]);
            
            translate([0, -sqrt(2), 0]) rotate([0, 0, 45]) cube([2, 2, 5]);
            translate([0, 10-sqrt(2), 0]) rotate([0, 0, 45]) cube([2, 2, 5]);
        }
    }
    difference() {
        hull() {
            shape();
        
            translate([.6, 1, 1.8]) scale([0.8, 0.8, 0.8]) shape();
        }
        
        // Screw hole
        translate([3, 5, -0.01]) cylinder(r=1.1, h=50);
    }
}

module ssr_mount() {
    // 20mm apart, 28.5mm apart
    difference() {
        union() {
            // Base
            hull() {       
                translate([17-14.25, 12.5-10, 0]) cylinder(r=3, h=3);
                translate([17-14.25, 12.5+10, 0]) cylinder(r=3, h=3);
                translate([17+14.25, 12.5-10, 0]) cylinder(r=3, h=3);
                translate([17+14.25, 12.5+10, 0]) cylinder(r=3, h=3);
            }
            
            // Legs
            translate([17-14.25, 12.5-10, 3]) cylinder(r=3, h=5);
            translate([17-14.25, 12.5+10, 3]) cylinder(r=3, h=5);
            translate([17+14.25, 12.5-10, 3]) cylinder(r=3, h=5);
            translate([17+14.25, 12.5+10, 3]) cylinder(r=3, h=5);
        }
        
        // Screw holes
        translate([17-14.25, 12.5-10, -1]) cylinder(r=.8, h=50);
            translate([17-14.25, 12.5+10, -1]) cylinder(r=.8, h=50);
            translate([17+14.25, 12.5-10, -1]) cylinder(r=.8, h=50);
            translate([17+14.25, 12.5+10, -1]) cylinder(r=.8, h=50);
    }
}

translate([-10, 0, 0]) bearing_stack();

mgn5_rail(150, 0.5);

translate([0, 20, 0]) mgn7_rail(150, 0.5);

translate([0, 40, 0]) st3h_rail(150, 0.5);

translate([-10, 15, 0]) rail_stop();

translate([-35, 40, 0]) ssr_mount();