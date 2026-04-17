$fn = 20;

//font = "Liberation Sans";
 //translate([0,0,15]) rotate([0,0,90]) scale([0.4,0.4,10]) {
 //  text("BRILLIANT", font = "Helvetica",halign="center",valign="center");
 //}

translate([0,0,8]) fullAssym();
//color("red",alpha=0.5) rotate([15,0,0]) translate([0,0,8]) fullAssym();
//color("blue",alpha=0.5) rotate([-15,0,0]) translate([0,0,8]) fullAssym();

module positives(){
    translate([0,8,-2]) rotate([15,0,0]) cube([18,26,14],center=true);
    translate([0,-8,-2]) rotate([-15,0,0]) cube([18,26,14],center=true);
    translate([0,0,-17+2]) rotate([0,0,0]) cube([18,26,24],center=true);
}

module negatives(){
    translate([0,0,9]) cylinder(9,1.5,1.5);
    translate([0,0,8]) rotate([15,0,0]) translate([0,0,-8]) swBody();
    translate([0,0,8]) rotate([-15,0,0]) translate([0,0,-8]) swBody();
    translate([0,0,8]) rotate([0,0,0]) translate([0,0,-8]) swBody();
    translate([0,0,-20]) cube([13,18+4,1*40],center=true);
    translate([0,0,-50-12]) rotate([15,0,0]) cube([20,60,100],center=true);
    translate([0,0,-50-12]) rotate([-15,0,0]) cube([20,60,100],center=true);
     translate([0,0,15+4]) rotate([0,0,90]) scale([0.4,0.4,4]) linear_extrude(height=5){
   text("BRILLIANT", font = "Helvetica",halign="center",valign="center");
 }
}

module swBody(){
    cylinder(9,3,3);
    translate([0,0,-11/2]) rotate([0,0,0]) cube([13,13.5,1*11],center=true);
}
 
module fullAssym(){
    difference(){
    positives();
    translate([0,0,-16]) negatives();
    }
}