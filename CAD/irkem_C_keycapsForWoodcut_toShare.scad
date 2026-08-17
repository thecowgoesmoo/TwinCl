
xO = -6;
yO = -11;
zO = 40;

kH = 10;
bH = 10;
wL = 50;
bL = 80;
oct = 6.5 * 25.4;
gap = 2;
n_oct = 1;
n_keys = 12;
oset = -1;

kn = 2;

sharpFlag = 0;//1;

ifD = 0;
ifE = 0;
ifF = 0;
ifG = 0;
ifA = 0;
ifB = 0;

k = 0;
//C:
color("ivory") translate([k*oct+0+xO,0+yO,0+zO]) cube([oct*1/12-gap,bL,kH]);
color("ivory") translate([k*oct+0+xO,-wL+yO,0+zO]) cube([oct*1/7-gap,wL,kH]);
//}

for (i = [0]){
    translate([oset+oct*i/12+(oct*1/12-6.2)/2+xO+0*oct,2+10+yO+12+3-4,-10+zO]) cube([6.2,bL-10-7-12-4+8,10]);
}

