( 43 Fret Slots in White Oak for TwinCl )
( Slot Length: 30.0mm | Target Depth: 2.0mm )
( Steps: X+3.684mm, Y+13.75mm per slot )
( Tool: 0.6mm 3-Flute End Mill )

( --- Setup --- )
G21             ( Units in millimeters )
G90             ( Absolute positioning )
G94             ( Feed per minute mode )
M3 S12000       ( Spindle ON, 12000 RPM )
G0 Z5.0         ( Rapid move to Safe Z above the part )

( --- Slot 1 of 43 --- )
( Start: X=0.000, Y=0.000 | End: X=30.000, Y=0.000 )
G0 X0.000 Y0.000    ( Rapid to slot 1 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X30.000 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X0.000 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X30.000 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X0.000 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X30.000 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X0.000 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X30.000 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X0.000 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X30.000 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X0.000 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 2 of 43 --- )
( Start: X=3.684, Y=13.750 | End: X=33.684, Y=13.750 )
G0 X3.684 Y13.750    ( Rapid to slot 2 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X33.684 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X3.684 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X33.684 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X3.684 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X33.684 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X3.684 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X33.684 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X3.684 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X33.684 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X3.684 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 3 of 43 --- )
( Start: X=7.368, Y=27.500 | End: X=37.368, Y=27.500 )
G0 X7.368 Y27.500    ( Rapid to slot 3 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X37.368 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X7.368 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X37.368 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X7.368 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X37.368 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X7.368 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X37.368 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X7.368 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X37.368 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X7.368 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 4 of 43 --- )
( Start: X=11.052, Y=41.250 | End: X=41.052, Y=41.250 )
G0 X11.052 Y41.250    ( Rapid to slot 4 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X41.052 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X11.052 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X41.052 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X11.052 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X41.052 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X11.052 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X41.052 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X11.052 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X41.052 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X11.052 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 5 of 43 --- )
( Start: X=14.736, Y=55.000 | End: X=44.736, Y=55.000 )
G0 X14.736 Y55.000    ( Rapid to slot 5 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X44.736 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X14.736 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X44.736 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X14.736 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X44.736 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X14.736 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X44.736 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X14.736 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X44.736 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X14.736 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 6 of 43 --- )
( Start: X=18.420, Y=68.750 | End: X=48.420, Y=68.750 )
G0 X18.420 Y68.750    ( Rapid to slot 6 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X48.420 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X18.420 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X48.420 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X18.420 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X48.420 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X18.420 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X48.420 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X18.420 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X48.420 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X18.420 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 7 of 43 --- )
( Start: X=22.104, Y=82.500 | End: X=52.104, Y=82.500 )
G0 X22.104 Y82.500    ( Rapid to slot 7 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X52.104 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X22.104 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X52.104 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X22.104 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X52.104 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X22.104 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X52.104 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X22.104 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X52.104 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X22.104 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 8 of 43 --- )
( Start: X=25.788, Y=96.250 | End: X=55.788, Y=96.250 )
G0 X25.788 Y96.250    ( Rapid to slot 8 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X55.788 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X25.788 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X55.788 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X25.788 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X55.788 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X25.788 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X55.788 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X25.788 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X55.788 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X25.788 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 9 of 43 --- )
( Start: X=29.472, Y=110.000 | End: X=59.472, Y=110.000 )
G0 X29.472 Y110.000    ( Rapid to slot 9 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X59.472 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X29.472 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X59.472 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X29.472 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X59.472 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X29.472 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X59.472 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X29.472 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X59.472 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X29.472 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 10 of 43 --- )
( Start: X=33.156, Y=123.750 | End: X=63.156, Y=123.750 )
G0 X33.156 Y123.750    ( Rapid to slot 10 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X63.156 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X33.156 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X63.156 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X33.156 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X63.156 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X33.156 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X63.156 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X33.156 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X63.156 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X33.156 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 11 of 43 --- )
( Start: X=36.840, Y=137.500 | End: X=66.840, Y=137.500 )
G0 X36.840 Y137.500    ( Rapid to slot 11 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X66.840 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X36.840 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X66.840 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X36.840 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X66.840 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X36.840 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X66.840 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X36.840 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X66.840 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X36.840 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 12 of 43 --- )
( Start: X=40.524, Y=151.250 | End: X=70.524, Y=151.250 )
G0 X40.524 Y151.250    ( Rapid to slot 12 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X70.524 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X40.524 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X70.524 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X40.524 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X70.524 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X40.524 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X70.524 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X40.524 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X70.524 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X40.524 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 13 of 43 --- )
( Start: X=44.208, Y=165.000 | End: X=74.208, Y=165.000 )
G0 X44.208 Y165.000    ( Rapid to slot 13 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X74.208 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X44.208 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X74.208 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X44.208 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X74.208 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X44.208 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X74.208 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X44.208 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X74.208 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X44.208 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 14 of 43 --- )
( Start: X=47.892, Y=178.750 | End: X=77.892, Y=178.750 )
G0 X47.892 Y178.750    ( Rapid to slot 14 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X77.892 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X47.892 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X77.892 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X47.892 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X77.892 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X47.892 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X77.892 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X47.892 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X77.892 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X47.892 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 15 of 43 --- )
( Start: X=51.576, Y=192.500 | End: X=81.576, Y=192.500 )
G0 X51.576 Y192.500    ( Rapid to slot 15 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X81.576 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X51.576 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X81.576 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X51.576 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X81.576 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X51.576 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X81.576 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X51.576 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X81.576 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X51.576 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 16 of 43 --- )
( Start: X=55.260, Y=206.250 | End: X=85.260, Y=206.250 )
G0 X55.260 Y206.250    ( Rapid to slot 16 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X85.260 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X55.260 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X85.260 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X55.260 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X85.260 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X55.260 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X85.260 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X55.260 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X85.260 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X55.260 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 17 of 43 --- )
( Start: X=58.944, Y=220.000 | End: X=88.944, Y=220.000 )
G0 X58.944 Y220.000    ( Rapid to slot 17 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X88.944 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X58.944 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X88.944 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X58.944 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X88.944 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X58.944 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X88.944 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X58.944 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X88.944 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X58.944 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 18 of 43 --- )
( Start: X=62.628, Y=233.750 | End: X=92.628, Y=233.750 )
G0 X62.628 Y233.750    ( Rapid to slot 18 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X92.628 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X62.628 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X92.628 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X62.628 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X92.628 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X62.628 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X92.628 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X62.628 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X92.628 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X62.628 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 19 of 43 --- )
( Start: X=66.312, Y=247.500 | End: X=96.312, Y=247.500 )
G0 X66.312 Y247.500    ( Rapid to slot 19 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X96.312 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X66.312 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X96.312 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X66.312 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X96.312 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X66.312 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X96.312 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X66.312 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X96.312 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X66.312 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 20 of 43 --- )
( Start: X=69.996, Y=261.250 | End: X=99.996, Y=261.250 )
G0 X69.996 Y261.250    ( Rapid to slot 20 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X99.996 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X69.996 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X99.996 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X69.996 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X99.996 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X69.996 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X99.996 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X69.996 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X99.996 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X69.996 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 21 of 43 --- )
( Start: X=73.680, Y=275.000 | End: X=103.680, Y=275.000 )
G0 X73.680 Y275.000    ( Rapid to slot 21 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X103.680 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X73.680 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X103.680 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X73.680 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X103.680 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X73.680 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X103.680 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X73.680 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X103.680 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X73.680 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 22 of 43 --- )
( Start: X=77.364, Y=288.750 | End: X=107.364, Y=288.750 )
G0 X77.364 Y288.750    ( Rapid to slot 22 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X107.364 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X77.364 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X107.364 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X77.364 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X107.364 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X77.364 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X107.364 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X77.364 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X107.364 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X77.364 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 23 of 43 --- )
( Start: X=81.048, Y=302.500 | End: X=111.048, Y=302.500 )
G0 X81.048 Y302.500    ( Rapid to slot 23 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X111.048 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X81.048 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X111.048 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X81.048 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X111.048 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X81.048 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X111.048 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X81.048 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X111.048 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X81.048 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 24 of 43 --- )
( Start: X=84.732, Y=316.250 | End: X=114.732, Y=316.250 )
G0 X84.732 Y316.250    ( Rapid to slot 24 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X114.732 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X84.732 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X114.732 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X84.732 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X114.732 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X84.732 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X114.732 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X84.732 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X114.732 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X84.732 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 25 of 43 --- )
( Start: X=88.416, Y=330.000 | End: X=118.416, Y=330.000 )
G0 X88.416 Y330.000    ( Rapid to slot 25 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X118.416 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X88.416 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X118.416 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X88.416 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X118.416 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X88.416 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X118.416 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X88.416 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X118.416 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X88.416 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 26 of 43 --- )
( Start: X=92.100, Y=343.750 | End: X=122.100, Y=343.750 )
G0 X92.100 Y343.750    ( Rapid to slot 26 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X122.100 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X92.100 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X122.100 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X92.100 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X122.100 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X92.100 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X122.100 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X92.100 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X122.100 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X92.100 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 27 of 43 --- )
( Start: X=95.784, Y=357.500 | End: X=125.784, Y=357.500 )
G0 X95.784 Y357.500    ( Rapid to slot 27 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X125.784 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X95.784 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X125.784 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X95.784 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X125.784 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X95.784 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X125.784 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X95.784 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X125.784 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X95.784 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 28 of 43 --- )
( Start: X=99.468, Y=371.250 | End: X=129.468, Y=371.250 )
G0 X99.468 Y371.250    ( Rapid to slot 28 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X129.468 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X99.468 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X129.468 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X99.468 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X129.468 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X99.468 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X129.468 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X99.468 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X129.468 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X99.468 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 29 of 43 --- )
( Start: X=103.152, Y=385.000 | End: X=133.152, Y=385.000 )
G0 X103.152 Y385.000    ( Rapid to slot 29 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X133.152 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X103.152 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X133.152 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X103.152 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X133.152 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X103.152 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X133.152 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X103.152 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X133.152 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X103.152 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 30 of 43 --- )
( Start: X=106.836, Y=398.750 | End: X=136.836, Y=398.750 )
G0 X106.836 Y398.750    ( Rapid to slot 30 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X136.836 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X106.836 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X136.836 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X106.836 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X136.836 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X106.836 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X136.836 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X106.836 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X136.836 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X106.836 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 31 of 43 --- )
( Start: X=110.520, Y=412.500 | End: X=140.520, Y=412.500 )
G0 X110.520 Y412.500    ( Rapid to slot 31 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X140.520 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X110.520 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X140.520 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X110.520 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X140.520 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X110.520 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X140.520 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X110.520 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X140.520 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X110.520 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 32 of 43 --- )
( Start: X=114.204, Y=426.250 | End: X=144.204, Y=426.250 )
G0 X114.204 Y426.250    ( Rapid to slot 32 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X144.204 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X114.204 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X144.204 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X114.204 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X144.204 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X114.204 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X144.204 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X114.204 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X144.204 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X114.204 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 33 of 43 --- )
( Start: X=117.888, Y=440.000 | End: X=147.888, Y=440.000 )
G0 X117.888 Y440.000    ( Rapid to slot 33 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X147.888 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X117.888 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X147.888 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X117.888 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X147.888 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X117.888 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X147.888 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X117.888 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X147.888 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X117.888 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 34 of 43 --- )
( Start: X=121.572, Y=453.750 | End: X=151.572, Y=453.750 )
G0 X121.572 Y453.750    ( Rapid to slot 34 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X151.572 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X121.572 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X151.572 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X121.572 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X151.572 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X121.572 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X151.572 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X121.572 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X151.572 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X121.572 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 35 of 43 --- )
( Start: X=125.256, Y=467.500 | End: X=155.256, Y=467.500 )
G0 X125.256 Y467.500    ( Rapid to slot 35 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X155.256 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X125.256 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X155.256 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X125.256 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X155.256 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X125.256 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X155.256 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X125.256 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X155.256 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X125.256 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 36 of 43 --- )
( Start: X=128.940, Y=481.250 | End: X=158.940, Y=481.250 )
G0 X128.940 Y481.250    ( Rapid to slot 36 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X158.940 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X128.940 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X158.940 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X128.940 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X158.940 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X128.940 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X158.940 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X128.940 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X158.940 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X128.940 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 37 of 43 --- )
( Start: X=132.624, Y=495.000 | End: X=162.624, Y=495.000 )
G0 X132.624 Y495.000    ( Rapid to slot 37 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X162.624 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X132.624 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X162.624 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X132.624 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X162.624 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X132.624 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X162.624 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X132.624 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X162.624 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X132.624 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 38 of 43 --- )
( Start: X=136.308, Y=508.750 | End: X=166.308, Y=508.750 )
G0 X136.308 Y508.750    ( Rapid to slot 38 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X166.308 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X136.308 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X166.308 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X136.308 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X166.308 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X136.308 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X166.308 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X136.308 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X166.308 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X136.308 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 39 of 43 --- )
( Start: X=139.992, Y=522.500 | End: X=169.992, Y=522.500 )
G0 X139.992 Y522.500    ( Rapid to slot 39 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X169.992 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X139.992 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X169.992 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X139.992 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X169.992 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X139.992 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X169.992 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X139.992 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X169.992 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X139.992 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 40 of 43 --- )
( Start: X=143.676, Y=536.250 | End: X=173.676, Y=536.250 )
G0 X143.676 Y536.250    ( Rapid to slot 40 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X173.676 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X143.676 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X173.676 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X143.676 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X173.676 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X143.676 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X173.676 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X143.676 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X173.676 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X143.676 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 41 of 43 --- )
( Start: X=147.360, Y=550.000 | End: X=177.360, Y=550.000 )
G0 X147.360 Y550.000    ( Rapid to slot 41 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X177.360 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X147.360 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X177.360 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X147.360 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X177.360 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X147.360 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X177.360 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X147.360 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X177.360 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X147.360 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 42 of 43 --- )
( Start: X=151.044, Y=563.750 | End: X=181.044, Y=563.750 )
G0 X151.044 Y563.750    ( Rapid to slot 42 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X181.044 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X151.044 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X181.044 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X151.044 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X181.044 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X151.044 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X181.044 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X151.044 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X181.044 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X151.044 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Slot 43 of 43 --- )
( Start: X=154.728, Y=577.500 | End: X=184.728, Y=577.500 )
G0 X154.728 Y577.500    ( Rapid to slot 43 start position )

