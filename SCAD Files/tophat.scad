use <extrusion.scad>;
use <panels.scad>;

include <params.scad>;

TOPHAT_HEIGHT = 100;

module tophat() {
    // Square section
    translate([0, 0, TOPHAT_HEIGHT-10]) union() {
        //translate([10, 5, 5]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
        translate([5, 10, 5]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
        //translate([10, EXTRUSION_LEN+15, 5]) rotate([0, 90, 0]) extrusion(EXTRUSION_LEN);
        translate([EXTRUSION_LEN+15, 10, 5]) rotate([-90, 0, 0]) extrusion(EXTRUSION_LEN);
    }
    
    // Verticals
    //translate([5, 5, 0]) extrusion(TOPHAT_HEIGHT);
    //translate([EXTRUSION_LEN+15, 5, 0]) extrusion(TOPHAT_HEIGHT);
    //translate([EXTRUSION_LEN+15, EXTRUSION_LEN+15, 0]) extrusion(TOPHAT_HEIGHT);
    //translate([5, EXTRUSION_LEN+15, 0]) extrusion(TOPHAT_HEIGHT);
    
    front_printed_ushape();
    translate([0, EXTRUSION_LEN+20, 0]) rear_printed_ushape();
    
    // Tophat panels
    color("#afafaf7f") union() {
        translate([7.5, 7.5, TOPHAT_HEIGHT]) linear_extrude(3) tophat_top_panel();
        translate([7.5, 0, 0.5]) rotate([90, 0, 0]) linear_extrude(3) tophat_side_panel();
        translate([7.5, EXTRUSION_LEN+20+3, 0.5]) rotate([90, 0, 0]) linear_extrude(3) tophat_side_panel();
        translate([-3, 7.5, 0.5]) rotate([90, 0, 90]) linear_extrude(3) tophat_side_panel();
        translate([EXTRUSION_LEN+20, 7.5, 0.5]) rotate([90, 0, 90]) linear_extrude(3) tophat_side_panel();
    }
    
    // Top corner clips
    translate([0, 0, TOPHAT_HEIGHT+2.5]) corner_clips();
translate([EXTRUSION_LEN+20, 0, TOPHAT_HEIGHT+2.5]) rotate([0, 0, 90]) corner_clips();
translate([EXTRUSION_LEN+20, EXTRUSION_LEN+20, TOPHAT_HEIGHT+2.5]) rotate([0, 0, 180]) corner_clips();
translate([0, EXTRUSION_LEN+20, TOPHAT_HEIGHT+2.5]) rotate([0, 0, -90]) corner_clips();
    
    // Bottom corner_clips
    bottom_corner_clips();
translate([EXTRUSION_LEN+20, 0, 0]) rotate([0, 0, 90]) bottom_corner_clips();
translate([EXTRUSION_LEN+20, EXTRUSION_LEN+20, 0]) rotate([0, 0, 180]) bottom_right_corner_clip();
translate([0, EXTRUSION_LEN+20, 0]) rotate([0, 0, -90]) bottom_left_corner_clip();
}

PANEL_THICKNESS = 3;

module top_corner_clip() {
    color(MAIN) difference() {
       union() {
           translate([-4.5, -4.5, 0]) cube([30+4.5, 30+4.5, PANEL_THICKNESS+1.5]);
       }
       
       // Shape cutout
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+1.6]);
       
       // Panel cutout
       translate([6.5, 6.5, 1.5]) cube([100, 100, PANEL_THICKNESS+1]);
       
       // Edge chamfers       
       // Long edge outside
       translate([-5, -6.7*sqrt(2), (PANEL_THICKNESS+1.5)/2]) rotate([-45, 0, 0]) cube([100, 100, 5]);
       
       // Short edge outside
       translate([0, -15, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 15]);
       
       // Corner chamfer
       translate([-4, -4, 0]) rotate([-45, 0, -45]) cube([10, 10, 10], center=true);
       
