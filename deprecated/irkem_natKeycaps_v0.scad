wOnlyLen = 50;
bLen = 82;
insetZ = 10;
insetX = 6.2;
//bX = ;
wX = 22;
//difference(){
//translate([0,-41,0]) union(){
difference(){
    translate([0,-bLen/2,0]) cube([insetX,bLen,insetZ],center=true);
    translate([-6,-12,-14]) cube([12,50,12]);
}
    translate([0,25-bLen/2+bLen/2,5]) cube([wX,bLen+wOnlyLen-bLen,4],center=true);
    translate([0,25-bLen/2-0,5]) cube([10,bLen+wOnlyLen-82+80,4],center=true);
//    translate([0,25-41,5]) cube([22,82+50,2],center=true);
//}
//union(){
//    rotate([15,0,0]) translate([-6,0,0]) cube([12,50,12]);
//    translate([-6,-12,-18]) cube([12,50,12]);
//}
//}
//46-50 mm long