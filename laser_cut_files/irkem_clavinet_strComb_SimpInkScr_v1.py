#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
kSpace = 3.6843;#13.75;
nKeys = 60;
rH = 35;
holeD = 0.5;#1;

#String alignment grid between harp and zither pin block:
rect((0, 0), (245, rH), 0)
for x in range(nKeys):
	circle((12+x*kSpace+kSpace/2, +1.5), holeD)



