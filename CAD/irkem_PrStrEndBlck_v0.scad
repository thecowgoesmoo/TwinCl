$fn = 20;
strSpc = 3.56;
hR = 1.5;
barX = 10;
barY = 73;//235;//250;
barZ = 15;
nKeys = 20;//60;
osetY = 2.5;
osetY2 = 2;
osetZ1 = 10-2;
osetZ2 = 10+2;
scrR = 1.5;//1.5;
scrHdR = 4;
difference(){
    positives();
    negatives();
}

module negatives(){
    //Pass-through holes for strings:
for (i = [0 : 1 : (nKeys-1)]) {
    //osetZ = ((i%2)==(1)) ? osetZ1 : osetZ2;
    osetZ = (i%3)*3+6;
    translate([0,i*strSpc+osetY,osetZ]) rotate([0,90,0]) cylinder(barX,hR,hR);
}
    //Mounting holes for screws:
for (i = [0 : 6 : (nKeys)]) {
    translate([-barX/2,i*strSpc+osetY+osetY2,0]) rotate([0,0,0]) cylinder(10,scrR,scrR);
}
    //Countersink holes for screw heads:
for (i = [0 : 6 : (nKeys)]) {
    translate([-barX/2,i*strSpc+osetY+osetY2,10-2-4-2]) rotate([0,0,0]) cylinder(4,scrHdR,scrHdR);
}
translate([-11,75,0]) rotate([0,0,-15]) cube([30,20,20]);
}

module positives(){
    cube([barX,barY,barZ]);
    translate([-barX,0,0]) cube([barX,barY,4]);
}