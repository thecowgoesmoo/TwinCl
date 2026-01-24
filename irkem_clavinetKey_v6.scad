// ==========================================
// PARAMETRIC CLAVINET KEY DESIGN (V7 - Laser SVG)
// ==========================================

/* [Render Mode] */
// Select "Laser_SVG" to see the red cutting paths
mode = "Assembly";//"Laser_SVG"; // [Assembly, Laser_SVG, Chassis_DXF, Cap_STL, Tip_Holder_STL, Pivot_Insert_STL]

/* [Key Dimensions] */
chassis_length = 320;
u_outer_width = 9.525; // 3/8 inch
u_height = 12.7;       // 1/2 inch
wall_thickness = 1.5;  // Approx 1/16 inch
chassis_height = u_height;

/* [Action Geometry] */
strike_point_offset = 85;
pivot_hole_inset = 100;
bolt_size = 3;

// Calculated Positions
pivot_y = chassis_length - pivot_hole_inset;
// IMPORTANT: Moved to 55mm so it catches the Black keys (which start at 45mm)
upstop_y = 55; 
spring_anchor_y = chassis_length; 

/* [Fabrication Vars] */
kerf_width = 3.175;   // 1/8" saw blade width
comb_thickness = 3.0; // Laser cut material thickness
comb_tolerance = 0.1; // Extra clearance for the comb teeth

/* [Key Cap] */
cap_width = 23.5; 
cap_length = 140; 
black_key_front_y = 45;

/* [Hidden] */
$fn = 40;
inner_width = u_outer_width - (wall_thickness*2);

// Standard Geometric Spacing for 164.5mm Octave
// C=0, C#=1, D=2, etc.
key_offsets = [
    0,      // C
    13.7,   // C#
    23.5,   // D
    38.8,   // D#
    47.0,   // E
    70.5,   // F
    82.3,   // F#
    94.0,   // G
    108.3,  // G#
    117.5,  // A
    131.8,  // A#
    141.0   // B
];

// Which keys are Black? (Indices 1, 3, 6, 8, 10)
function is_black(i) = (i==1 || i==3 || i==6 || i==8 || i==10);

// ==========================================
// MAIN RENDER SWITCH
// ==========================================

if (mode == "Assembly") {
    assembly_octave();
} else if (mode == "Laser_SVG") {
    // 2D Projection for Laser Cutting
    color([1,0,0]) // RGB Red (255, 0, 0)
    projection(cut=true) 
        translate([0,0,-0.5]) // Slices through the Z=0 plane of the layout
        layout_for_laser();
} else if (mode == "Pivot_Insert_STL") {
    pivot_insert();
} else if (mode == "Tip_Holder_STL") {
    tip_holder();
}

// ==========================================
// LASER LAYOUT MODULE
// ==========================================

module layout_for_laser() {
    // We lay the 3 combs flat on the XY plane for projection.
    // Bed Size: 300 x 200
    
    // 1. Up-Stop Comb (Top Strip)
    translate([10, 150, 0]) 
        rotate([90,0,0]) // Rotate to lay flat
        comb_generator("upstop");

    // 2. Fulcrum Comb (Middle Strip)
    translate([10, 100, 0]) 
        rotate([90,0,0]) 
        comb_generator("pivot");

    // 3. Spring Anchor Comb (Bottom Strip)
    translate([10, 50, 0]) 
        rotate([90,0,0]) 
        comb_generator("anchor");
}

module comb_generator(type) {
    // Generates a ganged comb for the full octave
    // type: "upstop", "pivot", "anchor"
    
    // Total length of the comb strip (approx 165mm + margins)
    strip_len = 166; 
    
    difference() {
        // The Stock Material Strip
        if (type == "upstop") {
            translate([-10, upstop_y, -5]) 
                cube([strip_len + 20, 3, 20]);
        } else if (type == "pivot") {
            translate([-10, pivot_y - comb_thickness/2, -10]) 
                cube([strip_len + 20, comb_thickness, 20]);
        } else if (type == "anchor") {
            translate([-10, spring_anchor_y, -25]) 
                cube([strip_len + 20, 3, 20]);
        }

        // Subtract the Keys
        // We loop through the 12 semi-tones
        for (i = [0 : 11]) {
            translate([key_offsets[i], 0, 0]) {
                // Determine if this key is Black or White
                if (is_black(i)) {
                    // Subtract Black Key
                     minkowski() {
                        key_chassis(is_white=false);
                        cube([comb_tolerance, comb_tolerance, comb_tolerance], center=true);
                    }
                } else {
                    // Subtract White Key
                    minkowski() {
                        key_chassis(is_white=true);
                        cube([comb_tolerance, comb_tolerance, comb_tolerance], center=true);
                    }
                }
            }
        }
        
        // Add Mounting Holes to the ends of the strip?
        // (Optional: Un-comment to add 3mm mounting holes)
        /*
        translate([-5, (type=="pivot"?pivot_y:upstop_y), 0]) rotate([90,0,0]) cylinder(d=3, h=10, center=true);
        translate([strip_len + 5, (type=="pivot"?pivot_y:upstop_y), 0]) rotate([90,0,0]) cylinder(d=3, h=10, center=true);
        */
        
        // For Anchor: Add the spring holes manually if subtraction didn't catch them
        if (type == "anchor") {
             for (i = [0 : 11]) {
                translate([key_offsets[i] + 15, spring_anchor_y, 15]) 
                    rotate([90,0,0]) cylinder(r=1, h=10, center=true);
             }
        }
    }
}

