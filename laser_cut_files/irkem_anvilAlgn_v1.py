#rkmoore, 2026-01-28
#v0

# Define the red style for K40 Whisperer (Red stroke, no fill)
#cut_style = {'stroke': '#ff0000', 'fill': 'none', 'stroke-width': '0.1mm'}
style(stroke='red', stroke_width=0.1);
#This is the string spacing at the righthand harp crossbar
# keyChassisSpace * tan(skewAng)
kSpace = 13.75;
nKeys = 20;#60;
rH = 25;
holeD = 1;
chW = 10.5;#12.7;#10;
chH = 25.4/6;#12.7;#8;
vOset = 8;#10;
hOset = 2;
vOset2 = -0.6;
vOset3 = 4;
vOset4 = 20;
#String alignment grid between harp and zither pin block:
rect((0, 0), (nKeys*kSpace, rH), 0)
#for x in range(nKeys):
#	rect((0+x*kSpace, 0+vOset), (chW+x*kSpace, chH+vOset), 0).rotate(-15,'ul')

for x in range(nKeys):
	rect((0+x*kSpace+hOset, 0+vOset+vOset2), (chW+x*kSpace+hOset, chH+vOset+vOset2), 0).rotate(-15,'ul')

for x in range(nKeys):
	circle((0+x*kSpace+hOset, 0+vOset3), 1.5)

for x in range(nKeys):
	circle((0+x*kSpace+hOset, 0+vOset4), 1.5)

#for x in range(nKeys):#
#	rect((0+x*kSpace, 0+vOset), (chH+x*kSpace, chH+vOset), 0).rotate(-15,'ul')



