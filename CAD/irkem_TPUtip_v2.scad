$fn = 30;

module TPUtip(){
difference(){
    union(){
        //scale([1.5,1,1]) cylinder(10,2.3,2.3);
        scale([1.5,1,1]) cylinder(10,1.8,1.8+(4.4-1.8)*10/24);
        //translate([0,-2+0.5,-3]) rotate([0,0,15]) rotate([0,-10,0]) translate([-2.2,0,1]) cube([6,3,4]);
    }
    union(){
        //translate([0,0,1]) scale([4,1,1]) cylinder(10,1,1);
        translate([0,0,1]) scale([1.5,1,1]) cylinder(10,1.5,1.5+(4.1-1.5)*10/24);
        //translate([3,20,4]) rotate([90,0,0]) cylinder(40,1.0,1.0);
        //translate([-3,20,4]) rotate([90,0,0]) cylinder(40,1.0,1.0);
    }
}

}

TPUtip();