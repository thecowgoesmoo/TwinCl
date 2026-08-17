    wiggle = 1;
    travel = 2;
    
    swb_x = 3.7;//4.5;
    swb_y = 9.1;//10;
    swb_z = 3.5;//5;
    
    tip_x = 1.5;//2;
    tip_y = 1.5;//2;
    tip_z = 2;

    tile_x = 11.5;
    tile_y = 28; 
    tile_z = 4;
    outerLip = 2;

difference(){
    positives();
    negatives();
}

module positives(){
translate([0,0,0]) cube([tile_x+outerLip,tile_y+outerLip,15]);
}

module negatives(){
    //tile_x = 10;
    //tile_y = 26;
    //tile_z = 4;
    //Full switch body:
    translate([(tile_x+outerLip)/2-swb_x/2-wiggle/2,(tile_y+outerLip)/2-swb_y/2-wiggle/2-travel/2,0-wiggle/2]) cube([swb_x+wiggle,swb_y+wiggle+travel,swb_z+wiggle]);
    //Toggle handle:
    translate([(tile_x+outerLip)/2-wiggle/2-tip_x/2,(tile_y+outerLip)/2-0-wiggle/2-travel/2,swb_z-wiggle/2]) cube([tip_x+wiggle,tip_y+wiggle,tip_z]);
    //Tile inset:
    translate([outerLip/2,outerLip/2,15-2]) cube([tile_x,tile_y,tile_z]);
}