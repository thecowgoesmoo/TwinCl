#rkmoore, 2026-02-01
#v1

#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
style(stroke='red', stroke_width=0.1);

kSpace = 23;#3.56;#13.75;
#nKeys = 60;#60;
nOct = 5;
#rH = 20;#35;
#holeD = 1.5;#0.5;#1;
#rH2 = 10;

#holeD = 4;
#holeD2 = 8;
#tX = 36;
#tY = 26;
#tR = 3;

holeD3 = 23;
holeD4 = 6.25;

#String alignment grid between harp and zither pin block:
#rect((0, 0), (275, rH), 0)
#rect((0, 0), (80, rH), 3)
#for x in range(nKeys):
#	circle((12+x*kSpace+kSpace/2, +1.5), holeD)
rW = 13.75-2;#4;#3;#1.5;
for y in range(7): #range(nKeys+2):
	for x in range(12):
		circle((x*kSpace+holeD3/2+10,  y*kSpace+holeD3/2+10), holeD3/2)
		#rect((x*tX, (y*12+x)*kSpace), ((x+1)*tX, (y*12+x)*kSpace+tY), tR)
		circle((x*kSpace+holeD3/2+10,  y*kSpace+holeD3/2+10), holeD4/2)


