include <BOSL2/std.scad>
//include <irkem_FineTunersV0.scad>

harpZ = 1.5*25.4;
harpX = 1370;//990;
harpY = 375;//263;

kSpc = 13.75;
nStr = 60;

tnrX = 36;
tnrY = 25;
tnrZ =14;
rSpc = tnrY + 18; 
 
oset1 = 20;
rSpc2 = 15; //20;

skew = 15;

color("dimgray",1.0) harp();

//color("whitesmoke",1.0) translate([-200,0,0]) desktop();
//color("lightblue",1.0) translate([-100,-50,0]) desktop();

//translate([-10,0,0]) tunerAssembly();
//translate([-40,0,0]) pinAssembly();
//translate([-50,22,-20]) fineTunerAssy();

translate([-10,0,0]) strings();

translate([-46-10,0,0]) tuners();

fretsAndDamps();

pickups();

color("blue",0.3) translate([-100,-50,38-12.5]) desktop();

color("khaki",0.2) keybed();

controls();

cage();

module cage(){
    color("black",0.5) translate([-100,0,0]) cube([48*25.4,200,100]);
}

module fretsAndDamps(){
    color("green",0.8) translate([65,-1.0*25.4,-0.25*25.4]) cube([32*25.4,1*25.4,0.5*25.4]);
    color("brown",0.8) translate([65,-1.5*25.4,-1.25*25.4]) cube([36*25.4,1.5*25.4,1.0*25.4]);
    for (i = [1:1:(nStr)]) {
        color("silver",1.0) translate([i*kSpc+127,-23.5,-25.4/4]) rotate([90,0,-skew]) cylinder(15,0.75,0.75);
    }
}

module controls(){
    color("green",1) translate([975,20,0]) cube([120,100,3]);
    color("dimgray",1.0) translate([965,50,3]) cube([140,60,10]);
    color("ivory",1.0) translate([965+10,60,3]) cube([18,42,13]);
    color("ivory",1.0) translate([965+30,60,3]) cube([18,42,13]);
    color("ivory",1.0) translate([965+50,60,3]) cube([18,42,13]);
    color("ivory",1.0) translate([965+70,60,3]) cube([18,42,13]);
    color("ivory",1.0) translate([965+90,60,3]) cube([18,42,13]);
    color("ivory",1.0) translate([965+110,60,3]) cube([18,42,13]);
    color("ivory",1.0) translate([965+70,20+16,0]) cylinder(10,12.7,12.7);
}

module harp(){
    //difference(){
    //    rotate([-90,0,-15]) translate([harpX/2,harpZ/2,0]) prismoid(size1=[harpX,harpZ], size2=[0,harpZ], shift=[harpX/2,0], h=harpY);
    //    translate([70,-10,+2]) scale([0.9,0.9,2.0]) rotate([-90,0,-15]) translate([harpX/2,harpZ/2,0]) prismoid(size1=[harpX,harpZ], size2=[0,harpZ], shift=[harpX/2,0], h=harpY);
    //}
    //translate([-200,0,-44+3]) cube([harpX+240,44,3]);
    translate([-200,0,-44+3]) cube([harpX,44,3]);
    //translate([0,-25,0]) rotate([0,0,-skew]) translate([-100-120,-44,-44+3]) cube([harpX+240,44,3]);
    translate([0,-25,0]) rotate([0,0,-skew]) translate([-100-120-25+20+15,-44+30,-44+3]) cube([harpX-40,44,3]);
    //translate([1020,50-50,-44+3]) rotate([0,0,-90-skew]) translate([0,0,0]) cube([harpY+0+120-47-48,44,3]);
    translate([1020+70+40,50-50+20+5+20,-44+3]) rotate([0,0,-90-skew]) translate([0,0,0]) cube([harpY,44,3]);
}

module desktop(){
    translate([0,-260,-25.4-1.5*25.4]) cube([48*25.4,24*25.4,1*25.4]);
}

module keybed(){
    //translate([90,-30-300+300,0]) cube([850,325,50]);
    //Redesign key chassis to have 50mm vs 100mm on far side of fulcrum
    //Double up the elastics to achieve prior key feel
    //Redesign tray to fit key set tighter
    translate([90,-30-300+300,0]) cube([850,220,50]);
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

module strings(){
    for (i = [1:1:(nStr)]) {
        translate([i*kSpc,0,0]) rotate([0,90,-skew]) cylinder(110+980-i*kSpc*cos(skew),1,1);
        //translate([i*kSpc,0,0]) rotate([0,90,-skew+180]) cylinder(980-i*kSpc*cos(skew),1,1);
    }
}

module tuners(){
        for (i = [1:1:(nStr)]) {
            rOset = i%2; 
            //if ((i==1)||(i==3)||(i==5)||(i==7)||(i==9||(i==11))){
            //    translate([i*kSpc+(1045-i*kSpc)*cos(skew),8.5-14.5+rOset*17-(1045-i*kSpc)*sin(skew),-41]) cylinder(27,3,3);
            //}
            translate([i*kSpc-rOset*35,8.5+rOset*17,-41]) cylinder(27,3,3);
            translate([i*kSpc-rOset*35,8.5+rOset*17+rOset*52-26,-41]) scale([1,0.7,1])cylinder(6,11,11);
        //translate([i*kSpc,8.5+rOset*17,0]) cylinder(30,3,3);
    }
    
}

module pickups(){
    translate([1050,-75,-35+5]) rotate([0,0,-(90+skew)]) cube([187,20,30]);
    translate([1010,-75,-35+5]) rotate([0,0,-(90+skew+30)]) cube([187,20,30]);
}
