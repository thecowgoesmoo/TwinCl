
module keycapSharp(){
difference(){
translate([0,-41,0]) union(){
    cube([6.2,82,10+12],center=true);
    translate([0,0,5]) cube([10,82,12],center=true);
}
union(){
    rotate([15,0,0]) translate([-6,0,0]) cube([12,50,12]);
    translate([-6,-12,-18]) cube([12,50,12]);
}
}
}
//keycapSharp();