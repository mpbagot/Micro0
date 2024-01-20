include <params.scad>;

FEET_HEIGHT = 40;

module skirts() {
    // Display blockout
    translate([(EXTRUSION_LEN+20)/2-42.25, -17, -FEET_HEIGHT]) cube([84.5, 25, FEET_HEIGHT]);
    
    // Front skirts
    translate([22, 0, -FEET_HEIGHT]) front_skirt_assembly(true);
    
    translate([EXTRUSION_LEN-2, 0, -FEET_HEIGHT]) scale([-1, 1, 1]) front_skirt_assembly(false);
    
    // Side skirts
    translate([0, 22, -FEET_HEIGHT])  side_skirt();
    
    translate([EXTRUSION_LEN+20, 22, -FEET_HEIGHT]) scale([-1, 1, 1]) side_skirt();
    
    // Rear skirt
    translate([(51-1.7*2 + 17+5), EXTRUSION_LEN+10, -FEET_HEIGHT]) rear_skirt();
}

module feet() {
    // Left-front foot
    translate([0, 0, -FEET_HEIGHT]) f_foot();
    // Right-front foot
    translate([EXTRUSION_LEN + 20, 0, -FEET_HEIGHT]) scale([-1, 1, 1]) f_foot();
    // Right-rear foot
    translate([EXTRUSION_LEN-2, EXTRUSION_LEN-2, -FEET_HEIGHT]) rr_foot();
    // Left-rear foot + socket
    translate([0, EXTRUSION_LEN - 2, -FEET_HEIGHT]) rl_foot();
    
    // rubber feet
    translate([15, 15, -FEET_HEIGHT-0.5-10]) rubber_foot();
    translate([EXTRUSION_LEN+5, 15, -FEET_HEIGHT-0.5-10]) rubber_foot();
    translate([15, EXTRUSION_LEN+5, -FEET_HEIGHT-0.5-10]) rubber_foot();
    translate([EXTRUSION_LEN+5, EXTRUSION_LEN+5, -FEET_HEIGHT-0.5-10]) rubber_foot();
}

module rubber_foot() {
    difference() {
        cylinder(h=10, r1=6, r2=8);
        
        // Screw hole
        translate([0, 0, -2]) cylinder(h=50, r=1.8);
        translate([0, 0, -2]) cylinder(h=2+7, r=3.4);
    }
}

module side_skirt() {
    color(MAIN) side_skirt_body();
    
    color(ACCENT) translate([7, 0, 0]) side_skirt_backing();
}

module side_skirt_backing() {
    difference() {
        translate([0, 0, 2.5]) cube([3, EXTRUSION_LEN-24, FEET_HEIGHT-2.5]);
        
        // Screw holes
        for (i=[1:4]) {
            translate([-2, i*(EXTRUSION_LEN-24)/5, -2]) cylinder(r=3, h=FEET_HEIGHT);
        }
        
        // Alternated cuts
        cut_count = 14;
        intersection() {
            union() {
                for (x=[0:cut_count/2-1]) {
                    translate([-1, x*(EXTRUSION_LEN-24)/15-10, FEET_HEIGHT/10+FEET_HEIGHT*sqrt(3)/2]) rotate([30, 0, 0]) translate([0, 0, 0-FEET_HEIGHT]) cube([20, 4, FEET_HEIGHT*2]);
                }
                for (x=[0:cut_count/2-1]) {
                    translate([-1, (EXTRUSION_LEN-14)-x*(EXTRUSION_LEN-24)/15, FEET_HEIGHT/10+FEET_HEIGHT*sqrt(3)/2]) rotate([-30, 0, 0]) translate([0, -4, 0-FEET_HEIGHT]) cube([20, 4, FEET_HEIGHT*2]);
                }
            }
            
            // Cube
            translate([-1, 5, FEET_HEIGHT/10]) cube([9, EXTRUSION_LEN-34, FEET_HEIGHT*4/5]);
        }
        
    }
}

