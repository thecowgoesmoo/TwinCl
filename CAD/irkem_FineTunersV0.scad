$fn = 50;

kSp = 13.75;
nKeys = 60;//5;

spH = 5;
spR = 10;

wrmH = 20;
wrmR = 3;

sqSide = 25.4/8;
sqLen = 40;

skew = -15;
boreR = 5;

thrH = 1;

//fineTunerAssy();

module fineTunerAssy(){

for (i = [1:1:nKeys]) {
    rInd = i%2;
    translate([kSp*i-rInd*25*sin(skew),rInd*25,0]) rotate([0,0,skew]) rotate([0,-30,0]) wormAsy();
    //translate([kSp*i-rInd*25*sin(skew),rInd*25,0]) rotate([90,0,skew]) cylinder(spH,spR,spR);
    //translate([kSp*i-rInd*25*sin(skew),rInd*25,-spR-wrmR]) rotate([0,90,skew]) translate([0,-2.5,-wrmH/2]) cylinder(wrmH,wrmR,wrmR);
    translate([kSp*i,0,0]) rotate([0,0,skew]) translate([-sqSide/2,-10,-sqSide/2]) cube([sqSide,sqLen,sqSide]);
}
color("gray",0.3) translate([10,-22,-10]) cube([13.75*nKeys,14,20]);
color("gray",0.3) translate([10,28,-10]) cube([13.75*nKeys,14,20]);
color("blue",0.5) difference(){
    translate([10,3,-10]) cube([13.75*nKeys,14,20]);
    daHolz();//translate([16.5,10,-20]) cylinder(100,5,5);
}

}

module daHolz(){
    for (i = [1:1:nKeys]) {
        translate([16.5+i*kSp-kSp,10,-20]) cylinder(100,5,5);
    }
}

module wormAsy(){
    translate([0,0,0]) rotate([90,0,0]) cylinder(spH,spR,spR);
    translate([0,0,-spR-wrmR+thrH]) rotate([0,90,0]) translate([0,-2.5,-wrmH/2]) cylinder(wrmH,wrmR,wrmR);
}