( Pass 1: Depth -0.200mm )
G1 Z-0.200 F20    ( Plunge slow in the air )
G1 X184.728 F200   ( Cut Left to Right )

( Pass 2: Depth -0.400mm )
G1 Z-0.400 F20    ( Plunge in the air on the right side )
G1 X154.728 F200    ( Cut Right to Left )

( Pass 3: Depth -0.600mm )
G1 Z-0.600 F20
G1 X184.728 F200

( Pass 4: Depth -0.800mm )
G1 Z-0.800 F20
G1 X154.728 F200

( Pass 5: Depth -1.000mm )
G1 Z-1.000 F20
G1 X184.728 F200

( Pass 6: Depth -1.200mm )
G1 Z-1.200 F20
G1 X154.728 F200

( Pass 7: Depth -1.400mm )
G1 Z-1.400 F20
G1 X184.728 F200

( Pass 8: Depth -1.600mm )
G1 Z-1.600 F20
G1 X154.728 F200

( Pass 9: Depth -1.800mm )
G1 Z-1.800 F20
G1 X184.728 F200

( Pass 10: Depth -2.000mm )
G1 Z-2.000 F20
G1 X154.728 F200    ( Final cut Right to Left, tool ends up back at left side )
G0 Z5.0         ( Rapid retract to Safe Z )

( --- Cleanup & End --- )
G0 Z5.0         ( Rapid retract to Safe Z )
G0 X0.0 Y0.0    ( Return to origin )
M5              ( Spindle OFF )
M30             ( End of Program )
