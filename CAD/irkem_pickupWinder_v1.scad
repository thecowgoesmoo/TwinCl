color("gray",alpha=0.8) translate([-400,-200,-30]) cnc();
color("gray",alpha=0.8) translate([0,0,0]) turntable();
color("orange",alpha=0.8) translate([200,0,130]) spool();
color("blue",alpha=0.8) translate([-50,-190,60]) counter();
color("orange",alpha=0.8) translate([0,0,130]) bobbin();
color("brown",alpha=0.8) translate([0,0,0]) guards();
color("brown",alpha=0.8) translate([150,-100,0]) baffle();

module cnc(){
    cube([330,400,50]);
    translate([50,0,0]) cube([60,400,220]);
    translate([180,200,130]) cylinder(120,30,30);
    translate([180,200,130-50]) cylinder(120,8,8);
}

module turntable(){
    translate([0,0,100]) cylinder(20,150,150);
    cylinder(120,15,15);
    cylinder(20,70,70);
}

module spool(){
    translate([0,50,0]) rotate([90,0,0]) cylinder(100,25,25);
}

module counter(){
    cube([4*25.4,2*25.4,1.5*25.4]);
}

module bobbin(){
    rotate([0,0,45]) cube([8.5*25.4,15,20],center=true);
}

module guards(){
    translate([0,0,100+20+20]) cylinder(3,4.5*25.4,4.5*25.4);
    translate([0,0,100+20]) cylinder(3,4.5*25.4,4.5*25.4);
}

module baffle(){
    difference(){
        cube([12,200,200]);
        translate([-2,100,132]) rotate([0,90,0]) cylinder(20,10,10);
    }
}
