#rkmoore, 2026-01-28
#v0

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
kSpace = 13.75;
nKeys = 20;#60;
rH = 25;
holeD = 1;
chW = 10;

#String alignment grid between harp and zither pin block:
rect((0, 0), (nKeys*kSpace, rH), 0)
for x in range(nKeys):
	rect((0+x*kSpace, 0), (chW+x*kSpace, rH/2), 0)

rect((0, rH), (nKeys*kSpace, 2*rH), 0)
for x in range(nKeys):
	rect((0+x*kSpace, rH), (chW+x*kSpace+0.25, rH+rH/2), 0)

rect((0, 2*rH), (nKeys*kSpace, 3*rH), 0)
for x in range(nKeys):
	rect((0+x*kSpace, 2*rH), (chW+x*kSpace+0.5, 2*rH+rH/2), 0)

rect((0, 3*rH), (nKeys*kSpace, 4*rH), 0)
for x in range(nKeys):
	rect((0+x*kSpace, 3*rH), (chW+x*kSpace+0.75, 3*rH+rH/2), 0)

rect((0, 4*rH), (nKeys*kSpace, 5*rH), 0)
for x in range(nKeys):
	rect((0+x*kSpace, 4*rH), (chW+x*kSpace+1, 4*rH+rH/2), 0)

