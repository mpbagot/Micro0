$fn = 20;

difference() {
    cube([14, 14, 40.5]);
    
    translate([1.9, 1.9, -1]) cube([10.2, 12.2, 39]);
    
    translate([-0.1, 1.9, -1]) cube([20.2, 12.2, 15]);
    
    // Diagonal
    translate([-0.1, 1.9, 14]) rotate([-26.6, 0, 0]) cube([20.2, 12.2, sqrt(12^2+24^2)]);
    
    // Cut holes
    translate([6.9, 6.9, 37]) cylinder(r=1.7, h=50);
    translate([7, -.1, 38-5]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
    translate([7, -.1, 38-32]) rotate([-90, 0, 0]) cylinder(r=1.7, h=50);
}