module side_skirt_body() {
    difference() {
        cube([6.5, EXTRUSION_LEN-24, FEET_HEIGHT]);
        
        // Screw holes
        for (i=[1:4]) {
            translate([5, i*(EXTRUSION_LEN-24)/5, -2]) cylinder(r=3, h=FEET_HEIGHT);
            translate([5, i*(EXTRUSION_LEN-24)/5, 5]) cylinder(r=1.7, h=FEET_HEIGHT);
        }
        
        // Angled cuts
        cut_count = 14;
        intersection() {
            union() {
                for (x=[0:cut_count/2-1]) {
                    translate([-1, 10+x*(EXTRUSION_LEN-24)/15, FEET_HEIGHT/10+FEET_HEIGHT*sqrt(3)/2]) rotate([-30, 0, 0]) translate([0, 0, 0-FEET_HEIGHT]) cube([20, 4, FEET_HEIGHT*2]);
                }
                for (x=[0:cut_count/2-1]) {
                    translate([-1, (EXTRUSION_LEN-34)-x*(EXTRUSION_LEN-24)/15, FEET_HEIGHT/10+FEET_HEIGHT*sqrt(3)/2]) rotate([30, 0, 0]) translate([0, -4, 0-FEET_HEIGHT]) cube([20, 4, FEET_HEIGHT*2]);
                }
            }
            
            // Cube
            translate([-1, 5, FEET_HEIGHT/10]) cube([9, EXTRUSION_LEN-34, FEET_HEIGHT*4/5]);
        }
    }
}

module front_skirt_assembly(cable_hole) {
    color(ACCENT) translate([0, -0.01, 0]) front_skirt_insert(cable_hole);
    color(MAIN) front_skirt(cable_hole);
}

module front_skirt(cable_hole) {
    skirt_width = (EXTRUSION_LEN+20-84.5-22-22)/2;
    difference() {
        _front_skirt(cable_hole);
        
        // Angled piece
        union() {
            translate([skirt_width-0.2, 0, 0]) rotate([0, -27.5, 0]) cube([100, 7.2, FEET_HEIGHT*2]);
            translate([skirt_width/1.5+3-0.2, 0, -5]) rotate([0, -27.5, 0]) cube([3.4, 7.2, FEET_HEIGHT*2]);
        }
    }
}


module front_skirt_insert(cable_hole) {
    skirt_width = (EXTRUSION_LEN+20-84.5-22-22)/2;
    intersection() {
        _front_skirt(cable_hole);
        
        // Angled piece
        union() {
            translate([skirt_width, 0, 0]) rotate([0, -27.5, 0]) cube([100, 7, FEET_HEIGHT*2]);
            translate([skirt_width/1.5+3, 0, -5]) rotate([0, -27.5, 0]) cube([3, 7, FEET_HEIGHT*2]);
            
        }
    }
}

module _front_skirt(cable_hole) {
    skirt_width = (EXTRUSION_LEN+20-84.5-22-22)/2;
    difference() {
        cube([skirt_width, 10, FEET_HEIGHT]);
    
        // Front rounding
        hull() {
            off = 7;
            translate([-3, 0, off]) sphere(r=5);
            translate([-3, 0, FEET_HEIGHT-off]) sphere(r=5);
            translate([30, 0, off]) sphere(r=5);
            translate([30, 0, FEET_HEIGHT-off]) sphere(r=5);
        }
        
        // Base plate cut
        translate([-10, 7, -0.01]) cube([200, 10, 2.5]);
        translate([-10, 7-5*sqrt(3)/2, -0.01]) rotate([-60, 0, 0]) cube([200, 10, 5]);
        
        // Screw hole
        translate([skirt_width/2, 5, FEET_HEIGHT*7/8])  hull() {
            cylinder(r=3, h=FEET_HEIGHT*1/8-2);
            
            translate([0, 0, -5]) sphere(r=1);
        }
        translate([skirt_width/2, 5, FEET_HEIGHT*4/5]) cylinder(r=1.7, h=FEET_HEIGHT);
        
        // Cable hole
        // TODO
        if (cable_hole) {
            translate([skirt_width - 10, 0, 0]) cube([11, 12, 12.50]);
        }
    }
}

