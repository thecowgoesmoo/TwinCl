// ==========================================
// PARAMETRIC CLAVINET KEY DESIGN (V4 - U-Channel & Combs)
// ==========================================
chassis_length = 270;//320;
/* [Render Mode] */
mode = "Assembly"; // [Assembly, Chassis_DXF, Cap_STL, Tip_Holder_STL, Pivot_Insert_STL]

/* [Key Dimensions] */
chassis_length = 320;
// -- U-CHANNEL DIMENSIONS --
u_outer_width = 9.525; // 3/8 inch
//u_height = //12.7;       // 1/2 inch
wall_thickness = 1.5;  // Approx 1/16 inch
u_height = 12.7;
chassis_height = u_height;

/* [Action Geometry] */
strike_point_offset = 115;//85;
tip_clearance = 6;
pivot_hole_inset = 100;
bolt_size = 3;

// Calculated Positions
pivot_y = chassis_length - pivot_hole_inset;
upstop_y = -20;//30; 
spring_anchor_y = chassis_length; // At the tail

/* [Fabrication Vars] */
kerf_width = 3.175; // 1/8" saw blade width
comb_thickness = 3.0; // Laser cut material thickness

/* [Key Cap] */
cap_width = 23.5; 
cap_length = 140; 
cap_wall = 2;
black_key_front_y = 45;

/* [Hidden] */
$fn = 40;
inner_width = u_outer_width - (wall_thickness*2);

// ==========================================
// MAIN RENDER SWITCH
// ==========================================

if (mode == "Assembly") {
    //assembly_w();
} else if (mode == "Chassis_DXF") {
    projection() rotate([0,90,0]) key_chassis();
} else if (mode == "Cap_STL") {
    rotate([180,0,0]) key_cap_w();
} else if (mode == "Tip_Holder_STL") {
    tip_holder();
} else if (mode == "Pivot_Insert_STL") {
    pivot_insert();
}


// ==========================================
// ASSEMBLIES
// ==========================================

module assembly_w() {
    // White Key
    color("silver") key_chassis(is_white=true);
    
    translate([0, 0, chassis_height]) 
        color("ivory") translate([0,-50,0]) key_cap_w();
        
    translate([0, chassis_length - strike_point_offset - cap_length, 0]) 
        rotate([180,0,0])
        color("orange") tip_holder();

    // The new 3D printed bearing insert
    //translate([-0*u_outer_width/2 + 0*wall_thickness, pivot_y, wall_thickness])
        //rotate([0,0,90])
        //color("cyan") pivot_insert();

    guides();
}

module assembly_b() {
    // Black key
    color("silver") key_chassis(is_white=true);
    
    translate([0, 0, chassis_height]) 
        color("black") translate([0,-50,0]) key_cap_b();
        
    translate([0, chassis_length - strike_point_offset - cap_length, 0]) 
        rotate([180,0,0])
        color("orange") tip_holder();

    // The new 3D printed bearing insert
    //translate([-0*u_outer_width/2 + 0*wall_thickness, pivot_y, wall_thickness])
        //rotate([0,0,90])
        //color("cyan") pivot_insert();

    guides();
}

// ==========================================
// COMPONENT MODULES
// ==========================================

module key_chassis(is_white=true) {
    // The Aluminum U-Channel (OPEN SIDE UP)
    // Z=0 is the bottom web (outside). 
    start_y = is_white ? 0 : black_key_front_y; 
    
    difference() {
        // 1. The U-Channel Extrusion
        difference() {
            // Solid Block
            translate([-u_outer_width/2, 0, 0])
                cube([u_outer_width, chassis_length, u_height]);
            // Inner Cavity (Open at Top)
            translate([-u_outer_width/2 + wall_thickness, -1, wall_thickness])
                cube([inner_width, chassis_length + 2, u_height + 1]);
        }

        // -- CUTOUTS --
        // 2. Front Truncation (For Black Keys)
        if (!is_white) {
             translate([-u_outer_width, -10, -1])
                cube([u_outer_width*3, start_y + 10, u_height*3]);
        }

        // 3. Pivot slot (The Kerf Cut)
        // Cuts through bottom web and slightly up the sides
        translate([-u_outer_width/2-1, pivot_y - kerf_width/2, -1])
            cube([u_outer_width+2, kerf_width, 5]);

        // 4. Tip Holder Holes
        translate([-10, chassis_length - strike_point_offset - cap_length, u_height/2]) {
             translate([0, 6, 0]) rotate([0,90,0]) cylinder(d=bolt_size, h=20);
             translate([0, -6, 0]) rotate([0,90,0]) cylinder(d=bolt_size, h=20);
        }
        
        // 5. Cap Mounting Hole 
        translate([0, start_y + 15, u_height/2]) 
            cylinder(d=bolt_size, h=20);
    }
}

module pivot_insert() {
    // A 3D printed block that fits INSIDE the U-channel.
    // It captures the comb to prevent fore/aft slop.
    
    fit_tolerance = 0.2; // Clearance for inserting into aluminum
    block_w = inner_width - fit_tolerance; 
    block_len = 12;
    block_h = 6;
    
