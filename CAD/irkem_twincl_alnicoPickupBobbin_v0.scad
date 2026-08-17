mag_x = 60;
mag_y = 3.1;
mag_z = 13;
nMag = 3;
bobbin_wall = 2;

difference(){
    positives();
    negatives();
}

module positives(){
    translate([-bobbin_wall,-bobbin_wall,0]) cube([nMag*mag_x+2*bobbin_wall,mag_y+2*bobbin_wall,mag_z]);
}

module negatives(){
    translate([0,0,0]) cube([nMag*mag_x,mag_y,mag_z]);
}