#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
style(stroke='red', stroke_width=0.1);

kSpace = 3.56;#13.75;
nKeys = 20;#60;
rH = 20;#35;
holeD = 1.5;#0.5;#1;
rH2 = 10;

#String alignment grid between harp and zither pin block:
#rect((0, 0), (275, rH), 0)
rect((0, 0), (80, rH), 3)
#for x in range(nKeys):
#	circle((12+x*kSpace+kSpace/2, +1.5), holeD)
rW = 13.75-2;#4;#3;#1.5;
for x in range(nKeys+2):
	circle((0.65+x*kSpace+kSpace/2, 4+((x+1)%3)*6), holeD)
	#rect((x*kSpace-kSpace/2, 0), (x*kSpace-kSpace/2+rW, rH2), 0)



