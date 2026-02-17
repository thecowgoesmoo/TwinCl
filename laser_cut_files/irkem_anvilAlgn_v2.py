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
chW = 12;#22;#10.5;#12.7;#10;
chH = 25.4/8;#25.4/6;#12.7;#8;
vOset = 6;#8;#10;
hOset = 0;#2;
vOset2 = -0.6;
vOset4 = 14;#20;

vOset3 = 1+0.8-0.3;#4;
hOset2 = -6-3+1.5;

#String alignment grid between harp and zither pin block:
rect((0, 0), (nKeys*kSpace, rH), 0)

for x in range(nKeys+1):
	rect((0+x*kSpace+hOset, 0+vOset+vOset2), (chW+x*kSpace+hOset, chH+vOset+vOset2), 0).rotate(-15,'ul')

#for x in range(nKeys+1):
#	rect((0+x*kSpace+hOset+hOset2, 0+vOset+vOset3), (chW+x*kSpace+hOset+hOset2, chH+vOset+vOset3), 0).rotate(-15,'ul')

#for x in range(nKeys):
#	circle((0+x*kSpace+hOset, 0+vOset3), 1.5)#

for x in range(nKeys):
	circle((0+x*kSpace+hOset, 0+vOset4), 1.5)