    // Positioned centered on origin for easy export
    translate([-block_len/2, -block_w/2, 0]) {
        difference() {
            // Main body
            cube([block_len, block_w, block_h]);
            
            // The Comb Slot (Tapered for easy entry)
            // Precise width at the top (pivot point), wider at bottom
            translate([block_len/2 - comb_thickness/2, -1, -1])
                hull() {
                    cube([comb_thickness, block_w+2, block_h+2]); // Straight slot
                    // Or add taper if desired
                }
            
            // Optional: Viewing hole or material saver
            translate([block_len/2, block_w/2, block_h/2])
                rotate([90,0,0])
                cylinder(d=3, h=block_w+2, center=true);
        }
        
        // Crush Ribs (Tiny bumps to hold it inside the aluminum channel)
        translate([0, -0.2, block_h/2]) cylinder(r=0.4, h=block_h, $fn=3);
        translate([block_len, -0.2, block_h/2]) cylinder(r=0.4, h=block_h, $fn=3);
        translate([0, block_w+0.2, block_h/2]) cylinder(r=0.4, h=block_h, $fn=3);
        translate([block_len, block_w+0.2, block_h/2]) cylinder(r=0.4, h=block_h, $fn=3);
    }
}

module guides() {
    // -- 1. Front Up-Stop Comb --
    // Positioned using upstop_y
    color("brown", 0.6) difference(){ 
    translate([-15, upstop_y, wall_thickness]) 
        cube([30, 25, 3]); // Visual placeholder for the comb bar
        key_chassis(is_white=true);
    }
    
    // -- 2. Fulcrum Comb --
    // Positioned using pivot_y
    // This represents the stationary laser-cut steel/plywood sheet
    color("brown", 0.6) 
    difference(){
        translate([-15, pivot_y - comb_thickness/2, -7]) 
        cube([30, comb_thickness, 15]);
        translate([0,0,0]) rotate([0,0,0]) key_chassis(is_white=true);
    }

    // -- 3. Rear Key-Spring Anchor --
    // Positioned at the tail
    color("brown", 0.6) 
    translate([-15, spring_anchor_y, -25]) 
        difference() {
            cube([30, 3, 20]);
            // Hole for spring hook
            translate([15, 5, 15]) rotate([90,0,0]) cylinder(r=1, h=10);
        }
    
    // Spring Visualization
    color("gray", 0.5) 
        hull() {
            translate([0, spring_anchor_y, 0]) sphere(r=1);
            translate([0, spring_anchor_y, -15]) sphere(r=1);
        }
}

module key_cap_w() {
    // (Kept largely the same, just ensured parametric fit)
    difference() {
        union() {
            translate([-cap_width/2, 0, 0])
                cube([cap_width, cap_length, 12]);
            // Saddle huggers
            translate([-u_outer_width/2 - 2, black_key_front_y, -5])
                cube([u_outer_width + 4, 30, 5]);
        }
        // Slot for U-Channel
        translate([-u_outer_width/2, black_key_front_y-1, -5.1])
            cube([u_outer_width, 32, 5.2]);
        // Hollow
        translate([-cap_width/2 + 2, 2, 2])
            cube([cap_width - 4, cap_length - 4, 15]);
        // Screw hole
        translate([0, black_key_front_y + 15, -10])
            cylinder(d=bolt_size, h=40);
    }
}

module key_cap_b() {
    // (Kept largely the same, just ensured parametric fit)
    difference() {
        //union() {
        //    translate([-cap_width/2, 0, 0])
        //        cube([cap_width, cap_length, 12]);
        //    // Saddle huggers
        //    translate([-u_outer_width/2 - 2, black_key_front_y, -5])
        //        cube([u_outer_width + 4, 30, 5]);
        //}
        translate([-cap_width/2+cap_width/4, 50, 12.5])
                cube([12, 90, 12]);
        // Slot for U-Channel
        //translate([-u_outer_width/2, black_key_front_y-1, -5.1])
        //    cube([u_outer_width, 32, 5.2]);
        // Hollow
        //translate([-cap_width/2 + 2, 2, 2])
        //    cube([cap_width - 4, cap_length - 4, 15]);
        // Screw hole
        //translate([0, black_key_front_y + 15, -10])
        //    cylinder(d=bolt_size, h=40);
    }
}

module tip_holder() {
    // Updated to be fully parametric
    holder_len = 20;
    
    //difference() {
    //    union() {
            // Insert Block
    //        translate([-inner_width/2, -holder_len/2, 0])
    //            cube([inner_width, holder_len, u_height - 2]);
            // Tip Shoe
    //        translate([0, 0, u_height - 2])
    //            cylinder(d1=8, d2=6, h=6);
    //    }
        //translate([0, 6, u_height/2]) rotate([0,90,0]) cylinder(d=bolt_size, h=20, center=true);
        //translate([0, -6, u_height/2]) rotate([0,90,0]) cylinder(d=bolt_size, h=20, center=true);
    translate([0, 0, 10])
                cylinder(d=8, h=20, center=true);
    //}
}