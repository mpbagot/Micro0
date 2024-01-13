include <params.scad>;

module deck_panel() {
    minkowski() {
        difference() {
            square([EXTRUSION_LEN, EXTRUSION_LEN-MOTOR_SIZE]);
            
            // Front corners
            square([4, 4]);
            translate([EXTRUSION_LEN - 4, 0]) square([4, 4]);
            
            // Rear space
            translate([EXTRUSION_LEN/2-32.5, EXTRUSION_LEN-MOTOR_SIZE-20]) square([65, 20]);
            translate([EXTRUSION_LEN/2-18, EXTRUSION_LEN-MOTOR_SIZE-26]) square([36, 26]);
            
            // Cable chain hole
            translate([EXTRUSION_LEN/2+32.5, EXTRUSION_LEN-MOTOR_SIZE-16]) square([12, 16]);
        }
        circle(r=1.5);
    }
}

module motor_panel() {
    minkowski() {
        difference() {
            square([EXTRUSION_LEN-25*2-26-3, MOTOR_SIZE-3]);
        
            translate([-1.5, (MOTOR_SIZE-3)/2-3.5]) square([6, 3.5+4]);
            translate([EXTRUSION_LEN-25*2-26-3-3-1.5, (MOTOR_SIZE-3)/2-3.5]) square([6, 3.5+4]);
        }
        
        circle(r=1.5);
    }
}

module screw_hole() {
    hull() {
        translate([-1, 0]) circle(r=1.75);
        translate([1, 0]) circle(r=1.75);
    }
}

module rear_chamber_panel() {
    translate([.5, .5]) difference() {
        square([EXTRUSION_LEN+19, EXTRUSION_LEN-20-1]);
        
        translate([10+EXTRUSION_LEN/2-25, 35]) screw_hole();
        translate([10+EXTRUSION_LEN/2-25, 70]) screw_hole();
        translate([10+EXTRUSION_LEN/2-25, 105]) screw_hole();
        
        translate([10+EXTRUSION_LEN/2+25, 35]) screw_hole();
        translate([10+EXTRUSION_LEN/2+25, 70]) screw_hole();
        translate([10+EXTRUSION_LEN/2+25, 105]) screw_hole();
    }
}

module base_panel() {
    // Outer edges of panel are EXTRUSION_LEN+20 - 14
    difference() {
        hull() {
            translate([10.5, 10.5]) circle(r=10);
            translate([EXTRUSION_LEN - 4.5, 10.5]) circle(r=10);
            translate([10.5, EXTRUSION_LEN - 4.5]) circle(r=10);
            translate([EXTRUSION_LEN - 4.5, EXTRUSION_LEN - 4.5]) circle(r=10);
        }
        
        // Screw holes
        translate([8, 8]) circle(r=1.7);
        translate([EXTRUSION_LEN - 2, 8]) circle(r=1.7);
        translate([8, EXTRUSION_LEN - 2]) circle(r=1.7);
        translate([EXTRUSION_LEN - 2, EXTRUSION_LEN - 2]) circle(r=1.7);
        
    }
}

module back_panel_top() {
    square([EXTRUSION_LEN+5, 36+9.75]);
}

module back_panel_bottom() {
    difference() {
        square([EXTRUSION_LEN+5, EXTRUSION_LEN-9.75]);
    
        // Fan holes
        // Fans are centred under the motors. Thus, they are centred at (EXTRUSION_LEN-45)/2 mm from the bottom
        translate([2.5+EXTRUSION_LEN/2, (EXTRUSION_LEN-45)/2])  union() {
            circle(r=18);
         
            // Screw holes
            translate([16, 16]) circle(r=1.7);
            translate([16, -16]) circle(r=1.7);
            translate([-16, 16]) circle(r=1.7);
            translate([-16, -16]) circle(r=1.7);
        }
        
//        translate([3*EXTRUSION_LEN/4+3, (EXTRUSION_LEN-45)/2]) union() {
//            circle(r=18);
//         
//            // Screw holes
//            translate([16, 16]) circle(r=1.7);
//            translate([16, -16]) circle(r=1.7);
//            translate([-16, 16]) circle(r=1.7);
//            translate([-16, -16]) circle(r=1.7);
//        }
    }
}

module side_panel() {
    square([EXTRUSION_LEN+5, EXTRUSION_LEN+36-8-8]);
}

module door_panel() {
    square([EXTRUSION_LEN+5, EXTRUSION_LEN+36-8]);
}

module tophat_side_panel() {
    square([EXTRUSION_LEN+5, TOPHAT_HEIGHT-8]);
}

module tophat_top_panel() {
    square([EXTRUSION_LEN+5, EXTRUSION_LEN+5]);
}

$fn=40;
back_panel_bottom();