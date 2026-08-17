$fn = 10;
keySp = 6.5 * 25.4 / 12;
strSkew = 15;
nStrings = 15;
strSp = keySp * sin(strSkew);
eaton15w = 134;
eatonSkew = 90 + strSkew + acos(strSp/(eaton15w/15));

fullGang();
//translate([25.4*6.5*15/12,0,0]) fullGang();
//translate([25.4*13*15/12,0,0]) fullGang();

module eatonStrip15(){
    cube([143,8,12.5]);
}

module stringSet(){
    for (i=[-2:17]){
        //translate([i*keySp,0,0]) rotate([0,90,15]) translate([0,0,-20]) cylinder(400,0.8,0.8);
        translate([i*keySp,0,0]) rotate([0,90,15]) translate([0,0,-20]) cylinder(400,1.2,1.2);
    }
};

module algnGuides(){
    difference(){
        translate([0,0,-8]) cube([keySp*nStrings+10*cos(strSkew),10,10]);
        union(){
            stringSet();
            translate([0,5,-9]) cube([keySp*nStrings+10*cos(strSkew),10-5,10-3]);
            for (x=[1:4]){
                translate([x*50-17,0,-5]) rotate([-90,0,0]) cylinder(10,1.6,1.6);
                //translate([x*50-17,0,-5]) rotate([-90,0,0]) cylinder(10,3.0,3.0);
            }
        }
    }
}

module fullGang(){
 //   translate([205,0,0]) rotate([0,0,eatonSkew]) eatonStrip15();
//translate([0,0,0]) rotate([0,0,-8.5]) eatonStrip15();
//stringSet();
translate([100,22,0]) algnGuides();
}