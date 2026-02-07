include <irkem_clavinetKey_v9_UChannel.scad>
include <irkem_keycaps_v2.scad>
cap_w = 22+2;       //White key width
n_keys = 61;        //number of keys
//chassis_length = 270;
//Length of lowest string (uniform gauge at present)
L0 = 48*25.4;       //Baseline string length
skew = 15;          //String skew angle
str_backlen = 116;//200;
strikeLine_y = 0;
strikeLine_z = 0;
anvil_action_h = 0;//2;
pivot_hole_inset = 100;
chassis_height = 12.8;
bolt_size = 3;

//Rendering:
//keybed_rails();
case();
strings();
harp();
keys();
stringBlocks();
keybed_rails();
//customGrid(1000,10);
//customGridR(1000,100);
//customGridYZ(1000,10);
pickups();
damper();
controls();

// Example of a custom grid structure
module customGrid(size, spacing) {
    for (i = [-size : spacing : size]) {
        color("lime") translate([i, -size, 0]) cube([1, 2*size, 1]); // Adjust as needed
        color("lime") translate([-size, i, 0]) cube([2*size, 1, 1]); // Adjust as needed
    }
}

module customGridYZ(size, spacing) {
    for (i = [-size : spacing : size]) {
        color("lime") translate([0, -size, i]) cube([1, 2*size, 1]); // Adjust as needed
        color("lime") translate([0, i, -size]) cube([1, 1, 2*size]); // Adjust as needed
    }
}

// Example of a custom grid structure
module customGridR(size, spacing) {
    for (i = [-size : spacing : size]) {
        color("red") translate([i, -size, 0]) cube([1, 2*size, 1]); // Adjust as needed
        color("red") translate([-size, i, 0]) cube([2*size, 1, 1]); // Adjust as needed
    }
}


module pickups(){
    //Movable pickup angle:
    pAng = 35;//range 0 to 35 degrees
    oAng = -18;
    color("#CCCCCC") translate([850,4,-30]) cube([10,220,15]);
    color("#CCCCCC") translate([830,0,-30]) rotate([0,0,pAng]) cube([10,220,15]);
    //Pickup angle handle:
    color("#000000") translate([830,0,-30]) rotate([0,0,pAng+oAng]) translate([0,-100,0]) cube([5,100,5]);
}

module damper(){
    color("white") translate([860,0,10]) rotate([-90,0,0]) scale([1,0.5,1]) cylinder(220,10,10);
    color("gray") translate([860,0-2-80,10]) rotate([-90,0,0]) cylinder(224+100,2,2);
    color("gray") translate([860,0-2-80-10,10]) rotate([-90,0,0]) cylinder(20,10,10);
    
}

module controls(){
    translate([845,30,55]) cube([60,20,10]);
    translate([845,8,55]) cube([60,20,10]);
    translate([845,-14,55]) cube([60,20,10]);
    translate([845,-36,55]) cube([60,20,10]);
    translate([845,-58,55]) cube([60,20,10]);
}

// --- NEW MODULE: Keybed Support Rails ---
module keybed_rails() {
    // Calculate total length of the bed
    bed_len = n_keys * 13.75 + 40;
    x_start = -20; // Start slightly to the left of the first key
    
    // 1. FULCRUM RAIL (Pivot Support)
    // ------------------------------------------------
    // Calculate Pivot Position based on Key Design
    // Key Local Pivot Y = chassis_length - pivot_hole_inset
    // Key Global Y Offset = -95
    pivot_y_global = -95 + (chassis_length - pivot_hole_inset);
    pivot_z_global = 15 + (chassis_height / 2); // Center of the key spine
    
    color("DimGray")
    translate([x_start, tail_y_global - 5-15.5-4.2, 0+15-7+2])
        rotate([-15,0,0]) cube([bed_len, 1.5*25.4, 17]);
    color("DimGray")
    translate([x_start, tail_y_global - 5-15.5-13-28+5.3, 0+15-7-8])
        rotate([15,0,0]) cube([bed_len, 1.5*25.4, 17]);
    
