#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
#style(stroke='red', stroke_width=0.1);
style(stroke='blue', stroke_width=0.1);

kSpace = 13.75;
theta = (15/180)*3.1415;
nKeys = 60;
rH = 20;#35;
holeD = 0.5;#1;
rH2 = 10;
linLen = 140;

#String alignment grid between harp and zither pin block:
rect((0, 0), (245, rH), 0)
#for x in range(nKeys):
#	circle((12+x*kSpace+kSpace/2, +1.5), holeD)
rW = 1.5;
for x in range(nKeys):
	#circle((12+x*kSpace+kSpace/2, +1.5), holeD)
	#rect((12+x*kSpace+kSpace/2-0.75, 0), (12+x*kSpace+kSpace/2+rW-0.75, rH2), 0)
	x1 = x*kSpace;
	y1 = 0;
	x2 = x*kSpace+linLen*cos(theta);
	y2 = linLen*sin(theta);
	line((x1, y1), (x2, y2));



