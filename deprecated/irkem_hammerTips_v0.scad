tol = 0.2;
extrWall = 1.7+tol;
extrH = 12.9+tol;//12.6+tol;
extrW = 10+tol;

hammerY = 20;
hammerZ = 24;

module hammerTips(){
translate([0,-5,0]) cylinder(hammerZ,6,3);
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