       // Screw holes
       translate([18, 5, -0.01]) cylinder(r=1.7, h=50);
       translate([5, 25, -0.01]) cylinder(r=1.7, h=50);
   }
}
module left_corner_clip() {
    color(MAIN) difference() {
       union() {
           translate([-4.5/sqrt(2), 2.5, 0]) cube([30+4.5/sqrt(2), 30.5, PANEL_THICKNESS+1.5]);
       }
       
       // Shape cutout
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+1]);
       
       // Edge chamfers
       // Short edge outside
       translate([0, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       // Short edge inside
       translate([-4.5/sqrt(2), -1, 1]) rotate([0, 45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Screw holes
       translate([25, 7.5, -0.01]) cylinder(r=1.7, h=50);
       translate([5, 20.5, -0.01]) cylinder(r=1.7, h=50);
   }
}

module right_corner_clip() {
    color(MAIN) scale([-1, 1, 1]) difference() {
       union() {
           translate([-4.5/sqrt(2), 2.5, 0]) cube([30+4.5/sqrt(2), 30.5, PANEL_THICKNESS+1.5]);
       }
       
       // Shape cutout
       translate([30, 18, -0.01]) rotate([0, 0, 45]) cube([34, 22, PANEL_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, 10, 1.5]) cube([100, 100, PANEL_THICKNESS+1]);
       
       // Edge chamfers
       // Short edge outside
       translate([0, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       // Short edge inside
       translate([-4.5/sqrt(2), -1, 1]) rotate([0, 45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Screw holes
       translate([18, 7.5, -0.01]) cylinder(r=1.7, h=50);
       translate([5, 27.5, -0.01]) cylinder(r=1.7, h=50);
   }
}


module bottom_left_corner_clip() {
    color(MAIN) translate([0, -4.5, -2.5]) scale([1, 1, -1]) rotate([-90, 0, 0]) difference() {
       union() {
           translate([-2.5, 2.5, 0]) cube([30+2.5, 22.5, PANEL_THICKNESS+1.5]);
       }
       
       // Shape cutout
       translate([30, 14, -0.01]) rotate([0, 0, 45]) cube([36, 22, PANEL_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, -0.01, 1.5]) cube([100, 100, PANEL_THICKNESS+1]);
       
       // Edge chamfers
       // Short edge outside
       translate([0, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       // Short edge inside
       translate([-4.5/sqrt(2), -1, 1]) rotate([0, 45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Screw holes
       translate([5, 17.5, -0.01]) cylinder(r=1.7, h=50);
   }
}

module bottom_right_corner_clip() {
    color(MAIN) translate([-4.5, 0, -2.5]) scale([-1, 1, -1]) rotate([-90, 0, 90]) difference() {
       union() {
           translate([-2.5, 2.5, 0]) cube([30+2.5, 22.5, PANEL_THICKNESS+1.5]);
       }
       
       // Shape cutout
       translate([30, 14, -0.01]) rotate([0, 0, 45]) cube([36, 22, PANEL_THICKNESS+1.6]);
       
       // Panel cutout
       translate([7.5, -0.01, 1.5]) cube([100, 100, PANEL_THICKNESS+1]);
       
       // Edge chamfers
       // Short edge outside
       translate([0, -1, 0]) rotate([0, -45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       // Short edge inside
       translate([-4.5/sqrt(2), -1, 1]) rotate([0, 45, 0]) translate([-5, 0, 0]) cube([5, 100, 5]);
       
       // Screw holes
       translate([5, 10, -0.01]) cylinder(r=1.7, h=50);
   }
}

module front_printed_ushape() {
    difference() {
        union() {
            cube([10, 10, TOPHAT_HEIGHT]);
            translate([10+EXTRUSION_LEN, 0, 0]) cube([10, 10, TOPHAT_HEIGHT]);
            translate([10, 0, TOPHAT_HEIGHT-10]) cube([EXTRUSION_LEN, 10, 10]);
        }
    
        // Top extrusion screw holes
        translate([5, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([5, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=3, h=6);
        
        translate([EXTRUSION_LEN+15, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([EXTRUSION_LEN+15, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=3, h=6);
        
        // Cam lock screw holes
        translate([5, 5, -0.01]) cylinder(r=2.35, h=6);
        translate([EXTRUSION_LEN+15, 5, -0.01]) cylinder(r=2.35, h=6);
        
        // Screw insert holes
        // Front left clip
        translate([5, -0.01, TOPHAT_HEIGHT - 18]) rotate([-90, 0, 0]) cylinder(r=2.35, h=6);
        translate([25, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=2.35, h=6);
        // Front right clip
        translate([EXTRUSION_LEN+15, -0.01, TOPHAT_HEIGHT - 25]) rotate([-90, 0, 0]) cylinder(r=2.35, h=6);
        translate([EXTRUSION_LEN+20-18, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=2.35, h=6);
        // Top left clip
        translate([18, 5, TOPHAT_HEIGHT - 5.99]) cylinder(r=2.35, h=6);
        // Top right clip
        translate([EXTRUSION_LEN+20-25, 5, TOPHAT_HEIGHT - 5.99]) cylinder(r=2.35, h=6);
        // Left side clip
        translate([-0.01, 5, TOPHAT_HEIGHT - 25]) rotate([0, 90, 0]) cylinder(r=2.35, h=6);
        // Right side clip
        translate([EXTRUSION_LEN+20-5.99, 5, TOPHAT_HEIGHT - 18]) rotate([0, 90, 0]) cylinder(r=2.35, h=6);
        // Left-side bottom clip
        translate([-0.01, 5, 7.5]) rotate([0, 90, 0]) cylinder(r=2.35, h=6);
        // Left-front bottom clip
        translate([5, -0.01, 15]) rotate([-90, 0, 0]) cylinder(r=2.35, h=6);
        // Right-side bottom clip
        translate([EXTRUSION_LEN+20-5.99, 5, 15]) rotate([0, 90, 0]) cylinder(r=2.35, h=6);
        // Right-front bottom clip
        translate([EXTRUSION_LEN+15, -0.01, 7.5]) rotate([-90, 0, 0]) cylinder(r=2.35, h=6);
    }
}

module rear_printed_ushape() {
    translate([EXTRUSION_LEN+20, 0, 0]) scale([-1, -1, 1]) difference() {
        union() {
            cube([10, 10, TOPHAT_HEIGHT]);
            translate([10+EXTRUSION_LEN, 0, 0]) cube([10, 10, TOPHAT_HEIGHT]);
            translate([10, 0, TOPHAT_HEIGHT-10]) cube([EXTRUSION_LEN, 10, 10]);
        }
    
        // Top extrusion screw holes
        translate([5, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([5, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=3.2, h=6);
        
        translate([EXTRUSION_LEN+15, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
        translate([EXTRUSION_LEN+15, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=3.2, h=6);
        
        // Screw insert holes
        // Front left clip
        translate([5, -0.01, TOPHAT_HEIGHT - 18]) rotate([-90, 0, 0]) cylinder(r=2.45, h=6);
        translate([25, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=2.45, h=6);
        // Front right clip
        translate([EXTRUSION_LEN+15, -0.01, TOPHAT_HEIGHT - 25]) rotate([-90, 0, 0]) cylinder(r=2.45, h=6);
        translate([EXTRUSION_LEN+20-18, -0.01, TOPHAT_HEIGHT - 5]) rotate([-90, 0, 0]) cylinder(r=2.45, h=6);
        // Top left clip
        translate([18, 5, TOPHAT_HEIGHT - 5.99]) cylinder(r=2.45, h=6);
        // Top right clip
        translate([EXTRUSION_LEN+20-25, 5, TOPHAT_HEIGHT - 5.99]) cylinder(r=2.45, h=6);
        // Left side clip
        translate([-0.01, 5, TOPHAT_HEIGHT - 25]) rotate([0, 90, 0]) cylinder(r=2.45, h=6);
        // Right side clip
        translate([EXTRUSION_LEN+20-5.99, 5, TOPHAT_HEIGHT - 18]) rotate([0, 90, 0]) cylinder(r=2.45, h=6);
        // Left-side bottom clip
        translate([-0.01, 5, 15]) rotate([0, 90, 0]) cylinder(r=2.45, h=6);
        // Right-side bottom clip
        translate([EXTRUSION_LEN+20-5.99, 5, 15]) rotate([0, 90, 0]) cylinder(r=2.45, h=6);
        
        // Hinge grooves
        translate([(10-5.6)/2, 3, -0.01]) linear_extrude(53) union() {
            square([5.6, 2.4]);
            translate([1.3, -3.01]) square([3, 3.1]);
        }
        translate([EXTRUSION_LEN+10+(10-5.6)/2, 3, -0.01]) linear_extrude(53) union() {
            square([5.6, 2.4]);
            translate([1.3, -3.01]) square([3, 3.1]);
        }
    }
}

module hinge() {
    lower_hinge();
    top_hinge();
}

module lower_hinge() {
    // M3 nuts are 9.5mm wide, which means the lower screw needs to be centred 4.75mm from the top of the vertical frame extrusions.
    // Thread insert is 31mm from the base of the drive block.
    // In total, this makes it a gap of 35.75mm, maybe 36 after shrinkage.
}

module top_hinge() {
    
}

module corner_clips() {
    translate([0, 0, 2]) scale([1, 1, -1]) top_corner_clip();
translate([0, -4.5, 0]) rotate([-90, 0, 0]) left_corner_clip();

translate([-4.5, 0, 0]) rotate([-90, 0, -90]) right_corner_clip();
}

module bottom_corner_clips() {
    bottom_left_corner_clip();
    bottom_right_corner_clip();
}

//translate([0, 0, -290]) import("STLs/TH_Hinge_B_Bottom_x1.stl");
//translate([0, 0, 310]) import("STLs/TH_Hinge_B_Top_x1.stl");

$fn=80;
//tophat();

scale([1, 1, -1]) top_corner_clip();