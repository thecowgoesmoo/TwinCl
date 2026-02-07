include <irkem_hammerTips_v0.scad>

xO = -6;
yO = -11;
zO = 40;

kH = 4;
bH = 10;
wL = 50;
bL = 80;
oct = 6.5 * 25.4;
gap = 2;
n_oct = 1;//5;
n_keys = 12 * n_oct;
oset = -1;

sharpFlag = 1;

for (k = [4]){//:1:(n_keys-1)]){
    //
    translate([k*13.75+6.0+xO,12+yO,-12.5+zO]) rotate([0,180,0]) hammerTips();
}

for (k = [0:1:(n_oct-1)]){

//C:
//color("ivory") translate([k*oct+0+xO,0+yO,0+zO]) cube([oct*1/12-gap,bL,kH]);
//color("ivory") translate([k*oct+0+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);

////C#:
//if (sharpFlag){    
//color("black") translate([k*oct+oct*1/12+xO,gap+yO,0+zO]) cube([oct*1/12-gap,bL,kH+bH]);
//}//

////D:
//color("ivory") translate([k*oct+oct*2/12+xO,0+yO,0+zO]) cube([oct*1/12-gap,bL,kH]);
//color("ivory") translate([k*oct+oct*1/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);//

////D#:
//if (sharpFlag){
//color("black") translate([k*oct+oct*3/12+xO,gap+yO,0+zO]) cube([oct*1/12-gap,bL,kH+bH]);
//}//

////E:
color("ivory") translate([k*oct+oct*4/12+xO,0+yO,0+zO]) cube([2+oct*1/12-gap,bL,kH]);
color("ivory") translate([k*oct+oct*2/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);//

////F:
//color("ivory") difference(){
//    translate([k*oct+oct*3/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL+bL,kH]);
//    translate([k*oct+oct*6/12-2+xO,0+yO,0+zO]) cube([4+oct*(1/7-1/12)-gap,bL,kH]);
//}
//color("ivory") translate([k*oct+oct*3/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);//

////F#:
//if (sharpFlag){
//color("black") translate([k*oct+oct*6/12+xO,gap+yO,0+zO]) cube([oct*1/12-gap,bL,kH+bH]);
//}//

////G:
//color("ivory") translate([k*oct+oct*7/12+xO,0+yO,0+zO]) cube([oct*1/12-gap,bL,kH]);
//color("ivory") translate([k*oct+oct*4/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);//

////G#:
//if (sharpFlag){
//color("black") translate([k*oct+oct*8/12+xO,gap+yO,0+zO]) cube([oct*1/12-gap,bL,kH+bH]);
//}//

////A:
//color("ivory") translate([k*oct+oct*9/12+xO,0+yO,0+zO]) cube([oct*1/12-gap,bL,kH]);
//color("ivory") translate([k*oct+oct*5/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);//

////A#:
//if (sharpFlag){
//color("black") translate([k*oct+oct*10/12+xO,gap+yO,0+zO]) cube([oct*1/12-gap,bL,kH+bH]);
//}//

////B:
//color("ivory") translate([k*oct+oct*11/12+xO,0+yO,0+zO]) cube([oct*1/12-gap,bL,kH]);
//color("ivory") translate([k*oct+oct*6/7+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);//

}

for (i = [4]){//,2,4,5,7,9,11]){//[0:1:(n_keys-1)]){
    translate([oset+oct*i/12+(oct*1/12-6.2)/2+xO,2+10+yO,-10+zO]) cube([6.2,bL-10,10]);
}

//if (sharpFlag){
//    for (i = [1,3,6,8,10]){//[0:1:(n_keys-1)]){
//    translate([oset+oct*i/12+(oct*1/12-6.2)/2+xO,2+10+yO,-10+zO]) cube([6.2,bL-10,10]);
//}
//}
