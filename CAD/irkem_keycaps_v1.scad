include <irkem_hammerTips_v0.scad>

kH = 4;
bH = 10;
wL = 50;
bL = 80;
oct = 6.5 * 25.4;
gap = 2;
n_oct = 1;
n_keys = 12 * n_oct;
oset = -1;

sharpFlag = 0;

for (k = [0:1:n_keys]){
    //
    translate([k*13.75+6.0,12,-14]) rotate([0,180,0]) hammerTips();
}

for (k = [0:1:(n_oct-1)]){

//C:
translate([k*oct+0,0,0]) cube([oct*1/12-gap,bL,kH]);
translate([k*oct+0,-wL,0]) cube([oct*1/7-gap,wL,kH]);

//C#:
if (sharpFlag){    
translate([k*oct+oct*1/12,gap,0]) cube([oct*1/12-gap,bL,kH+bH]);
}

//D:
translate([k*oct+oct*2/12,0,0]) cube([oct*1/12-gap,bL,kH]);
translate([k*oct+oct*1/7,-wL,0]) cube([oct*1/7-gap,wL,kH]);

//D#:
if (sharpFlag){
translate([k*oct+oct*3/12,gap,0]) cube([oct*1/12-gap,bL,kH+bH]);
}

//E:
translate([k*oct+oct*4/12,0,0]) cube([2+oct*1/12-gap,bL,kH]);
translate([k*oct+oct*2/7,-wL,0]) cube([oct*1/7-gap,wL,kH]);

//F:
difference(){
    translate([k*oct+oct*3/7,-wL,0]) cube([oct*1/7-gap,wL+bL,kH]);
    translate([k*oct+oct*6/12-2,0,0]) cube([4+oct*(1/7-1/12)-gap,bL,kH]);
}
translate([k*oct+oct*3/7,-wL,0]) cube([oct*1/7-gap,wL,kH]);

//F#:
if (sharpFlag){
translate([k*oct+oct*6/12,gap,0]) cube([oct*1/12-gap,bL,kH+bH]);
}

//G:
translate([k*oct+oct*7/12,0,0]) cube([oct*1/12-gap,bL,kH]);
translate([k*oct+oct*4/7,-wL,0]) cube([oct*1/7-gap,wL,kH]);

//G#:
if (sharpFlag){
translate([k*oct+oct*8/12,gap,0]) cube([oct*1/12-gap,bL,kH+bH]);
}

//A:
translate([k*oct+oct*9/12,0,0]) cube([oct*1/12-gap,bL,kH]);
translate([k*oct+oct*5/7,-wL,0]) cube([oct*1/7-gap,wL,kH]);

//A#:
if (sharpFlag){
translate([k*oct+oct*10/12,gap,0]) cube([oct*1/12-gap,bL,kH+bH]);
}

//B:
translate([k*oct+oct*11/12,0,0]) cube([oct*1/12-gap,bL,kH]);
translate([k*oct+oct*6/7,-wL,0]) cube([oct*1/7-gap,wL,kH]);

}

for (i = [0,2,4,5,7,9,11]){//[0:1:(n_keys-1)]){
    translate([oset+oct*i/12+(oct*1/12-6.2)/2,2+10,-10]) cube([6.2,bL-10,10]);
}

if (sharpFlag){
    for (i = [1,3,6,8,10]){//[0:1:(n_keys-1)]){
    translate([oset+oct*i/12+(oct*1/12-6.2)/2,2+10,-10]) cube([6.2,bL-10,10]);
}
}
