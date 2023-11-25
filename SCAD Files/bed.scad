include <params.scad>;
use <pei_plate.scad>;

$fn = 10;

module bed() {
    // Mini kirigami
    color(MAIN) translate([0, 0, 0]) mini_kirigami();
    
    // Anti-backlash nut holder
    color(ACCENT) translate([0, -21, 0]) t8_nut();
    
    // Springs
    translate([-(BED_X-10)/2, -18, -2]) cylinder(r=4.1, h=20);
    translate([(BED_X-10)/2, -18, -2]) cylinder(r=4.1, h=20);
    translate([0, -BED_Y - 8, -2]) cylinder(r=4.1, h=20);
    
    translate([0, 0, 8]) union() {
        // Bed plate (6mm thick)
        color("silver") translate([0, -13, 0]) translate([-BED_X/2, -BED_Y, 10]) cube([BED_X, BED_Y, 6]);
    
        // Magnet plate
        color("#2f2f2f") translate([-BED_X/2+1, 1-BED_Y-13, 16]) cube([BED_X-2, BED_Y-2, 2]);
    
        // PEI plate
        color("#cF8F00") translate([-BED_X/2, -BED_Y-13, 18])3d_pei();
    }
}

module t8_nut() {
    difference() {
        // Back part
            translate([-14, 13, -5]) cube([28, 1.5, 10]);
        
        // Screw holes
        translate([-10, 0, 0]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([10, 0, 0]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
    }
    
    difference() {
        union() {
            translate([0, 15, 17.5]) rotate([180, 0, -90]) translate([-250, -120, 0]) import("STLs_to_mod/T8_Nut_Block_x1.stl");
        
            
        }
        
        translate([-20, -11, -25]) cube([40, 20, 50]);
        
        translate([-20, -7, -20]) cube([40, 20, 25]);
    }
    
    // Anti-backlash nut example
    //translate([0, 31, 11]) cylinder(r=6.5, h=18.5);
}

module mini_kirigami() {
    // In a given bed, screws are 5 mm in from edges.
    // For 80x80, that means [5, 75], [75, 75], [40, 5]
    translate([0, -8, 0]) difference() {
        translate([0, 0, -5]) linear_extrude(10) {
            polygon([[-BED_X/2-10, 0], [-BED_X/4, -BED_Y-10], [BED_X/4, -BED_Y-10], [BED_X/2+10, 0]]);
        }
        
        // Side cuts
        translate([BED_X/2 + 5, -BED_Y/2 + 0.01, -6]) cube([10, BED_Y/2, 12]);
        translate([-BED_X/2 - 15, -BED_Y/2 + 0.01, -6]) cube([10, BED_Y/2, 12]);
        
        // Middle cutout
        translate([0, -10, -10.01]) scale([0.6, 0.6, 1]) linear_extrude(17) {
            polygon([[-BED_X/2-10, 0], [-BED_X/4, -BED_Y-10], [BED_X/4, -BED_Y-10], [BED_X/2+10, 0]]);
        }
        
        // Screw holes
        translate([0, -5, 0]) union() {
            translate([(BED_X-10)/2, -5, -25]) cylinder(r=1.7, h=50); // Back left
            translate([(BED_X-10)/2, -5, -2]) cylinder(r=4.1, h=50); // Back left
            translate([-(BED_X-10)/2, -5, -25]) cylinder(r=1.7, h=50); // Back right
            translate([-(BED_X-10)/2, -5, -2]) cylinder(r=4.1, h=50); // Back right
            translate([0, -BED_Y + 5, -25]) cylinder(r=1.7, h=50); // Front
            translate([0, -BED_Y + 5, -2]) cylinder(r=4.1, h=50); // Front
        }
        
        // Nut screw holes
        translate([-10, -6, 0]) rotate([-90, 0, 0]) cylinder(r=2.4, h=7);
        translate([10, -6, 0]) rotate([-90, 0, 0]) cylinder(r=2.4, h=7);
        
        // Right block holes
        translate([25+6, -10.01, 8-6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=10.5);
        translate([25-6, -12.01, 8-6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=12.5);
        
        // Left block holes
        translate([-25+6, -10.01, 8-6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=10.5);
        translate([-25-6, -10.01, 8-6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=10.5);
    }
    
    // Chain mount
    // y = 14.5 is the centre of the screws of the chain
    // Screws on cable chain are 8mm apart
    // Cable chain is 13mm wide
    translate([BED_X/2 + 5, 2, 0]) difference() {
        union() {
            translate([10, 0, -5]) cube([8, 16, 18]);
            
            hull() {
                translate([-2, -25, -5]) cube([2, 15, 10]);
                
                translate([10, 0, -5]) cube([8, 8, 18]);
            }
        }
        
        // Cable chain holes
        translate([11.5, 11.5, 8]) rotate([0, 90, 0]) cylinder(r=2.5, h=7);
        translate([11.5, 11.5, 0]) rotate([0, 90, 0]) cylinder(r=2.5, h=7);
    }
    
    
    // Rail mount blocks
    rail_off = 25;
    translate([rail_off, 0, 8]) difference() {
        hull() {
            translate([0, 1, 0]) cube([17, 2, 30.8], center=true);
            translate([0, -11, -5]) cube([17, 2, 15.8], center=true);
        }
        
        // Screw holes
        // Right half
        translate([6, -13, 6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([6, -12.01, 6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
        
        translate([6, -13, -6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([6, -12.01, -6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
        
        // Left half
        translate([-6, -13, 6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([-6, -12.01, 6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
        
        translate([-6, -13, -6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([-6, -12.01, -6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
    }
    
    translate([-rail_off, 0, 8]) difference() {
        hull() {
            translate([0, 1, 0]) cube([17, 2, 30.8], center=true);
            translate([0, -11, -5]) cube([17, 2, 15.8], center=true);
        }
        
        // Screw holes
        translate([6, -13, 6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([6, -12.01, 6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
        
        translate([6, -13, -6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([6, -12.01, -6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
        
        translate([-6, -13, 6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([-6, -12.01, 6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
        
        translate([-6, -13, -6.5]) rotate([-90, 0, 0]) cylinder(r=1.2, h=20);
        translate([-6, -12.01, -6.5]) rotate([-90, 0, 0]) cylinder(r=2.1, h=11.5);
    }
}

//$fn = 80;
//mini_kirigami();
bed();