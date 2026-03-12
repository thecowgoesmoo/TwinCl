magX = 10;
magY = 60;
magZ = 6;
nMags = 4;
bThick = 5;

module positives(){
    translate([-bThick,-bThick,0]) cube([magX+2*bThick,magY*4+2*bThick,magZ]);
    translate([-bThick-2,-bThick-2,0]) cube([magX+2*bThick+4,magY*4+2*bThick+4,1]);
    translate([-bThick-2,-bThick-2,magZ-1]) cube([magX+2*bThick+4,magY*4+2*bThick+4,1]);
}


module negatives(){
for (i = [0 : 1 : (nMags-1)]) {
    translate([0,i*magY,0]) cube([magX,magY,magZ]);
}
}

difference(){
    positives();
    negatives();
}
