include <params.scad>;

$fn = 40;

module filter() {
    translate([0, -2, 37.5]) rotate([90, 0, 0]) fan();
    
    // Back plate
    translate([-1.5, -5, 40]) back_plate();
    
    // Funnel
    translate([-43.5, -15, 80]) funnel();
    
    // Clip-in base
    
    // Front plate
}

module funnel() {
    translate([-1.5, 0, 0]) cube([87, 15, 25]);
}

module back_plate() {
    difference() {
        translate([0, 0, -3]) cube([83, 10, 86], center=true);
        
        // Base mounting insert holes
        translate([0, 0, -46.01]) union() {
            translate([25, 0, 0]) cylinder(h=5, r=2.4);
            translate([-25, 0, 0]) cylinder(h=5, r=2.4);
        }
        
        // Front plate insert holes
        translate([36, -5.01, -41.01]) rotate([-90, 0, 0]) cylinder(h=5, r=2.4);
        translate([-31, -5.01, -36.01]) rotate([-90, 0, 0]) cylinder(h=5, r=2.4);
        translate([-36, -5.01, 35.01]) rotate([-90, 0, 0]) cylinder(h=5, r=2.4);
        
        // Wire hole
        translate([-39, -5.01, -46]) cube([3, 6, 48]);
        
        // Fan body
        translate([1.5, 2.99, -2.5]) rotate([90, 0, 0]) linear_extrude(8) minkowski() {
            circle(r=1);
            _fan_base();
        }
        
        translate([-7.5, -5.01, 30.01]) cube([46.5, 8, 10]);
        
        // Screw holes
        translate([1.5, 3.98, -2.5]) union() {
            translate([-(40)/sqrt(2), -1, (40)/sqrt(2)]) rotate([-90, 0, 0]) cylinder(h=2.03, r1=1.5, r2=3);
            translate([-(40)/sqrt(2), -10, (40)/sqrt(2)]) rotate([-90, 0, 0]) cylinder(h=12.03, r=1.5);
            
            translate([(40)/sqrt(2), -1, -(40)/sqrt(2)]) rotate([-90, 0, 0]) cylinder(h=2.03, r1=1.5, r2=3);
            translate([(40)/sqrt(2), -10, -(40)/sqrt(2)]) rotate([-90, 0, 0]) cylinder(h=12.03, r=1.5);
        }
    }
}

module _fan_base() {
    union() {
        circle(d=75);
        translate([-(46-75/2), 0]) square([46, 78-75/2]);
        difference() {
            hull() {
                translate([(40)/sqrt(2), -(40)/sqrt(2)]) circle(r=4);
                translate([-(40)/sqrt(2), (40)/sqrt(2)]) circle(r=4);
            }
            
            translate([(40)/sqrt(2), -(40)/sqrt(2)]) circle(r=2);
            translate([-(40)/sqrt(2), (40)/sqrt(2)]) circle(r=2);
        }
    }
}

module fan() {
    linear_extrude(8) _fan_base();
    
    color("grey") cylinder(d=63, h=14.1);
}

//$fn = 80;
filter();