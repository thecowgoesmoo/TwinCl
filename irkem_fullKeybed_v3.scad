include <irkem_clavinetKey_v3_UChannel.scad>

cap_w = 22+2;       //White key width
n_keys = 61;        //number of keys

//Length of lowest string (uniform gauge at present)
L0 = 48*25.4;       //Baseline string length
skew = 15;          //String skew angle
str_backlen = 200;
strikeLine_y = 0;
strikeLine_z = 0;
anvil_action_h = 2;

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
    
    // The Pivot Rod (The axle running through all keys)
    color("Silver")
    translate([x_start, pivot_y_global, pivot_z_global])
        rotate([0,90,0])
        cylinder(r=bolt_size/2, h=bed_len); // Matches bolt_size from key file
        
    // The Support Beam (Wood/Aluminum block holding the rod)
    // Sits below the rod.
    color("SaddleBrown")
    translate([x_start, pivot_y_global - 10, pivot_z_global - 25])
        cube([bed_len, 20, 25]); 

    // 2. SPRING RAIL (Return Mechanism)
    // ------------------------------------------------
    // Located directly under the tail of the key to pull it down.
    tail_y_global = -95 + chassis_length;
    
    // Rail is positioned low to allow spring extension
    color("DimGray")
    translate([x_start, tail_y_global - 5, 0])
        cube([bed_len, 10, 10]);
        
    // 3. FRONT GUIDE RAIL (Lateral Stability)
    // ------------------------------------------------
    // Located near the playing end to guide the keys.
    guide_y_global = -95 + 40+35; // Approx 40mm in from front of chassis
    
    // The Rail Base
    color("SaddleBrown")
    translate([x_start, guide_y_global - 10, 0])
        cube([bed_len, 20, 14]); // Stops just below key bottom (Z=15)
        
    // The Guide Pins (Visual representation)
    // These would slot into the bottom of your keys
    color("Gold")
    for(k=[0:n_keys-1]) {
        translate([k*13.75, guide_y_global, 14])
            cylinder(r=2, h=8); // Pins sticking up
    }
}

// Render the Rails
keybed_rails();

// --- EXISTING KEY GENERATION ---

for (i = [0:1:(n_keys-1)]){
    //    type_ind = i % 12;
    //    //Generate white key
    //    if ((type_ind==0)||(type_ind==2)||(type_ind==4)||(type_ind==5)||(type_ind==7)||(type_ind==9)||(type_ind==11)) {
    //        translate([i*13.75,0+strikeLine_y-95,0+strikeLine_z+15]) assembly_w();
    //    }
    //    //Generate black key
    //    if ((type_ind==1)||(type_ind==3)||(type_ind==6)||(type_ind==8)||(type_ind==10)) {
    //        translate([i*13.75,0+strikeLine_y-95,0+strikeLine_z+15]) assembly_b();
    //    }    
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
}
//Case bottom:
color("brown",0.6) translate([-230,-100,-12.5-22]) cube([900+230,210+100,12.5]);

//Steel harp frame.
//Combination front rail & anvil:
color("gray",1.0) translate([0,0+strikeLine_y,-0+strikeLine_z-anvil_action_h]) rotate([-135,0,0]) cube([n_keys*13.75+63,1.25*25.4,1.25*25.4]);
//Right side harp end:
color("gray",1.0) translate([870,0+strikeLine_y,-0+strikeLine_z-anvil_action_h]) rotate([0,90,0]) cube([1.25*25.4,270,1.25*25.4]);
//Skew-side harp frame:
color("gray",1.0) translate([-22,0+strikeLine_y,0+strikeLine_z-1.25*25.4]) rotate([0,0,skew]) cube([960,1.25*25.4,1.25*25.4]);

//Tuner pin block:
color("brown",0.8) translate([0-230,-30-22,-30]) cube([900,30,30]);
//Block for ball-ends and bridges:
color("brown",0.8) translate([700-80-100,0,-30]) cube([350,220,30]);

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
        translate([pos_x, 0-95, 0+15]) assembly_w();
    }
    // BLACK KEYS
    else {
        translate([pos_x, 0-95, 0+15]) assembly_b();
    }    
    
    // 4. Strings (Already generated above, but loop logic was duplicated in original file. 
    // I've left the original loop at the top and this loop at the bottom per your file structure,
    // but ensured this loop uses the uniform 13.75 spacing for keys as requested).
}