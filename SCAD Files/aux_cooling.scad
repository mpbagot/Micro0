include <params.scad>;
use <clip.scad>;

$fn = 40;

module aux_cooler() {
    translate([0, -2, 37.5]) rotate([90, 0, 0]) fan();
    
    // Back plate
    color(MAIN) translate([-1.5, -5, 40]) back_plate();
    
    // Funnel/front plate
    color(ACCENT) translate([-43.5, -15, -6]) funnel();
    
    // Clip-in base
    color(MAIN) base_clip();
}

module funnel() {
    difference() {
        union() {
            hull() {
                translate([.5, -2, 86]) cube([83, 17, 20]);
                translate([5.5, -2, 106]) cube([73, 14, 5]);
            }
            
            // Front plate piece
            translate([.5, -2, 0]) cube([83, 7, 86]);
        }
        
        // Fan hole
        translate([42.5, 14, 6]) translate([0, -2, 37.5]) rotate([90, 0, 0])  cylinder(d=67, h=14.1);
        
        // Funnel hole
        translate([43.5, 14, 6]) translate([-37, -15, 37.5]) cube([74, 6.1, 60.5]);
        translate([43, 14, 6]) translate([0, -1.4, 37.5]) rotate([90, 0, 0])  cylinder(d=75, h=13.6);
        
        hull() {
            translate([43.5, 14, 6]) translate([-32, -14, 97.5]) cube([64, 5.1, 5.5]);
            translate([43.5, 19, 1]) translate([-37, -14, 83.5]) cube([74, 8, 19.5]);
        }
        hull() {
            translate([43.5, 14, 6]) translate([-37, -17, 97.5]) cube([74, 15.1, .5]);
            translate([43.5, 14, 6]) translate([-32, -17, 97.5]) cube([64, 5.1, 5.5]);
        }
        
        // Rear plate screw holes
        translate([36+84/2, -5.01, -41.01+46]) rotate([-90, 0, 0]) cylinder(h=15, r=1.7);
        translate([-31+84/2, -5.01, -36.01+46]) rotate([-90, 0, 0]) cylinder(h=15, r=1.7);
        translate([-36+84/2, -5.01, 35.01+46]) rotate([-90, 0, 0]) cylinder(h=15, r=1.7);
    }
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

module base_clip() {
    difference() {
        union() {
            translate([-1.5, -5, -10]) rotate([90, 0, 90]) clip(83);
            hull() {
                translate([-83/2-1.5, -15, -7.5]) cube([83, 15, 1.5]);
                translate([-83/2-1.5, -10, -9.5]) cube([83, 10, 2]);
            }
        }
        
        // Screw holes
        translate([-26.5, -5, -20]) cylinder(r=1.7, h=50);
        translate([-26.5, -5, -20]) cylinder(r=3.1, h=12);
        
        translate([23.5, -5, -20]) cylinder(r=1.7, h=50);
        translate([23.5, -5, -20]) cylinder(r=3.1, h=12);
    }
}

$fn=120;
funnel();