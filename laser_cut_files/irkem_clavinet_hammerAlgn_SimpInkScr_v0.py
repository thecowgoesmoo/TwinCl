#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
kSpace = 13.75;#3.6843;#13.75;
nKeys = 20;#60;
rH = 90;#35;
holeD = 11.0/2.0;#0.5;#1;
rW = 25.4*6.5*20.0/12.0;

#String alignment grid between harp and zither pin block:
rect((0, 0), (rW, rH), 0)
for x in range(nKeys):
	circle((0+x*kSpace+kSpace/2, 60), holeD)

rect((0, 0), (rW, rH), 0)
for x in range(nKeys):
	circle((0+x*kSpace+kSpace/2, 60-3), holeD)


rect((0, 0), (rW, rH), 0)
for x in range(nKeys):
	circle((0+x*kSpace+kSpace/2, 60+3), holeD)