    // 2. SPRING RAIL (Return Mechanism)
    // ------------------------------------------------
    // Located directly under the tail of the key to pull it down.
    tail_y_global = -95 + chassis_length;
    
    // Rail is positioned low to allow spring extension
    color("DimGray")
    translate([x_start, tail_y_global - 5-15.5+100-4.5, 0+15-7-10+2])
        cube([bed_len, 10, 10]);
        
        
    // 3. FRONT GUIDE RAIL (Lateral Stability)
    // ------------------------------------------------
    // Located near the playing end to guide the keys.
    guide_y_global = -95 + 40+35; // Approx 40mm in from front of chassis
    
    // The Rail Base
    color("SaddleBrown",0.8)
    translate([x_start, guide_y_global - 10-40, 10.5])
        cube([bed_len, 50, 17]); // Stops just below key bottom (Z=15)
    color("SaddleBrown",1.0)
    translate([x_start, guide_y_global - 10-40, 10.5-3])
        cube([bed_len, 330, 3]); // Stops just below key bottom (Z=15)    
    // The Guide Pins (Visual representation)
    // These would slot into the bottom of your keys
    //color("Gold")
    //for(k=[0:n_keys-1]) {
    //    translate([k*13.75, guide_y_global, 14])
    //        cylinder(r=2, h=8); // Pins sticking up
    //}
}

// Render the Rails
//keybed_rails();

// --- STRING GENERATION ---
module strings(){
for (i = [0:1:(n_keys-1)]){
    //    //Da stringz:
    //    //Manage gauge changes and their length impacts:
    lenMult = lookup(i, [
 		[ 0, 0.5 ],
 		[ 2, 0.5 ],
 		[ 3, 0.75 ],
 		[ 7, 0.75 ],
       [ 8, 1.0 ],
 		[ 17, 1.0 ],
        [ 18, 1.5 ],
 		[ 25, 1.5 ],
 		[ 26, 2 ],
        [ 70, 2]
 	]);
    strLen = lenMult * L0 * 2^(-i/12);
    translate([i*13.75,0+strikeLine_y,0+strikeLine_z]) rotate([0,90,skew]) cylinder(strLen,1,1);
    translate([i*13.75,0+strikeLine_y,0+strikeLine_z]) rotate([0,90,skew+180]) cylinder(str_backlen,1,1);
    osetX = (i%3)*15;
    pinXpos = 885+osetX;
    pinYpos = (pinXpos-i*13.75)*tan(skew);
    translate([pinXpos,pinYpos,-20]) cylinder(40,3,3);
}
}

module case(){
//Case bottom:
color("brown",0.6) translate([-230+100+30,-100+20,-12.5-38]) cube([900+154-30,210+160,12.5]);

//Case top:
color("brown",0.6) translate([-230+100+30,-100+20+160,-12.5-38+100]) cube([900+154-30-55+65,210+160-160,12.5]);

//Case back:
color("brown",0.6) translate([-230+100+30,-100+20+160+200,-50]) cube([900+154-30,10,100]);

//Case front:
color("brown",0.6) translate([-230+100+30,-100+20,-50]) cube([900+154-30,10,90]);
    
//Case left:
color("brown",0.6) translate([-230+100+30,-100+20,-50]) cube([10,370,100]);
//Case top left:
color("brown",0.6) translate([-230+100+30,-100+20,-50+100]) cube([90,370,10]);
//Case right:
color("brown",0.6) translate([924,-100+20,-50]) cube([10,370,100]);
//Case top right:
color("brown",0.6) translate([-230+100+30+920,-100+20,-50+100]) cube([114,370,10]);
}


//case();

