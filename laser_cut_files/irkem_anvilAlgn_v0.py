#rkmoore, 2026-01-28
#v0

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
kSpace = 13.75;
nKeys = 20;#60;
rH = 25;
holeD = 1;
chW = 10.5;#12.7;#10;
chH = 12.7;#8;
vOset = 4;#10;

#String alignment grid between harp and zither pin block:
rect((0, 0), (nKeys*kSpace, rH), 0)
for x in range(nKeys):
	rect((0+x*kSpace, 0+vOset), (chW+x*kSpace, chH+vOset), 0).rotate(-15,'ul')

#for x in range(nKeys):#
#	rect((0+x*kSpace, 0+vOset), (chH+x*kSpace, chH+vOset), 0).rotate(-15,'ul')



