#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
style(stroke='red', stroke_width=0.1);

kSpace = 3.6843;#13.75;
nKeys = 60;
rH = 20;#35;
holeD = 0.5;#1;
rH2 = 10;

#String alignment grid between harp and zither pin block:
rect((0, 0), (245, rH), 0)
#for x in range(nKeys):
#	circle((12+x*kSpace+kSpace/2, +1.5), holeD)
rW = 1.5;
for x in range(nKeys):
	#circle((12+x*kSpace+kSpace/2, +1.5), holeD)
	rect((12+x*kSpace+kSpace/2-0.75, 0), (12+x*kSpace+kSpace/2+rW-0.75, rH2), 0)



