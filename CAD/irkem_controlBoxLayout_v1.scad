
translate([0,0,5.5-3.0]) pcba();

color("brown",alpha=0.2) translate([-3,-3,-3]) cube([120+3+3,100+3+3,48]);
color("brown",alpha=0.2) translate([-3-15,-3,-3]) cube([120+3+3+15+15,100+3+3,3]);
color("gray",alpha=0.9) translate([-4,28,15]) cube([10,20,10]);
 
module pcba(){
    color("green") translate([0,0,28]) cube([120,100,1.5]);         //PCB
    color("blue") translate([60,16,28+1.5+5]) cube([10,11,10],center=true);//pot
    color("gray") translate([82,4,0]) cube([28,23,28]);             //transformer
    translate([22,-5,28-9]) rotate([-90,0,0]) cylinder(33,5.5,5.5); //jack
    translate([12,0,28-0-16]) cube([20,21,16]);                     //jack body
    //translate([30,61,28+1.5]) cube([66,34,18]);
    translate([30,61,28+1.5-10-1.5]) cube([66,34,10]);              //component vol
    color("red") translate([65,62,28-18]) cube([17,13,18]);         //fazel inductor
    color("black") translate([0+8,0+50-16,0]) cube([17,49,26]);
    color("gray",alpha=0.5) translate([0+7-1,0+50-2-16,0-2]) rotate([0,0,0]) cube([18+3,50+3,27+3]);             //9V battery 
    //color("black") translate([27+9,32+3,7]) cube([83-9-9,18,21]);           //dummy coil
    color("black") translate([27+9+7,32+3,7]) cube([70-9-9,18,21]);
    color("black") translate([27+9+7,32+9+3,7]) cylinder(21,9,9);           //dummy coil
    //color("black") translate([27+84-9,32+9+3,7]) cylinder(21,9,9);
    color("black") translate([27+70-9+7,32+9+3,7]) cylinder(21,9,9);    //dummy coil
    color("ivory",alpha=0.5) translate([27,32,7]) cube([84,24,20]);           //dummy coil
    color("gray") translate([104,72,28-8]) cube([5,25,8]);          //header
    
    for (i = [10 : 20 : 110]) {
        translate([i-4/2, 45, 28+1.5]) cube([4,9,6]);               //switches
        //color("gray",alpha=0.9) translate([i-12/2+4/2-4/2, 45-30/2+9/2, 28+1.5]) cube([12,30,14]);
        //color("orange",alpha=1) translate([i-12/2+4/2-4/2-3.5+4, 45-30/2+9/2-2, 28+1.5+5]) cube([11,28,7]);
        color("gray",alpha=0.4) translate([i-12/2+4/2-4/2-3.5+4+3, 45-30/2+9/2-2-2-1, 28+1.5+0]) cube([11-6,28+6,10]);
        color("gray",alpha=0.4) translate([i-12/2+4/2-4/2-3.5, 45-30/2+9/2-2, 28+1.5]) cube([12+6+1,28,10]);

    } 
    
    color("gray") translate([60,16,28+1.5]) cylinder(25,3.3,3.3);
    color("ivory") translate([60,16,48-5]) cylinder(12,10,10);
    
    translate([5,5,-2.5]) cylinder(48-6,2,2);
    translate([120-5,5,-2.5]) cylinder(48-6,2,2);
    translate([40,30,-2.5]) cylinder(48-6,2,2);
    translate([120-40,30,-2.5]) cylinder(48-6,2,2);
    translate([5,65,-2.5]) cylinder(48-6,2,2);
    translate([120-5,65,-2.5]) cylinder(48-6,2,2);
}
 
//switches @ y = 50mm
//10, 30, 50, 70, 90, 110
//travel ammount: 2 mm
//4 x 9 x 6
//17 x 49 x 26