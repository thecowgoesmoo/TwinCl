#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
totalOset = 50;
kSpace = 13.75;#3.6843;#13.75;
nKeys = 20;
rH = 10;#15;
holeD = 0.5;#1;

#String alignment grid between harp and zither pin block:
rect((0, 0+totalOset), (275, rH+totalOset))
for x in range(nKeys):
	circle((0+x*kSpace+kSpace/2, 2+totalOset), holeD)
for x in [0,50,100,150,200,250]:
	circle((0+x+15, 7+totalOset), 1.5)


