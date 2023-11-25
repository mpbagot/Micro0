$fa = 0.1;
$fs = 0.1;

module extrusion(length) {
    color("#3f3f3f") linear_extrude(length) union() {
        for (i = [0:4]) {
            rotate([0, 0, 90*i]) segment();
            rotate([0, 0, 90*i]) scale([-1, 1, 1]) segment();
        }
    }
}

module segment() {
    difference() {
        polygon([[0, 2], [1, 2], [3, 4], [1.5, 4], [1.5, 5], [5,5], [0, 0]]);
        circle(1.25);
    }
}
