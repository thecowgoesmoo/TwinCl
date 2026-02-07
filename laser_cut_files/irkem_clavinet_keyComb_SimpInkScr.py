UwidthOut = 10;
UwidthIn = 6;
kSpace = 13.75;
nKeys = 12;
rH = 1.75*25.4;#50;
rH3 = 20;
sp = 2;

#Key spring rail:
rect((0, 0), (nKeys*kSpace, rH), 0)
for x in range(nKeys):
	circle((x*kSpace+kSpace/2, 10), 2)
	circle((x*kSpace+kSpace/2, 3.5), 2)

oSet1 = rH + sp;
#Key pivot rail:
rect((0,oSet1), (nKeys*kSpace, oSet1+rH), 0)
for x in range(nKeys):
	rect((x*kSpace+(kSpace-UwidthOut)/2, oSet1), (x*kSpace+(kSpace-UwidthOut)/2+1.5, oSet1+5), 0)
	rect((x*kSpace+(kSpace-UwidthOut)/2+UwidthIn-1.5, oSet1), (x*kSpace+(kSpace-UwidthOut)/2+UwidthIn, oSet1+5), 0)

oSet2 = 2*rH + 2*sp;
#Key up-stop rail:
rect((0, oSet2), (nKeys*kSpace, oSet2+rH3), 0)
for x in range(nKeys):
	rect((x*kSpace, oSet2), (x*kSpace+(kSpace-UwidthIn)/2, oSet2+5), 0)
	rect((x*kSpace-(kSpace-UwidthIn)/2, oSet2), (x*kSpace, oSet2+5), 0)

