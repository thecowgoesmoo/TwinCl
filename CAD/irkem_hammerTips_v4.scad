//include <irkem_TPUtip_v2.scad>
tol = 0.2;
extrWall = 1.7+tol;
extrH = 12.9+tol;//12.6+tol;
extrW = 10+tol;

hammerY = 15;//20;
hammerZ = 24;

$fn = 20;

module hammerTips(){
//Strike cylinder:
//v1: made elliptical and added skew-angle indentation to:
//      1. Avoid hitting adjacent strings
//      2. Maximize likelihood of striking proper string
//      3. Ensure that hammer tip force on the string is centering
//Prior cone geometry resulted in adjacent string strikes in y axis for most keys
    //difference(){
    //    translate([0,-5,0]) scale([2.6,1,1]) cylinder(hammerZ,2.5,2);
    //    translate([-12,-1.8,25]) rotate([0,90,-15]) cylinder(hammerZ,3,3);
    //}
    difference(){
        translate([0,-5,0]) scale([1.5,1,1]) cylinder(hammerZ,4.1,1.5);
        translate([-12,-1.8,25]) rotate([0,90,-15]) cylinder(hammerZ,3,3);
    }
intersection(){    
    translate([0,-10,-6]) scale([1,1,1.5]) rotate([-90,0,0]) cylinder(20,8,8);
difference(){
    translate([-6.5,-10,-14]) cube([13,hammerY,16]);
    union(){uChan();translate([-extrW/2,-10,-extrH]) cube([extrW,10,extrH]);
}
//difference(){
//    translate([-6.5,-10,-14]) cube([13,hammerY,16]);
//    union(){uChan();translate([-extrW/2,-hammerY/2,-extrH]) cube([extrW,hammerY/2,extrH]);
//}
}
}
module uChan(){
difference(){
    translate([-extrW/2,-hammerY/2,-extrH]) cube([extrW,hammerY,extrH]);
    translate([-extrW/2+extrWall,-hammerY/2,-extrH-extrWall]) cube([extrW-2*extrWall,hammerY,extrH]);
}
translate([4.4,-hammerY/2,-0.2]) rotate([-90,0,0]) cylinder(hammerY,1,1);
translate([-4.4,-hammerY/2,-0.2]) rotate([-90,0,0]) cylinder(hammerY,1,1);
}
//color("gray") translate([0,-5,23]) rotate([0,180,0]) TPUtip();
}

hammerTips();
//color("gray") translate([0,-5,23]) rotate([0,180,0]) TPUtip();