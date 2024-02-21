use <extrusion.scad>;
use <hardware.scad>;
use <printhead.scad>;
include <params.scad>;

$fn=10;

module gantry() {
    // TODO Idlers
    translate([-10, -13, 5]) l_idler();
    translate([EXTRUSION_LEN, -13, 5]) r_idler();
    
    // A drive block
    translate([-10, EXTRUSION_LEN-MOTOR_SIZE-3, 5]) drive_block();
    // B drive block
    translate([EXTRUSION_LEN+10, EXTRUSION_LEN-MOTOR_SIZE-3, 5]) scale([-1, 1, 1]) drive_block();
    
    y_axis_pos = 0.9;
    
    // x axis extrusion
    translate([0, 5+100*y_axis_pos, 20]) x_axis();
    
    // Y-axis rails
    translate([0, 10, 0]) rotate([90, 0, 90]) mgn5_rail(100, y_axis_pos);
    translate([EXTRUSION_LEN, 10, 0]) rotate([-90, 0, 90]) mgn5_rail(100, y_axis_pos);
    
    // Top extrusions
    translate([-5, -3, 36]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
    translate([EXTRUSION_LEN+5, -3, 36]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
}

module l_idler() {
    // Top belt
    // Top half
    color(MAIN) difference() {
        //translate([0, 0, 26]) cube([10, 23, 43-26]);
        hull() {
            translate([0, 0, 20]) cube([10, /*23*/17, 43-27]);
            translate([0, 17, 20]) cube([1.5, 6, 43-27]);
        }
        
        // Bolt holes
        // Front screw (M3)
        translate([5, 5, -5]) cylinder(r=1.7, h=100);
        translate([5, 5, 24]) cylinder(r=3, h=100);
        // Rear screw (maybe M3)
        translate([5, 15, -5]) cylinder(r=1.7, h=100);
        translate([5, 15, 24]) cylinder(r=3, h=100);
        
        // top extrusion hole (M3)
        translate([5, -0.01, 31]) rotate([-90, 0, 0]) cylinder(r=1.7, h=20);
        
        // Extrusion spot
        translate([-0.01, 10, 26]) cube([11, 24, 12]);
        
        // Idler cam slot
        translate([5, -0.01, 31]) rotate([-90, 0, 0]) cylinder(r=4, h=8);
    }
    
    // Bottom half
    color(MAIN) difference() {
        hull() {
            translate([0, 0, 0]) cube([10, /*23*/17, 19.98]);
            translate([0, 17, 0]) cube([1.5, 6, 19.98]);
        }
        
        // Bolt holes
        translate([5, 5, -5]) cylinder(r=1.7, h=100);
        translate([5, 15, -5]) cylinder(r=1.7, h=100);
        
        // Bearing stack space
        translate([-1, -1, 13.001]) cube([12, 11, 7]);
        
        // Belt spaces
        translate([-0.01, 9.99, 12.99]) cube([2, 14, 7]);
        translate([7.99, 9.99, 12.99]) cube([2.1, 14, 7]);
    }
    // Belt stacks are centred in the space starting 1mm up from the bottom of the idler (i.e. the carriage overhang)
    // Space is thus 32mm from top to bottom.
    // Given that bearing stacks are 9mm each,
    translate([5, 5, 13]) bearing_stack();
}

module r_idler() {
    // Bottom belt
    // Top half
    color(MAIN) difference() {
        //translate([0, 0, 17]) cube([10, 23, 43-17]);
        
        hull() {
            translate([0, 0, 13]) cube([10, /*23*/17, 36-13]);
            translate([8.5, 17, 13]) cube([1.5, 6, 36-13]);
        }
        
        // Bolt holes
        // Front screw (M3)
        translate([5, 5, -5]) cylinder(r=1.7, h=100);
        translate([5, 5, 24]) cylinder(r=3, h=100);
        // Rear screw (maybe M3)
        translate([5, 15, -5]) cylinder(r=1.7, h=100);
        translate([5, 15, 24]) cylinder(r=3, h=100);
        
        // top extrusion hole (M3)
        translate([5, -0.01, 31]) rotate([-90, 0, 0]) cylinder(r=1.7, h=20);
        
        // Extrusion spot
        translate([-0.01, 10, 26]) cube([11, 24, 12]);
        
        // Idler cam slot
        translate([5, -0.01, 31]) rotate([-90, 0, 0]) cylinder(r=4, h=8);
    }
    
    // Bottom half
    color(MAIN) difference() {
        //translate([0, 0, 0]) cube([10, 23, 17]);
        hull() {
            translate([0, 0, 0]) cube([10, /*23*/17, 13]);
            translate([8.5, 17, 0]) cube([1.5, 6, 13]);
        }
        
        // Bolt holes
        translate([5, 5, -5]) cylinder(r=1.7, h=100);
        translate([5, 15, -5]) cylinder(r=1.7, h=100);
        
        // Bearing stack space
        translate([-1, -1, 6.001]) cube([12, 11, 7]);
        
        // Belt spaces
        translate([-0.01, 9.99, 5.99]) cube([2, 14, 10]);
        translate([7.99, 9.99, 5.99]) cube([2.1, 14, 10]);
    }
    // Belt stacks are centred in the space starting 1mm up from the bottom of the idler (i.e. the carriage overhang)
    // Space is thus 32mm from top to bottom.
    // Given that bearing stacks are 9mm each, 
    translate([5, 5, 6]) bearing_stack();
}

module x_axis() {
    translate([0, MGN5_CARR_LEN-8, -4]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
    
    x_pos = 0.185;
    
    // Rail
    rail_len = 120;
    translate([(EXTRUSION_LEN-rail_len)/2, MGN5_CARR_LEN-8, 1]) mgn5_rail(rail_len, x_pos);
    
    // X-Y joints
    translate([6, -3, -26]) l_xy_joint();
    translate([EXTRUSION_LEN-6, -3, -26]) r_xy_joint();
    
    // Carriage
    color(MAIN) translate([(EXTRUSION_LEN-rail_len)/2 + rail_len*x_pos - MGN5_CARR_LEN/2, -5, 9]) carriage();
    
    // Printhead
    //translate([EXTRUSION_LEN/2-rail_len/2 +rail_len*x_pos, -15.5, -13]) micro_toolhead();
    translate([EXTRUSION_LEN/2-rail_len/2 +rail_len*x_pos, -19, 12]) toolhead();
}

module l_xy_joint() {
    // carriage/bottom piece
    color(MAIN) difference() {
        union() {
            cube([3, MGN5_CARR_LEN, 12+5]);
            
            
            translate([2, MGN5_CARR_LEN/3, 0]) cube([2, MGN5_CARR_LEN/3.5, 12]);
        
            hull() {
                translate([-14, 0, 12]) cube([14, MGN5_CARR_LEN, 5]);
                translate([-5.5, -6, 12]) cube([8.5, 6, 5]);
            }
            
           translate([-6, 6, 14]) cube([(EXTRUSION_LEN-120)/2, 10, 3]);
            
        }
        
        // Carriage screw holes (M2)
        // Bottom screw
        translate([-0.01, MGN5_CARR_LEN/2, 2]) rotate([0, 90, 0]) cylinder(r=1.2, h=100);
        translate([4, MGN5_CARR_LEN/2, 2]) rotate([0, 90, 0]) cylinder(r=1.8, h=100);
        // Top screw
        translate([-0.01, MGN5_CARR_LEN/2, 10]) rotate([0, 90, 0]) cylinder(r=1.2, h=100);
        translate([4, MGN5_CARR_LEN/2, 10]) rotate([0, 90, 0]) cylinder(r=1.8, h=100);
        
        // Bearing stack screw holes
        translate([-11, MGN5_CARR_LEN - 10 + 2.5, -10]) cylinder(r=2.4, h=100);
        translate([-11 + 7 + 1.5, MGN5_CARR_LEN - 10 + 2.5 - 7 - 1, -10]) cylinder(r=2.4, h=100);
        
        // Extrusion screw hole
        translate([-11 + 7 + 1.5 + 8, MGN5_CARR_LEN - 5, -10]) cylinder(r=1.7, h=100);
        translate([-11 + 7 + 1.5 + 8, MGN5_CARR_LEN - 5, 13.99]) cylinder(r=3, h=1.51);
    }
    
    // Top piece
    color(MAIN) difference() {
        union() {
           translate([-6, 6, 27]) cube([(EXTRUSION_LEN-120)/2, 10, 9.5]);
            
            hull() {
                translate([-14, 0, 31]) cube([17, MGN5_CARR_LEN, 5.5]);
                translate([-5.5, -6, 31]) cube([8.5, 6, 5.5]);
            }
        }
        
        // Screw holes
        translate([-11, MGN5_CARR_LEN - 10 + 2.5, -10]) cylinder(r=1.7, h=100);
        translate([-11, MGN5_CARR_LEN - 10 + 2.5, 33]) cylinder(r=3, h=10);
        
        translate([-11 + 7 + 1.5, MGN5_CARR_LEN - 10 + 2.5 - 7 - 1, -10]) cylinder(r=1.7, h=100);
        translate([-11 + 7 + 1.5, MGN5_CARR_LEN - 10 + 2.5 - 7 - 1, 33]) cylinder(r=3, h=10);
        
        // Extrusion top holes
        translate([-11 + 7 + 1.5 + 8, MGN5_CARR_LEN - 5, -10]) cylinder(r=1.7, h=100);
        translate([-11 + 7 + 1.5 + 8, MGN5_CARR_LEN - 5, 33-.5]) cylinder(r=3, h=10);
    }
    
    // Bearing stacks
    translate([-11, MGN5_CARR_LEN - 10 + 2.5, 17]) bearing_stack();
    translate([-11 + 7 + 1.5, MGN5_CARR_LEN - 10 + 2.5 - 7 - 1, 17+7]) bearing_stack();
    
    // Spacers
    translate([-11, MGN5_CARR_LEN - 10 + 2.5, 17+7]) spacer();
    translate([-11 + 7 + 1.5, MGN5_CARR_LEN - 10 + 2.5 - 7 - 1, 17]) spacer();
}

module r_xy_joint() {
    scale([-1, 1, 1]) l_xy_joint();
}

module drive_block() {
    // Motor blockout
    translate([12, 10, -55]) cube([MOTOR_SIZE, MOTOR_SIZE, 55]);
    
    // Top half
    color(MAIN) translate([0, 0, -6]) difference() {
        union() {
            translate([0, 2, 26]) cube([55, MOTOR_SIZE+8, 6]);
            translate([0, MOTOR_SIZE, 32]) cube([10, 10, 10]);
        }
        
        // Alignment cut
        translate([12, 3, 25.5]) cube([25, 6, 4.5]);
        
        // Motor clamp screw holes
        for (x = [0,26.1]) {
            for (y = [-13.05, 13.05]) {
                // Screw head gap
                hull() {
                    translate([10+3.5+x, 10 + MOTOR_SIZE/2 + y, 29]) cylinder(r=3.2, h=100);
                    translate([10+7+x, 10 + MOTOR_SIZE/2 + y, 29]) cylinder(r=3.2, h=100);
                }
                
                // Screw body gap
                hull() {
                    translate([10+3.5+x, 10 + MOTOR_SIZE/2 + y, 20]) cylinder(r=1.7, h=100);
                    translate([10+7+x, 10 + MOTOR_SIZE/2 + y, 20]) cylinder(r=1.7, h=100);
                }
            }
        }
        
        // Toothed pulley hole
        hull() {
            translate([24, 10+MOTOR_SIZE/2, 20]) cylinder(r=10, h=100);
            translate([33, 10+MOTOR_SIZE/2, 20]) cylinder(r=10, h=100);
        }
        
        // Bearing stack screw holes
        translate([5, MOTOR_SIZE+5, 29])cylinder(r=3.5, h=100);
        translate([5, MOTOR_SIZE+5, 20]) cylinder(r=1.7, h=100);
        translate([5, MOTOR_SIZE+5-22.5, 29]) cylinder(r=3, h=100);
        translate([5, MOTOR_SIZE+5-22.5, 20]) cylinder(r=1.7, h=100);
        
        // Extrusion screw hole
        translate([5, MOTOR_SIZE+1.5, 37]) rotate([-90, 0, 0]) cylinder(r=3.5, h=100);
        translate([5, MOTOR_SIZE-2, 37]) rotate([-90, 0, 0]) cylinder(r=1.7, h=100);
        
        // Thread insert hole
        translate([5, MOTOR_SIZE+5, 30]) rotate([-90, 0, 0]) cylinder(r=2.4, h=7);

        // Connecting screw holes
        translate([5, 5, 29]) cylinder(r=3, h=100);
        translate([5, 5, 20]) cylinder(r=1.7, h=100);
        translate([47, 5, 29]) cylinder(r=3, h=100);
        translate([47, 5, 20]) cylinder(r=1.7, h=100);
        
        translate([50, MOTOR_SIZE/2 + 10 - 14.05, -1]) cylinder(r=1.7, h=100);
        translate([50, MOTOR_SIZE/2 + 10 + 13.05, -1]) cylinder(r=1.7, h=100);
        
    }
    
    
    // Bottom half
    color(MAIN) difference() {
        union() {
            translate([0, 0, 0]) cube([55, MOTOR_SIZE+10, 6]);
            translate([2, 0, 6]) cube([53, 10, 14]);
            translate([55 - 9.5, 0, 6]) cube([9.5, MOTOR_SIZE + 8, 14]); 
            
            // Alignment block
        translate([12.15, 3.15, 19.5]) cube([24.7, 5.7, 4.1]);
        }
        
        // Gantry movement cut
        translate([-1, -0.01, 18]) cube([57, 2, 30]);
        
        // Tensioner screw hole
        // TODO
        screw_size = 11;
        translate([55.01, MOTOR_SIZE/2 + 10 - screw_size/2, 33 - screw_size/2 - 8]) rotate([-90, 0, 90]) hull() {
            translate([0, 0, 0]) cylinder(r=2, h=10);
            translate([screw_size, 0, 0]) cylinder(r=2, h=10);
            translate([0, screw_size, 0]) cylinder(r=2, h=10);
            translate([screw_size, screw_size, 0]) cylinder(r=2, h=10);
            translate([-screw_size/(2*sqrt(3)), screw_size/2, 0]) cylinder(r=2, h=10);
            translate([screw_size + screw_size/(2*sqrt(3)), screw_size/2, 0]) cylinder(r=2, h=10);
        }
        
        // Motor screw holes
        for (x = [0,26.1]) {
            for (y = [-13.05, 13.05]) {
                // Screw body gap
                hull() {
                    translate([10+3.5+x, 10 + MOTOR_SIZE/2 + y, -1]) cylinder(r=1.7, h=100);
                    translate([10+7+x, 10 + MOTOR_SIZE/2 + y, -1]) cylinder(r=1.7, h=100);
                }
            }
        }
        
        // Motor circle bit hole
        hull() {
            translate([24, 10+MOTOR_SIZE/2, -1]) cylinder(r=11.1, h=100);
            translate([33, 10+MOTOR_SIZE/2, -1]) cylinder(r=11.1, h=100);
        }
        
        // Bearing stack screw holes
        translate([5, MOTOR_SIZE+5, -1]) cylinder(r=1.7, h=100);
        translate([5, MOTOR_SIZE+5-22.5, -1]) cylinder(r=1.7, h=100);
        
        // Connecting screw holes
        translate([5, 5, -1]) cylinder(r=1.7, h=100);
        translate([47, 5, -1]) cylinder(r=1.7, h=100);
        
        translate([50, MOTOR_SIZE/2 + 10 - 13.05, -1]) cylinder(r=1.7, h=100);
        translate([50, MOTOR_SIZE/2 + 10 - 13.05, -1]) cylinder(r=2.4, h=10);
        translate([50, MOTOR_SIZE/2 + 10 + 13.05, -1]) cylinder(r=1.7, h=100);
        translate([50, MOTOR_SIZE/2 + 10 + 13.05, -1]) cylinder(r=2.4, h=10);
        
        translate([50, MOTOR_SIZE/2 + 10, -1]) cylinder(r=2.4, h=6);

    }

    // Bearing stacks
    translate([5, MOTOR_SIZE+5, 6]) bearing_stack();
    translate([5, MOTOR_SIZE+5, 6+7]) bearing_stack();
    translate([5, MOTOR_SIZE+5-22.5, 6]) spacer();
    translate([5, MOTOR_SIZE+5-22.5, 6+7]) bearing_stack();

    // Tensioner bolt
    translate([250, -83.5, 20]) rotate([180, 0, 180]) color(ACCENT) import("STLs_to_mod/drive_tension_bolt.stl");
}

module carriage() {
    difference() {
        union() {
            translate([251.5, -30, 151.8]) rotate([-90, 90]) import("STLs_to_mod/carriage.stl");
        
            translate([0, 7, -2]) cube([MGN5_CARR_LEN, 12, 5]);
        }
    
        // Carriage holes
        // TODO Check these
        union() {
            translate([MGN5_CARR_LEN/2, 9, 2]) cylinder(r=1.8, h=100);
            translate([MGN5_CARR_LEN/2, 9, -3]) cylinder(r=1.2, h=100);
            translate([MGN5_CARR_LEN/2, 17, 2]) cylinder(r=1.8, h=100);
            translate([MGN5_CARR_LEN/2, 17, -3]) cylinder(r=1.2, h=100);
        }
        
        // Back of carriage cutoff
        translate([-15, 20, 0]) cube([50, 20, 20]);
        
        // Top side cutoffs
        translate([-20, 7, 0]) cube([20, 50, 50]);
        translate([MGN5_CARR_LEN, 7, 0]) cube([20, 50, 50]);
    }
    
}
gantry();

//$fn = 80;
//r_xy_joint();