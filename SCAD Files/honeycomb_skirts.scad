include <params.scad>;
use <skirts_feet.scad>;

FEET_HEIGHT = 40;

module hexagon(r, h, r2=3) {
    // r is half the distance from flat to opposite flat
    // h is the height of the hexagon
    // r2 is the radius of the corner curving
    r = r - r2;
    linear_extrude(h) {
        hull() {
            translate([r/sqrt(3), r]) circle(r=r2);
            translate([-r/sqrt(3), r]) circle(r=r2);
            translate([r/sqrt(3), -r]) circle(r=r2);
            translate([-r/sqrt(3), -r]) circle(r=r2);
            translate([2*r/sqrt(3), 0]) circle(r=r2);
            translate([-2*r/sqrt(3), 0]) circle(r=r2);
        }
    }
}

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



module side_skirt() {
    color(MAIN) difference() {
        cube([10, EXTRUSION_LEN-24, FEET_HEIGHT]);
        
        // Screw holes
        hole_count = 3;
        for (i=[1:hole_count]) {
            translate([5, i*(EXTRUSION_LEN-24)/(hole_count+1), 8]) cylinder(r=3, h=FEET_HEIGHT-10);
            translate([5, i*(EXTRUSION_LEN-24)/(hole_count+1), -2]) cylinder(r=1.7, h=FEET_HEIGHT+5);
        }
        
        // Inner shape cut
        hull() {
            translate([0, 2, 7+2]) rotate([-90, 0, 0]) cylinder(r=7, h=EXTRUSION_LEN-24-4);
            translate([0, 2, FEET_HEIGHT-2-7]) rotate([-90, 0, 0]) cylinder(r=7, h=EXTRUSION_LEN-24-4);
        }
        
        // Hexagons
        r=5.6;
        intersection() {
            translate([-1, 2, 2]) cube([100, EXTRUSION_LEN-24-4, FEET_HEIGHT-4]);
            union() {
                for(i=[0:10]) {
                    translate([-1, 2+i*(r+2)*2, 10]) rotate([0, 90, 0]) hexagon(r, 20, 2);
                }
                for(i=[0:10]) {
                    translate([-1, 2+r+2+i*(r+2)*2, 10+2+2*(r+2)/sqrt(3)]) rotate([0, 90, 0]) hexagon(r, 20, 2);
                }
                for(i=[0:10]) {
                    translate([-1, 2+i*(r+2)*2, FEET_HEIGHT-8]) rotate([0, 90, 0]) hexagon(r, 20, 2);
                }
            }
        }
        
        // Base plate cutout
        translate([7, 0, -0.01]) cube([3.5, EXTRUSION_LEN, 2.51]);
        translate([7-5*sqrt(3)/2, -10, -0.01]) rotate([0, 60, 0]) cube([10, 200, 5]);
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
        
        // Inner shape cut
        hull() {
            translate([2, 0, 7+2]) rotate([0, 90, 0]) cylinder(r=7, h=PIECE_WIDTH-4);
            translate([2, 0, FEET_HEIGHT-2-7]) rotate([0, 90, 0]) cylinder(r=7, h=PIECE_WIDTH-4);
        }
        
        // Hexagons
        r=5.6;
        intersection() {
            translate([2, -1, 2]) cube([PIECE_WIDTH-4, 100, FEET_HEIGHT-4]);
            union() {
                for(i=[0:10]) {
                    translate([1+i*(r+2)*2, -1, 10]) rotate([-90, 30, 0]) hexagon(r, 20, 2);
                }for(i=[0:10]) {
                    translate([1+r+2+i*(r+2)*2, -1, 10+2+2*(r+2)/sqrt(3)]) rotate([-90, 30, 0]) hexagon(r, 20, 2);
                }for(i=[0:10]) {
                    translate([1+i*(r+2)*2, -1, FEET_HEIGHT-8]) rotate([-90, 30, 0]) hexagon(r, 20, 2);
                }
            }
        }
        
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
        
        // Base plate cutout
        translate([-1, -1, -0.01]) cube([PIECE_WIDTH+5, 4, 2.51]);
    }    
}

$fn = 80;
feet();
skirts();

//side_skirt();