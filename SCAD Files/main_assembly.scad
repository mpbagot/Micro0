use <frame.scad>;
use <z_axis.scad>;
use <gantry.scad>;
use <skirts_feet.scad>;
use <panels.scad>;
use <panel_clips.scad>;
use <door.scad>;
use <tophat.scad>;
use <aux_cooling.scad>;

include <params.scad>;

// main frame
frame();

// z-axis
translate([10, EXTRUSION_LEN+15-MOTOR_SIZE, 0]) z_axis(); 

// gantry
translate([10, 13, EXTRUSION_LEN - 5]) gantry();

// Aux cooler
translate([EXTRUSION_LEN+20, 42+10,20]) rotate([0, 0, -90]) aux_cooler();

// tophat
translate([0, 0, EXTRUSION_LEN+43]) tophat();

// Skirts+legs
translate([0, 0, 0]) feet();
translate([0, 0, 0]) skirts();

// Panels
color("black") translate([10, 10, 4]) linear_extrude(2.5) deck_panel();
color("black") translate([48+1.5, EXTRUSION_LEN+20-MOTOR_SIZE+1.5, EXTRUSION_LEN-3]) linear_extrude(3) motor_panel();
color("black") translate([0, EXTRUSION_LEN+10+3-MOTOR_SIZE, 10]) rotate([90, 0, 0]) linear_extrude(3) rear_chamber_panel();
color("black") translate([7, 7, -40]) linear_extrude(3) base_panel();
color("black") translate([7, EXTRUSION_LEN+20, EXTRUSION_LEN+43]) rotate([-90, 0, 0])  linear_extrude(3) back_panel_top();
color("black") translate([7, EXTRUSION_LEN+20, 0]) rotate([90, 0, 0])  linear_extrude(3) back_panel_bottom();

color("#afafaf7f") translate([7.5, 0, 8]) rotate([90, 0, 0]) linear_extrude(3) door_panel();
color("#afafaf7f") translate([-3, 7.5, 8]) rotate([90, 0, 90]) linear_extrude(3) side_panel();
color("#afafaf7f") translate([EXTRUSION_LEN+20, 7.5, 8]) rotate([90, 0, 90]) linear_extrude(3) side_panel();

panel_clips();

// Door pieces
color(MAIN) translate([10, 0, 25]) door_latch();
color(MAIN) translate([10, 0, 112]) door_latch();
color(ACCENT) translate([10, -3, 25]) door_handle();