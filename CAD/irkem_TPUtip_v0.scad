$fn = 30;

module TPUtip(){
difference(){
    union(){
        scale([2.6,1,1]) cylinder(10,2.3,2.3);
        translate([0,-2+0.5,-3]) rotate([0,0,15]) rotate([0,-15,0]) translate([-4,0,1]) cube([10,3,4]);
    }
    union(){
        //translate([0,0,1]) scale([4,1,1]) cylinder(10,1,1);
        translate([0,0,1]) scale([2.8,1,1]) cylinder(10,1.8,1.8);
        //translate([3,20,4]) rotate([90,0,0]) cylinder(40,1.0,1.0);
        //translate([-3,20,4]) rotate([90,0,0]) cylinder(40,1.0,1.0);
    }
}

}

TPUtip();