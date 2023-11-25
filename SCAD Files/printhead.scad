
mount_hole_space = 25;
bottom_to_hole_center = 48;

module toolhead() {
    translate([0, -23.5, 0]) union() {
        translate([0, 23.5, -34]) hotend();
        
        difference() {
            translate([-15.45, 0, 20]) rotate([90, 0, 180]) import("STLs_to_mod/Cowl_NoProbe.stl");
            
            //translate([-40, 28, -25]) cube([80, 20, 30]);
        }
        
        translate([0, 25, 0]) hotend_mount();
        //translate([1, 16, 1]) rotate([90, 0, 180]) import("STLs_to_mod/Dragon_Mount.stl");
    }
}

module hotend_mount() {    
    // Mounting holes are centred 7mm from the centre, along y axis
    difference() {
        union() {
            translate([0, 1.25, 0.5]) cube([53, 20.5, 16.5], center=true);
            translate([-10, -10.25, .5-8.25]) cube([20, 2, 16.5]);
        }
        
        // Side cuts
        translate([-53/2-0.01, 2.3, -10]) cube([10.5, 9.5, 20]);
        translate([-53/2-0.01, -12.4, -16.5/2]) cube([10.5, 29.5, 9.0]);
        translate([53/2-10+0.01, 2.3, -10]) cube([10.5, 9.5, 20]);
        translate([53/2-10+0.01, -12.4, -16.5/2]) cube([10.5, 29.5, 9.0]);
        
        // Side grooves
        translate([53/2-13.3+0.01, -12.4, -16.5/2+3.4]) cube([10.5, 29.5, 6.7-3.4]);
        translate([-53/2+10.5-0.02, -12.4, -16.5/2+3.4]) cube([3.1, 29.5, 6.7-3.4]);
        
        // Back groove
        translate([-10, 10.25, -8.25]) cube([20, 2, 6]);
        
        // Bowden hole
        translate([0, -1.3, -20]) cylinder(r=2.2, h=50);
        
        // Mounting holes
        translate([21.72, -1.3, -20]) cylinder(r=2, h=50);
        translate([-21.7, -1.3, -20]) cylinder(r=2, h=50);
        
        // Hotend mounting holes
        translate([0, 7-1.3, -20]) cylinder(r=.9, h=50);
        translate([0, -7-1.3, -20]) cylinder(r=.9, h=50);
        
        // Front mounting holes
        translate([12.5, -12.3, 1.6]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([-12.5, -12.3, 1.6]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        
        // Fan holes
        translate([12.5, -12.3, -8.25+.5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=8);
        translate([-12.5, -12.3, -8.25+.5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=8);
    }
}

module micro_toolhead() {
    // This thing is stupid.
    // Basically, take the hotend, and push it hard up against a 3010
    rotate([0, 0, 90]) hotend();
    
    // Hotend cooling fan
    translate([0, 2.5, 0]) difference() {
        translate([-15, -10-12, 0]) cube([30, 10, 30]);
        
        translate([-15+2.5, -24, 30-2.5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([15-2.5, -24, 30-2.5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
    }
}

module hotend() {
    difference() {
        cylinder(r=11, h=26);
    
        translate([9.25, -15, -0.01]) cube([3, 30, 30]);
        translate([-3-9.25, -15, -0.01]) cube([3, 30, 30]);
    }
    
    // heatblock
    translate([-8, -11.5+3, -13]) cube([16, 23, 11.5]);
}

//translate([30, 0, 0]) toolhead();
//translate([-30, 0, 0]) micro_toolhead();

$fn = 80;
hotend_mount();