module rear_skirt() {
    PIECE_WIDTH = EXTRUSION_LEN-12-(51-1.7*2 + 17+5-10);
    color(MAIN) difference() {
        cube([PIECE_WIDTH, 10, FEET_HEIGHT]);
    
        // Bottom panel cut
        translate([-1, -0.01, -0.01]) cube([PIECE_WIDTH+2, 3, 2.5]);
    
        // Insert cutout
        translate([-10, 5.01, 0]) rotate([0, 55, 0]) translate([-60, 0, 0]) cube([60, 5, FEET_HEIGHT*3]);
        translate([0, 5.01, 0]) rotate([0, 55, 0]) cube([6, 5, FEET_HEIGHT*3]);
        translate([-1, -0.01, FEET_HEIGHT/2]) cube([50, 5.03, FEET_HEIGHT/2+0.02]);
        translate([49, -0.01, FEET_HEIGHT/2]) rotate([0, 55, 0]) translate([-20, 0, 0]) cube([20, 5.03, FEET_HEIGHT+0.02]);
        
        // Screw cutouts
        hull() {
            translate([0, 2, FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=1.7, h=100);
            
            translate([0, -1, FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=1.7, h=100);
        }
        hull() {
            translate([1, 2, FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=3, h=PIECE_WIDTH-2);
            
            translate([1, -1, FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=3, h=PIECE_WIDTH-2);
        }
        
        hull() {
            translate([0, 2, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=1.7, h=100);
            
            translate([0, -1, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=1.7, h=100);
        }
        hull() {
            translate([1, 2, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=3, h=PIECE_WIDTH-2);
            
            translate([1, -1, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=3, h=PIECE_WIDTH-2);
        }
    }
    
    // The insert piece
    color(ACCENT) rear_skirt_insert();
}

module rear_skirt_insert() {
    PIECE_WIDTH = EXTRUSION_LEN-12-(51-1.7*2 + 17+5-10);
    difference() {
        intersection() {
            translate([0, 0.5, 0]) cube([PIECE_WIDTH, 9.1, FEET_HEIGHT-0.2]);
        
            // Insert cutout
            union() {
                translate([-10.3, 5.01, 0]) rotate([0, 55, 0]) translate([-60, 0, 0]) cube([60, 4, FEET_HEIGHT*3]);
            translate([0.2, 5.01, 0]) rotate([0, 55, 0]) cube([5.6, 4, FEET_HEIGHT*3]);
            translate([-1, -0.01, FEET_HEIGHT/2+0.2]) cube([50, 5.03, FEET_HEIGHT/2+0.02]);
            translate([49, -0.01, FEET_HEIGHT/2+0.2]) rotate([0, 55, 0]) translate([-20, 0, 0]) cube([20, 5.03, FEET_HEIGHT+0.02]);
            }
        }
        
        // Screw cutout
        hull() {
            translate([0, 2, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=1.7, h=100);
            
            translate([0, -1, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=1.7, h=100);
        }
        hull() {
            translate([1, 2, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=3, h=PIECE_WIDTH-2);
            
            translate([1, -1, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=3, h=PIECE_WIDTH-2);
        }
    }
}

module f_foot() {
    color(MAIN) difference() {
        union() {
            cube([22, 22, FEET_HEIGHT]);
            
            // Extrusion groove alignment nubs
            translate([12, 3.7, FEET_HEIGHT]) cube([5, 2.4, 1.2]);
            translate([3.7, 12, FEET_HEIGHT]) cube([2.4, 5, 1.2]);
        }
        
        // Front rouding
        hull() {
            off = 7;
            translate([10, 0, off]) sphere(r=5);
            translate([10, 0, FEET_HEIGHT-off]) sphere(r=5);
            translate([30, 0, off]) sphere(r=5);
            translate([30, 0, FEET_HEIGHT-off]) sphere(r=5);
        }
        
        // Interior cut
        translate([12, 12, 10.01]) cube([12, 12, FEET_HEIGHT-10]);
        
        // Base plate cut
        hull() {
            translate([17, 17, -0.01]) cylinder(r=10, h=2.5);
            translate([30, 17, -0.01]) cylinder(r=10, h=2.5);
            translate([17, 30, -0.01]) cylinder(r=10, h=2.5);
        }
        // Base plate thread insert
        translate([15, 15, 1]) cylinder(r=2.4, h=7);
        
        // Corner extrusion screw
        translate([5, 5, -0.01]) cylinder(r=1.7, h=FEET_HEIGHT+5);
        translate([5, 5, -0.01]) cylinder(r=3, h=3);
    }
}


module rr_foot() {
    color(MAIN) difference() {
        union() {
            cube([22, 22, FEET_HEIGHT]);
            
            // Extrusion groove alignment nubs
            translate([15.9, 5, FEET_HEIGHT]) cube([2.4, 5, 1.2]);
            
            // Bowden collet piece
            translate([4.5+4.83, 4.5+1.294, FEET_HEIGHT/2]) rotate([90, 0, -75]) cylinder(r=6, h=15);
        }
        
        // Base plate cut
        hull() {
            translate([5, 5, -0.01]) cylinder(r=10, h=2.5);
            translate([-8, 5, -0.01]) cylinder(r=10, h=2.5);
            translate([5, -8, -0.01]) cylinder(r=10, h=2.5);
        }
        // Base plate thread insert
        translate([7, 7, -1]) cylinder(r=2.4, h=7);
        
        // Corner extrusion screw
        translate([17, 17, -0.01]) cylinder(r=1.7, h=FEET_HEIGHT+5);
        translate([17, 17, -0.01]) cylinder(r=3, h=3);
        
        // Bowden collet hole
        translate([0.606, 3.4567, FEET_HEIGHT/2]) rotate([90, 0, -75]) cylinder(r=4.4, h=6);
        translate([0.337, 3.3845, FEET_HEIGHT/2]) rotate([90, 0, 105]) cylinder(r=2.4, h=60);
        //translate([23, 10.3, FEET_HEIGHT/2]) rotate([0, -90, 0]) cylinder(r=2.4, h=13.7);
        
        // Thread insert holes
        translate([-.01, 22-8, FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=2.4, h=6);
        translate([-.01, 22-8, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=2.4, h=6);
    }
}

module rl_foot() {
    color(MAIN) difference() {
        union() {
            cube([51-1.7*2 + 17+5, 22, FEET_HEIGHT]);
            
            // Socket surround
            hull() {
                translate([10, -MOTOR_SIZE+12, FEET_HEIGHT-15]) cube([51-1.7*2 + 17+5-10, 10, 15]);
                translate([10, , 0, 2.5]) cube([51-1.7*2 + 17+5-10, 22, FEET_HEIGHT-2.5]);
            }
            
            // Horizontal extrusion screw triangles
            translate([10, -MOTOR_SIZE+22, FEET_HEIGHT]) cube([10, 10, 10]);
            translate([50, -MOTOR_SIZE+22, FEET_HEIGHT]) cube([10, 10, 10]);
            
            // Extrusion groove alignment nubs
            translate([3.7, 5, FEET_HEIGHT]) cube([2.4, 5, 1.2]);
        }
        
        // Cutout to make space for z motor mount
        translate([51-1.7*2 + 17+5-10+.01, -25, .01]) cube([10, 15, FEET_HEIGHT]);
        
        // Horizontal extrusion screw triangles cut
        translate([0, -MOTOR_SIZE+22, FEET_HEIGHT + 10]) rotate([-45, 0, 0]) cube([100, 10*sqrt(2), 10]);
        
        
        // Horizontal extrusion screw triangles screw holes
        translate([15, -40, FEET_HEIGHT + 5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=100);
        translate([15, -MOTOR_SIZE + 24+1.5, FEET_HEIGHT + 5]) rotate([-90, 0, 0]) cylinder(r=3, h=100);
        translate([55, -40, FEET_HEIGHT + 5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=100);
        translate([55, -MOTOR_SIZE + 24+1.5, FEET_HEIGHT + 5]) rotate([-90, 0, 0]) cylinder(r=3, h=100);
        
        // Socket cutout
        // TODO Socket size?
        translate([17, -30, (FEET_HEIGHT - 31.2+1.7*2)/2]) cube([51-1.7*2, 100, 31.2-1.7*2]);
        
        // Socket tab cutouts
        // Tabs are recessed 1.5mm from outer edge
        // Tabs are 10mm wide
        // Tabs are 6mm front to back
        translate([17+6, 22-6-.8, -30]) cube([10, 6, 31.2-1.7*2 + 60]);
        translate([51-1.7*2+17-6-10, 22-6-.8, -10]) cube([10, 6, 31.2-1.7*2 + 60]);
        
        // Base plate cut
        hull() {
            translate([17, 5, -0.01]) cylinder(r=10, h=2.5);
            translate([130, 5, -0.01]) cylinder(r=10, h=2.5);
            translate([17, -8, -0.01]) cylinder(r=10, h=2.5);
        }
        // Base plate thread insert
        translate([15, 7, -1]) cylinder(r=2.4, h=7);
        
        // Corner extrusion screw
        translate([5, 17, -0.01]) cylinder(r=1.7, h=FEET_HEIGHT+5);
        translate([5, 17, -0.01]) cylinder(r=3, h=3);
        
        // Thread insert holes
        translate([51-1.7*2 + 17-.99, 22-8, FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=2.4, h=6);
        translate([51-1.7*2 + 17-.99, 22-8, 3*FEET_HEIGHT/4]) rotate([0, 90, 0]) cylinder(r=2.4, h=6);
    }
}

$fn = 80;
//feet();
//skirts();

//rear_skirt_insert();

//f_foot();

scale([1, 1, 1]) front_skirt_insert(true);