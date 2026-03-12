strSpc = 3.56;
hR = 1;
barX = 10;
barY = 235;//250;
barZ = 15;
nKeys = 60;
osetY = 20;
osetZ = 10;
scrR = 3.0;//1.5;
scrHdR = 4;
difference(){
    positives();
    negatives();
}

module negatives(){
    //Pass-through holes for strings:
for (i = [0 : 1 : (nKeys-1)]) {
    translate([0,i*strSpc+osetY,osetZ+(i%3)*2-3]) rotate([0,90,0]) cylinder(barX,hR,hR);
}
    //Mounting holes for screws:
for (i = [0 : 18 : (nKeys)]) {
    translate([-barX/2,i*strSpc+osetY,0]) rotate([0,0,0]) cylinder(osetZ,scrR,scrR);
}
    //Countersink holes for screw heads:
for (i = [0 : 18 : (nKeys)]) {
    translate([-barX/2,i*strSpc+osetY,osetZ-2-4]) rotate([0,0,0]) cylinder(4,scrHdR,scrHdR);
}
}

module positives(){
    cube([barX,barY,barZ]);
    translate([-barX,0,0]) cube([barX,barY,osetZ-2]);
}