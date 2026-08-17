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
    color("black",alpha=0.6) positives();
    negatives();
}
 
module positives(){
//translate([0,0,0]) cube([tile_x+outerLip,tile_y+outerLip,10]);
    translate([-3,0,0]) cube([19,28,10]);
    translate([4,-3,0]) cube([5,34,10]);
}
  
module negatives(){
    //tile_x = 10;
    //tile_y = 26;
    //tile_z = 4;
    //Full switch body:
    translate([(tile_x+outerLip)/2-swb_x/2-wiggle/2-0.25,12.5-2-2,0-wiggle/2]) cube([swb_x+wiggle,swb_y+wiggle+travel+2,swb_z+wiggle]);
    //Toggle handle:
    translate([(tile_x+outerLip)/2-wiggle/2-tip_x/2-0.25,(tile_y+outerLip)/2-0-wiggle/2-travel/2+3.5-1-2,swb_z-wiggle/2]) cube([tip_x+wiggle,tip_y+wiggle,tip_z]);
    //Tile inset:
    translate([outerLip/2,outerLip/2-1,10-2]) cube([tile_x,tile_y,tile_z]);
}