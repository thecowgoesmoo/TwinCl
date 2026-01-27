// ==========================================
// PARAMETRIC CLAVINET KEY DESIGN (V3 - U-Channel)
// ==========================================

/* [Render Mode] */
mode = "Assembly"; // [Assembly, Chassis_DXF, Cap_STL, Tip_Holder_STL]

/* [Key Dimensions] */
chassis_length = 320;

// -- U-CHANNEL DIMENSIONS (Based on your find) --
u_outer_width = 9.525; // 3/8 inch
u_height = 12.7;       // Assuming 1/2 inch tall? (Adjust if it's shorter)
wall_thickness = 1.5;  // Approx 1/16 inch
chassis_height = u_height; 

/* [Action Geometry] */
strike_point_offset = 85;
tip_clearance = 6;
pivot_hole_inset = 100;
bolt_size = 3;

/* [Key Cap] */
cap_width = 23.5; 
cap_length = 140; 
cap_wall = 2;

// Visual Black Key Front Plane
black_key_front_y = 45; 

/* [Hidden] */
$fn = 20;

// ==========================================
// MODULES
// ==========================================

module assembly_w() {
    // White Key
    color("silver") key_chassis(is_white=true);
    translate([0, 0, chassis_height]) 
        color("ivory") key_cap_w();
    translate([0, chassis_length - strike_point_offset - cap_length, 0]) 
        rotate([180,0,0])
        color("orange") tip_holder();
}

module assembly_b() {
    // Black Key
    color("gray") key_chassis(is_white=false);
    translate([0, 0, chassis_height + 10]) 
        color("black") key_cap_b();
    translate([0, chassis_length - strike_point_offset - cap_length, 0]) 
        rotate([180,0,0])
        color("orange") tip_holder();
}

module key_chassis(is_white=true) {
    // The Aluminum U-Channel (Inverted)
    // "Open" side faces DOWN. Flat side faces UP.
    start_y = black_key_front_y; 
    
    difference() {
        // 1. The U-Channel Extrusion
        intersection() {
            // Overall Bounding Box
            translate([-u_outer_width/2, 0, 0])
                cube([u_outer_width, chassis_length, u_height]);
            
            // The Hollow U-Profile
            difference() {
                // Solid Block
                translate([-u_outer_width/2, 0, 0])
                    cube([u_outer_width, chassis_length, u_height]);
                
                // Minus the Inner Cavity (Open at Bottom Z=0 to Z=height-wall)
                translate([-u_outer_width/2 + wall_thickness, -1, -1])
                    cube([u_outer_width - (wall_thickness*2), chassis_length + 2, u_height - wall_thickness + 1]);
            }
        }

        // -- CUTOUTS --
        // 2. Front Truncation (Black Key Plane)
        translate([-u_outer_width, -10, -1])
            cube([u_outer_width*3, start_y + 10, u_height*3]);

        // 3. Pivot Holes (Through BOTH walls)
        translate([-10, chassis_length - pivot_hole_inset, u_height/2])
            rotate([0,90,0])
            cylinder(d=bolt_size, h=20);

        // 4. Tip Holder Holes
        translate([-10, chassis_length - strike_point_offset - cap_length, u_height/2]) {
             translate([0, 6, 0]) rotate([0,90,0]) cylinder(d=bolt_size, h=20);
             translate([0, -6, 0]) rotate([0,90,0]) cylinder(d=bolt_size, h=20);
        }
        
        // 5. Cap Mounting Hole (Through Top Surface)
        translate([0, start_y + 15, u_height/2]) 
            cylinder(d=bolt_size, h=20); // Vertical hole through the "roof"
    }
}

module key_cap_w() {
    // White Key Cap "Saddle"
    difference() {
        union() {
            // Playing Surface
            translate([-cap_width/2, 0, 0])
                cube([cap_width, cap_length, 12]);
            
            // The Saddle (Sits ON TOP of the U-channel)
            // Needs side walls to hug the U-channel for stability?
            // Or just sit flat? 
            // Let's make it "hug" the outside for maximum stability against twist.
            translate([-u_outer_width/2 - 2, black_key_front_y, -5])
                cube([u_outer_width + 4, 30, 5]);
        }
        
        // Slot for the U-Channel (The "Hug")
        translate([-u_outer_width/2, black_key_front_y-1, -5.1])
            cube([u_outer_width, 32, 5.2]);
            
        // Hollow / Weight Reduction
        translate([-cap_width/2 + 2, 2, 2])
            cube([cap_width - 4, cap_length - 4, 15]);
            
        // Mounting Screw Hole (Vertical)
        translate([0, black_key_front_y + 15, -10])
            cylinder(d=bolt_size, h=40);
    }
}

module key_cap_b() {
    cap_b_len = cap_length - black_key_front_y;
    difference() {
        // Shape
        translate([-cap_width/4, black_key_front_y, 0])
            cube([cap_width/2, cap_b_len, 12]); 
            
        // Saddle Logic (Hugs U-channel)
        translate([-u_outer_width/2, black_key_front_y-1, -5.1])
            cube([u_outer_width, cap_b_len+5, 5.2]);
            
        // Mounting Hole
        translate([0, black_key_front_y + 15, -10])
            cylinder(d=bolt_size, h=40);
    }
}

module tip_holder() {
    // Adapting for U-Channel: Insert INTO the channel? 
    // Or clamp around it?
    // Inserting INTO the channel is cleanest if it fits (6mm wide space?)
    // If channel is 9.5mm wide and walls are 1.5mm, inner space is ~6.5mm.
    // Perfect for a 6mm wide printed insert!
    
    inner_width = u_outer_width - (wall_thickness*2) - 0.4; // Tolerance
    holder_len = 20;
    
    difference() {
        union() {
            // The Insert Block
            translate([-inner_width/2, -holder_len/2, 0])
                cube([inner_width, holder_len, u_height - 2]); // Fits inside
            
            // The Tip Shoe (Protrudes down past the channel)
            translate([0, 0, u_height - 2])
                cylinder(d1=8, d2=6, h=6);
        }
        
        // Bolt Holes (Through the side walls)
        translate([0, 6, u_height/2]) rotate([0,90,0]) cylinder(d=bolt_size, h=20, center=true);
        translate([0, -6, u_height/2]) rotate([0,90,0]) cylinder(d=bolt_size, h=20, center=true);
    }
}