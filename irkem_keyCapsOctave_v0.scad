include <irkem_natKeycapsCF_v0.scad>
include <irkem_natKeycapsDGA_v0.scad>
include <irkem_natKeycapsEB_v0.scad>
include <irkem_sharpKeycaps_v0.scad>


translate([13.75*12,0,0]) keycapCF();
translate([13.75*11,0,0]) keycapSharp();
translate([13.75*10,0,0]) keycapDGA();
translate([13.75*9,0,0]) keycapSharp();
translate([13.75*8,0,0]) keycapEB();
translate([13.75*7,0,0]) keycapCF();
translate([13.75*6,0,0]) keycapSharp();
translate([13.75*5,0,0]) keycapDGA();
translate([13.75*4,0,0]) keycapSharp();
translate([13.75*3,0,0]) keycapDGA();
translate([13.75*2,0,0]) keycapSharp();
translate([13.75*1,0,0]) keycapEB();

translate([0,0,0]) keycapCF();
translate([-13.75*1,0,0]) keycapSharp();
translate([-13.75*2,0,0]) keycapDGA();
translate([-13.75*3,0,0]) keycapSharp();
translate([-13.75*4,0,0]) keycapEB();
translate([-13.75*5,0,0]) keycapCF();
translate([-13.75*6,0,0]) keycapSharp();
translate([-13.75*7,0,0]) keycapDGA();
translate([-13.75*8,0,0]) keycapSharp();
translate([-13.75*9,0,0]) keycapDGA();
translate([-13.75*10,0,0]) keycapSharp();
translate([-13.75*11,0,0]) keycapEB();

customGrid(200,2);
//customGridR(1000,100);
//customGridYZ(1000,10);

// Example of a custom grid structure
module customGrid(size, spacing) {
    for (i = [-size : spacing : size]) {
        color("lime") translate([i, -size, 0]) cube([1, 2*size, 1]); // Adjust as needed
        color("lime") translate([-size, i, 0]) cube([2*size, 1, 1]); // Adjust as needed
    }
}