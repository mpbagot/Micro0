module mgn7_aligner() {

    difference() {
        translate([0, 0.1, 0]) cube([13, 5, 12]);
        
        // Rail
        translate([2.9, 0, 4.98]) cube([7.2, 50, 5]);
        
        // Extrusion
        translate([1.4, 0, -0.01]) cube([10.2, 50, 5]);
    }
}

mgn7_aligner();

module mgn5_aligner() {

    difference() {
        translate([0, 0.1, 0]) cube([13, 5, 10]);
        
        // Rail
        translate([3.9, 0, 4.98]) cube([5.2, 50, 3.8]);
        
        // Extrusion
        translate([1.4, 0, -0.01]) cube([10.2, 50, 5]);
    }
}

//mgn5_aligner();