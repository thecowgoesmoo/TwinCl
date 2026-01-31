wOnlyLen = 50;
bLen = 82;
insetZ = 10;
insetX = 6.2;
bX = 10;
wX = 22;
wH = 4;

module keycapEB(){
difference(){
    translate([0,-bLen/2,0]) cube([insetX,bLen,insetZ],center=true);
    translate([-6,-12,-14]) cube([12,wOnlyLen,12]);
}
    //translate([0-4+4+0,25-bLen/2+bLen/2,5]) cube([wX,bLen+wOnlyLen-bLen,wH],center=true);
    //translate([0+2+2-8-4,25-bLen/2-0,5]) cube([10-2,wOnlyLen+bLen,wH],center=true);
    //Key cap end:
    translate([2+0+2,25-bLen/2+bLen/2,5]) cube([wX,wOnlyLen,wH],center=true);
    //Sharp-side key cap
    //translate([-0*bX/2-wX/2,-bLen,3]) cube([bX/2+wX/2-2,wOnlyLen+bLen,wH],center=false);
    translate([-bX/2,-bLen,3]) cube([bX,wOnlyLen+bLen,wH],center=false);
//46-50 mm long
}

//customGrid(100,5);

// Example of a custom grid structure
module customGrid(size, spacing) {
    for (i = [-size : spacing : size]) {
        color("lime") translate([i, -size, 0]) cube([1, 2*size, 1]); // Adjust as needed
        color("lime") translate([-size, i, 0]) cube([2*size, 1, 1]); // Adjust as needed
    }
}

//keycapEB();