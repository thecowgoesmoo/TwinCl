wOnlyLen = 50;
bLen = 82;
insetZ = 10;
insetX = 6.2;
bX = 10;
wX = 22;
wH = 4;

module keycapDGA(){
//Key chassis inset:
difference(){
    translate([0,-bLen/2,0]) cube([insetX,bLen,insetZ],center=true);
    translate([-6,-12,-14]) cube([12,wOnlyLen,12]);
}
//End of key cap
    translate([0,wOnlyLen/2,insetZ/2]) cube([wX,wOnlyLen,wH],center=true);
//Sharp-side of key cap
    translate([0,wOnlyLen/2-bLen/2-0,insetZ/2]) cube([bX,wOnlyLen+bLen,wH],center=true);
//46-50 mm long
}

//keycapDGA();