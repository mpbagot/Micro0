use <clip.scad>;

include <params.scad>;

$fn=100;
plate_thickness=1.5;

PANEL_THICKNESS = 3;
TAPE_THICKNESS = 0.9;

module side_top_clip() {
   difference() {
       union() {
           cube([63, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
           // Clips
           translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) clip(15);
           translate([55, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) clip(15);
       }
       
       translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
        translate([55, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
       
       // Shape cutouts
       translate([30, 18, -0.01]) cube([34, 20, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([75, 0, -0.01]) rotate([0, 0, 45]) cube([34, 40, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Edge chamfer
       // Long edge inside
       translate([-1, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([45, 0, 0]) cube([100, 100, 5]);
       
       // Long edge outside
       translate([-1, -5*sqrt(2), (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([-45, 0, 0]) cube([100, 100, 5]);
       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

module side_bottom_clip() {
   difference() {
       union() {
           cube([30, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
           // Clips
           translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) clip(15);
           translate([5+14, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) clip(15);
       }
       
       translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
       translate([5+14, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
       
       // Shape cutout
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Edge chamfer
       // Long edge inside
       translate([-1, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([45, 0, 0]) cube([100, 100, 5]);
       
       // Long edge outside
       translate([-1, -5*sqrt(2), (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([-45, 0, 0]) cube([100, 100, 5]);
       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

module middle_clip() {
    difference() {
        union() {
            hull() {
                translate([2, 13, 0]) cylinder(r=2, h=PANEL_THICKNESS+TAPE_THICKNESS+1.5);
                translate([23, 13, 0]) cylinder(r=2, h=PANEL_THICKNESS+TAPE_THICKNESS+1.5);
                translate([23, 6, 0]) cylinder(r=2, h=PANEL_THICKNESS+TAPE_THICKNESS+1.5);
                translate([19, 2, 0]) cylinder(r=2, h=PANEL_THICKNESS+TAPE_THICKNESS+1.5);
                translate([6, 2, 0]) cylinder(r=2, h=PANEL_THICKNESS+TAPE_THICKNESS+1.5);
                translate([2, 6, 0]) cylinder(r=2, h=PANEL_THICKNESS+TAPE_THICKNESS+1.5);
            }
            
            // Clip
            translate([12.5, 15-5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) clip(25);
        }
        
        translate([12.5, 15-5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) translate([0,0.3,0]) cylinder(h=25+1,r=0.6, center=true);
        
        // Outer slant
        translate([0, 13, 0]) rotate([-45, 0, 0]) cube([50, 10, 10]);
        
        // Inner cut
        translate([-0.01, -0.01, 1.5]) cube([50, 8, PANEL_THICKNESS+TAPE_THICKNESS+0.01]);
        
    }
}



module rear_bottom_clip() {
   difference() {
       union() {
           cube([30, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
           // Clip
           translate([15, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) clip(30);
       }
       
       translate([15, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) translate([0,0.3,0]) cylinder(h=30+1,r=0.6, center=true);
       
       // Shape cutout
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([-1, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Edge chamfer
       // Long edge inside
       translate([-1, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([45, 0, 0]) cube([100, 100, 5]);
       
       // Long edge outside
       translate([-1, -5*sqrt(2), (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([-45, 0, 0]) cube([100, 100, 5]);
       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}


// Top hinge side
module top_hinge_side() {
    scale([1, -1, 1]) difference() {
        union() {
            hull() {
                cube([63, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
               translate([0, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(d=PANEL_THICKNESS+TAPE_THICKNESS+1.5, h=63);
           }
           // Clips
           translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) clip(15);
           translate([55, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) clip(15);
       }
       
       translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
        translate([55, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
       
       // Shape cutouts
       translate([30, 18, -0.01]) cube([34, 20, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([75, 0, -0.01]) rotate([0, 0, 45]) cube([34, 40, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Top half cutout
       translate([-0.01, -3.01, -0.01]) cube([33, 6.5, 10]);
       // Screw hole cutout
       translate([0, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(h=100, r=1.45);
       
       // Edge chamfer       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

// Top hinge door
module top_hinge_door() {
    difference() {
        union() {
            hull() {
                cube([63, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
               translate([0, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(d=PANEL_THICKNESS+TAPE_THICKNESS+1.5, h=63);
           }
       }
       
       // Shape cutouts
       translate([30, 18, -0.01]) cube([34, 20, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([75, 0, -0.01]) rotate([0, 0, 45]) cube([34, 40, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([-0.01, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Top half cutout
       translate([31.99, -3.01, -0.01]) cube([33, 6.5, 10]);
       // Screw hole cutout
       translate([-0.01, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(h=100, r=1.75);
       
       // Edge chamfer       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -3, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

// TODO Bottom hinge side
module bottom_hinge_side() {
    difference() {
        union() {
            hull() {
                cube([30, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
               translate([0, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(d=PANEL_THICKNESS+TAPE_THICKNESS+1.5, h=30);
           }
           // Clips
           translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) clip(15);
           translate([19, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) clip(15);
       }
       
       translate([5, 7.5+14, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 0]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
        translate([14+5, 2.63+5, PANEL_THICKNESS+TAPE_THICKNESS+1.5]) rotate([-90, 0, 90]) translate([0,0.3,0]) cylinder(h=19+1,r=0.6, center=true);
       
       // Shape cutouts
       translate([30, 18, -0.01]) cube([34, 20, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([75, 0, -0.01]) rotate([0, 0, 45]) cube([34, 40, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Top half cutout
       translate([14.99, -3.01, -0.01]) cube([15.5, 6.5, 10]);
       // Screw hole cutout
       translate([-0.01, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(h=100, r=1.45);
       
       // Edge chamfer       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -3, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

// Bottom hinge door
module bottom_hinge_door() {
    scale([1, -1, 1]) difference() {
        union() {
            hull() {
                cube([30, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
           
               translate([0, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(d=PANEL_THICKNESS+TAPE_THICKNESS+1.5, h=30);
           }
       }
       
       // Shape cutouts
       translate([30, 18, -0.01]) cube([34, 20, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([75, 0, -0.01]) rotate([0, 0, 45]) cube([34, 40, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Top half cutout
       translate([-0.01, -3.01, -0.01]) cube([16, 6.5, 10]);
       // Screw hole cutout
       translate([-0.01, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([0, 90, 0]) cylinder(h=100, r=1.75);
       
       // Edge chamfer       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -3, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

// Top left door
module top_left_door() {
    scale([1, -1, 1]) difference() {
       union() {
           cube([63, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
       }
       
       // Shape cutouts
       translate([30, 18, -0.01]) cube([34, 20, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       translate([75, 0, -0.01]) rotate([0, 0, 45]) cube([34, 40, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([-0.01, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Edge chamfer
       // Long edge inside
       translate([-1, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([45, 0, 0]) cube([100, 100, 5]);
       
       // Long edge outside
       translate([-1, -5*sqrt(2), (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([-45, 0, 0]) cube([100, 100, 5]);
       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

// Bottom left door
module bottom_left_door() {
    difference() {
       union() {
           cube([30, 33, PANEL_THICKNESS+TAPE_THICKNESS+1.5]);
       }
       
       // Shape cutout
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+TAPE_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+TAPE_THICKNESS+1]);
       
       // Edge chamfer
       // Long edge inside
       translate([-1, 0, (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([45, 0, 0]) cube([100, 100, 5]);
       
       // Long edge outside
       translate([-1, -5*sqrt(2), (PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2]) rotate([-45, 0, 0]) cube([100, 100, 5]);
       
       // Short edge outside
       translate([(PANEL_THICKNESS+TAPE_THICKNESS+1.5)/2, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Large long-edge slant
       translate([-1, 30, -4.8]) rotate([45, 0, 0]) cube([100, 100, 5]);
   }
}

// TODO Rear top hinges

module _left_panel_clips() {
    translate([0, EXTRUSION_LEN+22.6, 0]) rotate([0, -90, 180]) side_bottom_clip();
    
    translate([0, -2.6, 0]) scale([1, -1, 1]) rotate([0, -90, 180]) side_bottom_clip();
    
    translate([0, EXTRUSION_LEN+22.6, EXTRUSION_LEN+36]) scale([1, -1, 1]) rotate([0, 90, 0]) side_top_clip();
    
    translate([0, -2.6, EXTRUSION_LEN+36]) rotate([0, 90, 0]) side_top_clip();
    
}

module _right_panel_clips() {
    scale([-1, 1, 1]) translate([0, EXTRUSION_LEN+22.6, 0]) rotate([0, -90, 180]) side_bottom_clip();
    
    translate([0, -2.6, 0]) scale([-1, -1, 1]) rotate([0, -90, 180]) bottom_hinge_side();
    
    translate([0, EXTRUSION_LEN+22.6, EXTRUSION_LEN+36]) scale([-1, -1, 1]) rotate([0, 90, 0]) side_top_clip();
    
    translate([0, -2.6, EXTRUSION_LEN+36]) rotate([0, 90, 180]) top_hinge_side();
    
}

module _door_panel_clips() {
    translate([-2.6, 0, EXTRUSION_LEN+36]) rotate([0, 90, 90]) top_left_door();
    
    translate([-2.6, 0, 0]) rotate([-90, -90, 0]) bottom_left_door();
    
    translate([EXTRUSION_LEN+20+2.6, 0, EXTRUSION_LEN+36]) rotate([0, 90, 90]) top_hinge_door();
    
    translate([EXTRUSION_LEN+20+2.6, 0, 0]) rotate([0, -90, -90]) bottom_hinge_door();
}

module _rear_panel_clips() {
    translate([EXTRUSION_LEN+20+2.6, EXTRUSION_LEN+20, 0]) rotate([90, -90, 0]) rear_bottom_clip();
    
    translate([-2.6, EXTRUSION_LEN+20, 0]) scale([-1, 1, 1]) rotate([90, -90, 0])rear_bottom_clip();
}

module panel_clips() {
    // Left panel clips
    color(MAIN) translate([-(plate_thickness+PANEL_THICKNESS+TAPE_THICKNESS), 0, 0]) _left_panel_clips();
    // Right panel clips
    color(MAIN) translate([(plate_thickness+PANEL_THICKNESS+TAPE_THICKNESS)+EXTRUSION_LEN+20, 0, 0]) _right_panel_clips();
    // Door panel clips
    color(MAIN) translate([0, -(plate_thickness+PANEL_THICKNESS+TAPE_THICKNESS), 0]) _door_panel_clips();
    // Rear panel clips
    color(MAIN) translate([0, (plate_thickness+PANEL_THICKNESS+TAPE_THICKNESS), 0]) _rear_panel_clips();
}

panel_clips();

//translate([-175.7, 105.8, -383]) import("Panel_Mounting/Rear_Bottom_Left_Clip_x1.stl");