// ==========================================
// VISUALIZATION ASSEMBLY
// ==========================================

module assembly_octave() {
    // Visualizes the full octave with keys
    for (i = [0 : 11]) {
        translate([key_offsets[i], 0, 0]) {
            if (is_black(i)) {
                // Black Key
                color("gray") key_chassis(is_white=false);
                translate([0,0,chassis_height+8]) color("black") key_cap_b();
                translate([-inner_width/2, pivot_y - 6, wall_thickness]) color("cyan") pivot_insert();
            } else {
                // White Key
                color("silver") key_chassis(is_white=true);
                translate([0,0,chassis_height]) color("ivory") key_cap_w();
                translate([-inner_width/2, pivot_y - 6, wall_thickness]) color("cyan") pivot_insert();
            }
        }
    }
    // Show the Combs in place
    guides_octave();
}

module guides_octave() {
    color("brown") comb_generator("upstop");
    color("brown") comb_generator("pivot");
    color("brown") comb_generator("anchor");
}

// ==========================================
// COMPONENT MODULES (Unchanged Logic)
// ==========================================

module key_chassis(is_white=true) {
    start_y = is_white ? 0 : black_key_front_y; 
    difference() {
        difference() {
            translate([-u_outer_width/2, 0, 0])
                cube([u_outer_width, chassis_length, u_height]);
            translate([-inner_width/2, -1, wall_thickness])
                cube([inner_width, chassis_length + 2, u_height + 1]);
        }
        if (!is_white) {
             translate([-u_outer_width, -10, -1])
                cube([u_outer_width*3, start_y + 10, u_height*3]);
        }
        // Pivot Slot
        translate([-u_outer_width/2-1, pivot_y - kerf_width/2, -1])
            cube([u_outer_width+2, kerf_width, 5]);
        // Tip Holes
        translate([-10, chassis_length - strike_point_offset - cap_length, u_height/2]) {
             translate([0, 6, 0]) rotate([0,90,0]) cylinder(d=bolt_size, h=20);
             translate([0, -6, 0]) rotate([0,90,0]) cylinder(d=bolt_size, h=20);
        }
        // Cap Hole
        translate([0, start_y + 15, u_height/2]) cylinder(d=bolt_size, h=20);
    }
}

module key_cap_w() {
    // (Simplified for SVG speed, geometry maintained)
    difference() {
        union() {
            translate([-cap_width/2, 0, 0]) cube([cap_width, cap_length, 12]);
            translate([-u_outer_width/2 - 2, black_key_front_y, -5]) cube([u_outer_width + 4, 30, 5]);
        }
        translate([-u_outer_width/2, black_key_front_y-1, -5.1]) cube([u_outer_width, 32, 5.2]);
        translate([0, black_key_front_y + 15, -10]) cylinder(d=bolt_size, h=40);
    }
}

module key_cap_b() {
    cap_b_len = cap_length - black_key_front_y;
    difference() {
        translate([-cap_width/4, black_key_front_y, 0]) cube([cap_width/2, cap_b_len, 12]);
        translate([-u_outer_width/2, black_key_front_y-1, -5.1]) cube([u_outer_width, cap_b_len+5, 5.2]);
        translate([0, black_key_front_y + 15, -10]) cylinder(d=bolt_size, h=40);
    }
}

module pivot_insert() {
    fit_tolerance = 0.2; 
    block_w = inner_width - fit_tolerance; 
    block_len = 12;
    block_h = 6; 
    translate([0, 0, 0]) {
        difference() {
            translate([0, 0, block_h/2]) cube([block_w, block_len, block_h], center=true);
            hull() {
                translate([0, 0, -1]) cube([comb_thickness + 0.2, 4, block_h+2], center=true);
                translate([0, 0, block_h]) cube([comb_thickness + 0.5, 6, 1], center=true); 
            }
        }
    }
}

module tip_holder() {
    holder_len = 20;
    difference() {
        union() {
            translate([-inner_width/2, -holder_len/2, 0]) cube([inner_width, holder_len, u_height - 2]);
            translate([0, 0, u_height - 2]) cylinder(d1=8, d2=6, h=6);
        }
        translate([0, 6, u_height/2]) rotate([0,90,0]) cylinder(d=bolt_size, h=20, center=true);
        translate([0, -6, u_height/2]) rotate([0,90,0]) cylinder(d=bolt_size, h=20, center=true);
    }
}