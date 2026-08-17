#rkmoore, 2026-02-01
#v1

import math as math

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
style(stroke='red', stroke_width=0.1);

#kSpace = 0.3*25.4+0.3;#3.56;#13.75;
strSpace = 3.5588;
nKeys = 48;#18;#20;#60;
holeD = 1;#2;#1.5;#0.5;#1;

rH = 6.25*25.4;#nKeys*3.5588+20;#40;#35;
rH2 = 1.375*25.4;

#String alignment grid between harp and zither pin block:
#rect((0, 0), (275, rH), 0)
#rect((0, 0), (137, rH), 3)
rect((0, 0), (rH, rH2), 3)
#for x in range(nKeys):
#	circle((12+x*kSpace+kSpace/2, +1.5), holeD)
rW = 13.75-2;#4;#3;#1.5;
for x in range(nKeys+0):
	#circle((0.65+x*kSpace+kSpace/2, 20), holeD);
	#disLen = 0.65+x*kSpace+kSpace/2; 
	circle(((x-1)*strSpace+0.75*25.4, rH2), holeD);
	#circle((disLen*cos(8.5*3.1415/180), disLen*sin(8.5*3.1415/180)+rH2), holeD);
	#circle((disLen*cos(math.radians(8.5)), disLen*sin(math.radians(8.5)), holeD);



