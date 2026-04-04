//V3 of the TwinCl (Clavinet Digital Twin) project will have the harp flipped forward toward the player to be available for extended techniques.  Tuning control will be improved through the use of guitar tuning machine heads mounted directly to the lower lip of the steel angle stock hypotenuse.  This string guide will ensure proper string spacing as strings pass over the harp. There will be another straight-pull guide on the short side of the harp.

$fn = 20;
skew = 15;
kSp = 13.75;
nKeys = 60;

gZ = 1.5*25.4;
gX = kSp * nKeys;
gY = 4;
hR = 1.3;
hZ = gZ-(hR+2);

difference(){
    cube([gX,gY,gZ]);
    allHoles();
}

difference(){
    translate([0,-7,26]) cube([gX,7,6]);
    translate([-5,-3,26]) cube([gX+10,3,3]);
}

module allHoles(){
    for (i = [1:1:nKeys]) {
        translate([i*kSp,0,hZ]) rotate([0,90,15]) translate([0,0,-50]) cylinder(100,hR,hR);
    }
}
