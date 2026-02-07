tol = 0.2;
extrWall = 1.7+tol;
extrH = 12.9+tol;//12.6+tol;
extrW = 10+tol;

hammerY = 20;
hammerZ = 24;

$fn = 20;

module hammerTips(){
//Strike cylinder:
//v1: made elliptical and added skew-angle indentation to:
//      1. Avoid hitting adjacent strings
//      2. Maximize likelihood of striking proper string
//      3. Ensure that hammer tip force on the string is centering
//Prior cone geometry resulted in adjacent string strikes in y axis for most keys
    difference(){
        translate([0,-5,0]) scale([2.6,1,1]) cylinder(hammerZ,2.5,2);
        translate([-12,-1.8,25]) rotate([0,90,-15]) cylinder(hammerZ,3,3);
    }
difference(){
    translate([-6.5,-10,-14]) cube([13,hammerY,16]);
    union(){uChan();translate([-extrW/2,-hammerY/2,-extrH]) cube([extrW,hammerY/2,extrH]);
}
}
module uChan(){
difference(){
    translate([-extrW/2,-hammerY/2,-extrH]) cube([extrW,hammerY,extrH]);
    translate([-extrW/2+extrWall,-hammerY/2,-extrH-extrWall]) cube([extrW-2*extrWall,hammerY,extrH]);
}
}
}

//hammerTips();