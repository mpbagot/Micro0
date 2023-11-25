use <extrusion.scad>;
use <bed.scad>;
use <hardware.scad>;

include <params.scad>;

module z_axis() {
    // Z axis backing
    translate([0, 0, EXTRUSION_LEN - 5]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
    translate([0, 0, 5]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
    // Vertical part
    translate([EXTRUSION_LEN/2+25, -10, 0]) extrusion(EXTRUSION_LEN);
    translate([EXTRUSION_LEN/2-25, -10, 0]) extrusion(EXTRUSION_LEN);

    // Cable chain bracket
    // Screws on the cable chain are 8mm apart
    translate([EXTRUSION_LEN/2+25+5, -15, 0]) cable_chain_mount();

    // Z motor bracket
    color(ACCENT) translate([0, 0, -4]) z_motor_bracket();

    z_axis_pos = 0.8;

    translate([0, 0, -3.5]) union() {
        // rails
        // TODO
        rail_len = 115;
        translate([EXTRUSION_LEN/2+25, -15, (EXTRUSION_LEN-rail_len)/2]) rotate([90, -90, 0]) mgn7_rail(rail_len, z_axis_pos);
        translate([EXTRUSION_LEN/2-25, -15, (EXTRUSION_LEN-rail_len)/2]) rotate([90, -90, 0]) mgn7_rail(rail_len, z_axis_pos);
        
        // Z endstop
        color(ACCENT) translate([EXTRUSION_LEN/2-30+1, -15-6-1.5, 8.4+2.5]) z_endstop();
        
        // Bed
        translate([EXTRUSION_LEN/2, -25, (EXTRUSION_LEN-rail_len)/2 + rail_len*z_axis_pos - 8]) bed();
    }
}

module cable_chain_mount() {
    HEIGHT = 23;

    difference() {
        cube([5, 10, HEIGHT]);
        
        // Extrusion mount hole
        translate([15, 5, HEIGHT-4]) rotate([0, -90, 0]) cylinder(r=1.6, h=50);
        translate([6, 5, HEIGHT-4]) rotate([0, -90, 0]) cylinder(r=3, h=4);
        
        // Cable chain screws
        translate([15, 3.5, 4]) rotate([0, -90, 0]) cylinder(r=2.4, h=50);
        translate([15, 3.5, 12]) rotate([0, -90, 0]) cylinder(r=2.4, h=50);
    }
}

module z_motor_bracket() {
    $fn = 100;
    
    // Custom implementation
    translate([EXTRUSION_LEN/2-25, -11, 0]) difference() {
        union() {
            // Thin base part
            translate([25, 13, 0]) hull() {
                translate([0, 4, 0]) cylinder(h=2, r=5);
                translate([0, 0, 1]) cube([20, 5, 2], center=true);
            }
            
            // Thicker base part
            hull() {
                cube([50, 16, 4]);
                translate([4, -4, 0]) cylinder(r=4, h=4);
                translate([4+42, -4, 0]) cylinder(r=4, h=4);
                translate([25, -4.5, 0]) cylinder(r=15, h=4);
            }
            
            // Lead screw wrap
            translate([25, -4, 4])  cylinder(r=15.25, h=10);
            
            // Front extrusion block
            translate([5, 2, 4]) cube([40, 4, 10]);
        }
        
        // Lead screw hole
        translate([25, -4, -0.1])  cylinder(r=11.3, h=50);
        
        // Motor screw holes
        translate([25, 18, -0.1]) cylinder(r=1.7, h=50); 
        translate([25, 18, 1.5]) cylinder(r=2.8, h=3);
        translate([3.1, -4, -0.1]) cylinder(r=1.7, h=50);
        translate([46.9, -4, -0.1]) cylinder(r=1.7, h=50);
        
        // Motor screw head
        translate([3.1, -4, 1.9]) cylinder(r=2.5, h=50);
        translate([46.9, -4, 1.9]) cylinder(r=2.5, h=50);
        
        // Bottom extrusion bolt-in
        translate([7, 11, -0.1]) cylinder(r=1.7, h=50);
        translate([43, 11, -0.1]) cylinder(r=1.7, h=50);
        
        // Cylinder cut
        translate([25, 20, 10]) cube([22.6, 50, 12], center=true);
        
        // Extrusion cut
        translate([5, 6, 4]) cube([40, 10, 10]);
        
        // Front extrusion bolt holes
        translate([11, -20, 9]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([11, -20, 9]) rotate([-90, 0, 0]) cylinder(r=2.5, h=24.5);
        translate([39, -20, 9]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([39, -20, 9]) rotate([-90, 0, 0]) cylinder(r=2.5, h=24.5);
        
        // Endstop cut
        translate([9, -18, 8]) cube([4, 20, 10]);
        translate([37, -18, 8]) cube([4, 20, 10]);
        
        // Angle cut
        translate([0, -20, 5.2]) rotate([33, 0, 0]) cube([50, 50, 20]);
    }
    
    //translate([EXTRUSION_LEN/2, -15, -17]) z_motor();
}

module z_motor() {
    color("gray") rotate([0, 0, 45]) cube([42, 42, 34], center=true);
    translate([0, 0, 17]) color("darkgray") cylinder(r=4, h=EXTRUSION_LEN);
}

module z_endstop() {
    $fn = 50;
    
    // Switch block
    /*
    difference() {
        union() {
            cube([13, 6, 6.6]);
            translate([8.2, (6-2.7)/2, 6.6]) cube([1.2, 2.7, 1.2]);
        }
        
        // Screw holes
        // Each screw hole is 2.5mm diameter, centred 3.25mm from middle
        translate([6.5+3.25, -1, 6.6-4.-1.25]) rotate([-90, 0, 0]) cylinder(r=1.25, h=100);
        translate([6.5-3.25, -1, 6.6-4.-1.25]) rotate([-90, 0, 0]) cylinder(r=1.25, h=100);
    }
    */
    // Endstop body
    difference() {
        union() {
            difference() {
                translate([-3, -2, 0]) cube([17, 17.5+2, 18]);
                // Extrusion cut
                translate([-1, 7, -2]) cube([10, 14, 50]);
            }
            
            // Extrusion nub tabs
            translate([-1, 7.5+5-1.35, 0]) cube([0.5, 2.7, 18]);
            translate([8.5, 7.5+5-1.35, 0]) cube([0.5, 2.7, 18]);
        }
        
        // Upper cut
        translate([-3.1, -2.01, 6.59]) cube([17.5, 9.55, 30]);
        
        // Switch cut
        translate([-1.01, -0.01, -0.01]) cube([14, 6+1.55, 30]);
        
        // Screw holes
        // Each screw hole is 2.5mm diameter, centred 3.25mm from middle
        translate([6.5+3.25, -12, 6.6-4.-1.25]) rotate([-90, 0, 0]) cylinder(r=.75, h=35);
        translate([6.5-3.25, -12, 6.6-4.-1.25]) rotate([-90, 0, 0]) cylinder(r=.75, h=15);
        
        // Eye brows
        translate([6.5-3.25, -2.01, 3.5]) rotate([0, 15, 0]) cube([3.5, .5, .5], center=true);
        translate([6.5+3.25, -2.01, 3.5]) rotate([0, -15, 0]) cube([3.5, .5, .5], center=true);
        
        // Slanted sections
        translate([-3.01, 10, 0]) rotate([-45, 0, 0]) cube([20, 20, 20]);
        translate([-3.01, 16, 18]) rotate([-45, 0, 0]) cube([20, 20, 20]);
        translate([-3.01, 7, 16]) rotate([45, 0, 0]) cube([20, 20, 20]);
        
        // Side bolt holes
        translate([-4, 7.5+5, 13]) rotate([0, 90, 0]) cylinder(r=1.7, h=50);
    }
}


//$fn=80;
//cable_chain_mount();
z_axis();