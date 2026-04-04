include <BOSL2/std.scad>
include <irkem_FineTunersV0.scad>

harpZ = 1.5*25.4;
harpX = 990;
harpY = 263;

kSpc = 13.75;

tnrX = 36;
tnrY = 25;
tnrZ =14;
rSpc = tnrY + 18;

oset1 = 20;
rSpc2 = 15; //20;

color("dimgray",1.0) harp();

//color("whitesmoke",1.0) translate([-200,0,0]) desktop();
color("lightblue",1.0) translate([-100,0,0]) desktop();

//translate([-10,0,0]) tunerAssembly();
//translate([-40,0,0]) pinAssembly();
translate([-50,22,-20]) fineTunerAssy();

color("khaki",0.2) keybed();

module harp(){
    difference(){
        rotate([-90,0,-15]) translate([harpX/2,harpZ/2,0]) prismoid(size1=[harpX,harpZ], size2=[0,harpZ], shift=[harpX/2,0], h=harpY);
        translate([70,-10,+2]) scale([0.9,0.9,2.0]) rotate([-90,0,-15]) translate([harpX/2,harpZ/2,0]) prismoid(size1=[harpX,harpZ], size2=[0,harpZ], shift=[harpX/2,0], h=harpY);
    }
}

module desktop(){
    translate([0,-260,-25.4-1.5*25.4]) cube([48*25.4,24*25.4,1*25.4]);
}

module keybed(){
    translate([90,-30,0]) cube([850,325,50]);
}

module tunerAssembly(){
    //base:
    for (i=[0:59]){
        rNum = i%3;
        translate([i*kSpc-(1/tan(15))*rSpc*rNum,rNum*rSpc,-harpZ]) cube([tnrX,tnrY,tnrZ]);
    }
    color("brown",0.4) translate([-300,0,-1.5*25.4+tnrZ]) cube([1150,120,0.5*25.4]);
}

module pinAssembly(){
    for (i=[0:59]){
        rNum = i%2;
        translate([i*kSpc-(1/tan(15))*rSpc2*rNum,rNum*rSpc2+oset1,-harpZ-2]) cylinder(40,2,2);
    }
    //base:
    color("brown",0.4) translate([0,0,-1.5*25.4+0]) cube([13.75*60,50,0.75*25.4]);
}