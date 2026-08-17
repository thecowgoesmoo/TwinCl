import math

# --- CONFIGURATION ---
# Geometry
NUM_SLOTS = 43
X_INCREMENT = 3.5588#3.684  # mm step in X per slot
Y_INCREMENT = 13.2815#13.75  # mm step in Y per slot
SLOT_LENGTH = 20#30.0   # Total length of the X-axis cut (includes air plunge zones)

# Cutting Parameters
DEPTH_PER_PASS = 0.1
TARGET_DEPTH = 0.3#2.0
FEED_PLUNGE = 20     # mm/min
FEED_CUT = 80#160       # mm/min
SAFE_Z = 5.0
SPINDLE_RPM = 12000

def generate_gcode():
    filename = "twincl_anvil_slotsV3.nc"
    
    gcode = []
    
    # --- HEADER ---
    gcode.append("( 43 Fret Slots in White Oak for TwinCl )")
    gcode.append(f"( Slot Length: {SLOT_LENGTH}mm | Target Depth: {TARGET_DEPTH}mm )")
    gcode.append(f"( Steps: X+{X_INCREMENT}mm, Y+{Y_INCREMENT}mm per slot )")
    gcode.append("( Tool: 0.6mm 3-Flute End Mill )")
    gcode.append("")
    gcode.append("( --- Setup --- )")
    gcode.append("G21             ( Units in millimeters )")
    gcode.append("G90             ( Absolute positioning )")
    gcode.append("G94             ( Feed per minute mode )")
    gcode.append(f"M3 S{SPINDLE_RPM}       ( Spindle ON, {SPINDLE_RPM} RPM )")
    gcode.append(f"G0 Z{SAFE_Z:.1f}         ( Rapid move to Safe Z above the part )")

    for i in range(NUM_SLOTS):
        left_x = i * X_INCREMENT
        right_x = left_x + SLOT_LENGTH
        current_y = i * Y_INCREMENT
        
        gcode.append(f"\n( --- Slot {i+1} of {NUM_SLOTS} --- )")
        gcode.append(f"( Start: X={left_x:.3f}, Y={current_y:.3f} | End: X={right_x:.3f}, Y={current_y:.3f} )")
        gcode.append(f"G0 X{left_x:.3f} Y{current_y:.3f}    ( Rapid to slot {i+1} start position )")
        
        passes = int(TARGET_DEPTH / DEPTH_PER_PASS)
        for p in range(1, passes + 1):
            current_z = -1.0 * (p * DEPTH_PER_PASS)
            
            gcode.append(f"\n( Pass {p}: Depth {current_z:.3f}mm )")
            
            # Odd passes: Plunge on left, cut to right
            if p % 2 != 0:
                # Add descriptive comments for the first pass of the slot
                if p == 1:
                    gcode.append(f"G1 Z{current_z:.3f} F{FEED_PLUNGE}    ( Plunge slow in the air )")
                    gcode.append(f"G1 X{right_x:.3f} F{FEED_CUT}   ( Cut Left to Right )")
                else:
                    gcode.append(f"G1 Z{current_z:.3f} F{FEED_PLUNGE}")
                    gcode.append(f"G1 X{right_x:.3f} F{FEED_CUT}")
                    
            # Even passes: Plunge on right, cut to left
            else:
                if p == 2:
                    gcode.append(f"G1 Z{current_z:.3f} F{FEED_PLUNGE}    ( Plunge in the air on the right side )")
                    gcode.append(f"G1 X{left_x:.3f} F{FEED_CUT}    ( Cut Right to Left )")
                elif p == passes:
                    gcode.append(f"G1 Z{current_z:.3f} F{FEED_PLUNGE}")
                    gcode.append(f"G1 X{left_x:.3f} F{FEED_CUT}    ( Final cut Right to Left, tool ends up back at left side )")
                else:
                    gcode.append(f"G1 Z{current_z:.3f} F{FEED_PLUNGE}")
                    gcode.append(f"G1 X{left_x:.3f} F{FEED_CUT}")
                    
        # Retract before moving to the next slot
        gcode.append(f"G0 Z{SAFE_Z:.1f}         ( Rapid retract to Safe Z )")

    gcode.append("\n( --- Cleanup & End --- )")
    gcode.append(f"G0 Z{SAFE_Z:.1f}         ( Rapid retract to Safe Z )")
    gcode.append("G0 X0.0 Y0.0    ( Return to origin )")
    gcode.append("M5              ( Spindle OFF )")
    gcode.append("M30             ( End of Program )")
    
    # Write to file
    with open(filename, 'w') as f:
        f.write("\n".join(gcode) + "\n")
        
    print(f"Successfully generated '{filename}' with {len(gcode)} lines of G-code.")
    
    # Print the bounding box so the user can verify their stock size
    max_x = ((NUM_SLOTS - 1) * X_INCREMENT) + SLOT_LENGTH
    max_y = (NUM_SLOTS - 1) * Y_INCREMENT
    print("\n--- Stock Requirements ---")
    print(f"Total X travel: {max_x:.3f} mm")
    print(f"Total Y travel: {max_y:.3f} mm")
    print("Ensure your oak strip is securely clamped within this bounding box!")

if __name__ == "__main__":
    generate_gcode()