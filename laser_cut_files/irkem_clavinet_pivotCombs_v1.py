#rkmoore, 2026-01-28
#v0

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
kSpace = 13.75;
nKeys = 20;#60;
rH = 30;#25;
holeD = 1;
chW = 10;
chWin = 6.3;
chH = 12.7;
wallW = (chW-chWin)/2;

vOset = rH + 5;

style(stroke='red', stroke_width=0.1);

#Key chassis pivot comb:
rect((0, 0), (nKeys*kSpace, rH), 0)
for x in range(nKeys+1):
	rect((0+x*kSpace-chW/2, 0), (wallW+x*kSpace-chW/2, chH), 0)

for x in range(nKeys):
	rect((0+x*kSpace+chW/2-wallW, 0), (wallW+x*kSpace+chW/2-wallW, chH), 0)

hOset = 10;
vOset4 = 20;
for x in range(nKeys):
	circle((0+x*kSpace+hOset, 0+vOset4), 1.5)



wallW2 = 4;
#Key upstop comb:
rect((0, 0+vOset), (nKeys*kSpace, rH+vOset), 0)
for x in range(nKeys+1):
	rect((0+x*kSpace-chWin/2-wallW2, 0+vOset), (0+x*kSpace-chWin/2, chH+vOset), 0)

for x in range(nKeys):
	rect((0+x*kSpace+chWin/2, 0+vOset), (0+x*kSpace+chWin/2+wallW2, chH+vOset), 0)

for x in range(nKeys):
	circle((0+x*kSpace+hOset, 0+vOset4), 1.5)

hOset = 10;
vOset4 = 20+vOset;
for x in range(nKeys):
	circle((0+x*kSpace+hOset, 0+vOset4), 1.5)