module harp(){
//Steel harp frame.
//Combination front rail & anvil:
color("gray",1.0) translate([0,0+strikeLine_y,-0+strikeLine_z-anvil_action_h-38]) rotate([90,0,0]) translate([-100,0,0]) difference(){
    cube([100+n_keys*13.75+63,38,38]);
    translate([-1,2.6,2.6]) cube([100+n_keys*13.75+63+2,38,38]);
}
//Right side harp end:
color("gray",1.0) translate([870,0+strikeLine_y,-0+strikeLine_z-anvil_action_h-38]) rotate([0,0,0]) difference(){
    cube([38,270,38]);
    translate([2.6,-1,2.6]) cube([38,270+2,38]);
}
//Skew-side harp frame:
color("gray",1.0) translate([-22,0+strikeLine_y,0+strikeLine_z-38]) rotate([0,0,skew]) translate([-110+40,0,0]) difference(){
    cube([1035,38,38]);
    translate([-41+40,2.6,2.6]) cube([1035+2,38,38]);
}
}

module stringBlocks(){
//Tuner pin block:
color("brown",0.8) translate([0-230+150,-30-22-18,-30-8]) cube([950,67.5,35+0]);
 color("brown",0.8) translate([0-230+150,-30-22-18,-30-8]) cube([950,40,46]);
//Block for ball-ends and bridges:
//color("brown",0.8) translate([700-80-100,0,-30]) cube([350,220,30]);
color("brown",0.8) translate([900-27,0,-35.4]) cube([2*25.4,250,35.4]);
color("brown",0.8) translate([0-230+150,220,-30-8]) cube([950,40,46]);
}

//
// Standard Piano Dimensions
white_key_width = 23.5;
// Black keys are usually centered on the gap, 
// but often offset slightly for visual balance.
// This array defines the offset of each semitone (0-11) from the start of the octave.
// Units are in "White Key Widths"
//octave_offsets = [
//    0,      // 0: C  (White)
//    0.6,    // 1: C# (Black) - shifted right
//    1,      // 2: D  (White)
//    1.65,   // 3: D# (Black) - shifted right
//    2,      // 4: E  (White)
//    3,      // 5: F  (White)
//    3.55,   // 6: F# (Black)
//    4,      // 7: G  (White)
//    4.6,    // 8: G# (Black)
//    5,      // 9: A  (White)
//    5.65,   // 10: A# (Black)
//    6       // 11: B  (White)
//];
module keys(){
octave_offsets = [
    0,      // 0: C  (White)
    7/12,    // 1: C# (Black) - shifted right
    14/12,      // 2: D  (White)
    21/12,   // 3: D# (Black) - shifted right
    28/12,      // 4: E  (White)
    35/12,      // 5: F  (White)
    42/12,   // 6: F# (Black)
    49/12,      // 7: G  (White)
    56/12,    // 8: G# (Black)
    63/12,      // 9: A  (White)
    70/12,   // 10: A# (Black)
    77/12       // 11: B  (White)
];
for (i = [0:1:(n_keys-1)]){
    // 1. Calculate Octave and Note Index
    octave = floor(i / 12);
    note_idx = i % 12; // 0=C, 1=C#, etc.
    
    // 2. Calculate Absolute X Position
    // Position = (Octaves * 7 * width) + (Note Offset * width)
    // NOTE: User has requested Uniform Mechanical Spacing of 13.75
    // so we use simple linear spacing for the mechanics:
    pos_x = i * 13.75;

    // 3. Generate Keys
    // WHITE KEYS
    if (note_idx==0 || note_idx==2 || note_idx==4 || note_idx==5 || note_idx==7 || note_idx==9 || note_idx==11) {
        translate([pos_x, 0-95+50+28, 0+15+3+8]) assembly_w();
    }
    // BLACK KEYS
    else {
        translate([pos_x, 0-95+50+28, 0+15+3+8]) assembly_b();
    }    
    
    // 4. Strings (Already generated above, but loop logic was duplicated in original file. 
    // I've left the original loop at the top and this loop at the bottom per your file structure,
    // but ensured this loop uses the uniform 13.75 spacing for keys as requested).
}
}