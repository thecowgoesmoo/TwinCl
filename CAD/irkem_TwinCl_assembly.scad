// irkem_TwinCl_assembly.scad
// Top-level assembly script for TwinCl clavinet.
// Positions all constituent subsystems in their as-assembled relationship.
//
// Coordinate convention (inherited from irkem_fullKeybed_v20.scad):
//   X: along key length (keyboard end = negative, harp end = positive)
//   Y: across keys (bass = negative, treble = positive)
//   Z: vertical (up = positive)
//   String skew angle: 15 degrees in XY plane
//
// Usage:
//   Toggle subsystem visibility with the SHOW_* variables below.
//   Set DETAIL = false to substitute bounding-box primitives for heavy geometry
//   (useful for checking clearances without full render time).

// ─── Global parameters ────────────────────────────────────────────────────────
DETAIL        = true;   // false = bounding-box stand-ins for each subsystem
SHOW_CHASSIS  = true;
SHOW_HARP     = true;
SHOW_KEYWORK  = true;
SHOW_PICKUPS  = true;
SHOW_CONTROLS = false;  // switch rockers / preamp panel (stub)
SHOW_STRINGS  = false;  // slow to render; disable for mechanical checks

// ─── Includes ─────────────────────────────────────────────────────────────────
// Uncomment each include as the corresponding module is assembly-ready.
// Sub-scripts should expose named modules (e.g. module harp(), module keys())
// rather than top-level geometry calls.

include <irkem_clavinetKey_v9_UChannel.scad>
// use <irkem_qaxinet_v2.scad>       // harp / U-channel chassis
// use <irkem_Pickup_v0.scad>        // pickup assemblies
// use <irkem_TwinCl_SwitchRocker.scad>  // control panel

// ─── Shared dimensions (keep in sync with sub-scripts) ────────────────────────
n_keys       = 60;
key_spacing  = 13.75;   // mm, center-to-center
skew         = 15;      // degrees
L0           = 48*25.4; // mm, baseline string length (lowest note)

// ─── Assembly ─────────────────────────────────────────────────────────────────

if (SHOW_CHASSIS) {
    // TODO: call chassis() module from qaxinet script once refactored
    // Temporary bounding-box stand-in:
    color("silver", 0.4)
        cube([1200, 610, 50], center=false); // approx 48" x 24" x 2" chassis
}

if (SHOW_HARP) {
    // TODO: call harp() module
    color("goldenrod", 0.6)
        translate([0, 0, 50])
        cube([1200, 610, 30], center=false);
}

if (SHOW_KEYWORK) {
    // Keys sit below the harp, offset in Y
    translate([0, -200, 0])
        keys();  // from irkem_clavinetKey_v9_UChannel.scad
}

if (SHOW_PICKUPS) {
    // TODO: call bridge_pickup() and neck_pickup() modules
    // Bridge pickup: within 1" of non-keyboard string ends
    color("darkgray", 0.8)
        translate([L0 - 25, 0, 55])
        cube([10, n_keys * key_spacing, 8]); // stand-in bar

    // Neck pickup: along 1/5-string-length diagonal from non-keyboard end
    color("dimgray", 0.8)
        translate([L0 - L0/5, 0, 55])
        cube([10, n_keys * key_spacing, 8]); // stand-in bar
}

if (SHOW_STRINGS) {
    // TODO: call strings() module
}
