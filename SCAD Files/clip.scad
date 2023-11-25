$fn=100;
plate_thickness=1.5;

module clip(x) {
    scale([.97, 1, 1]) _clip(x);
}

module _clip(x){
    difference(){
        union(){
            // Backing plate
            translate([0,plate_thickness/2,0]) cube([10,plate_thickness,x],center=true);
       
            hull(){
                    translate([-0.8,0,0])cylinder(h=x,r=0.5,center=true);
                    translate([-2.6/2,-2,0])cylinder(h=x,r=0.6,center=true);
                }
                hull(){
                    translate([0.8,0,0])cylinder(h=x,r=0.5,center=true);
                    translate([2.6/2,-2,0])cylinder(h=x,r=0.6,center=true);
                } 
          }
          
          // Cylinder cutout
          translate([0,0.3,0])cylinder(h=x+1,r=0.6,center=true);
    }
}

clip(10); //lenght

