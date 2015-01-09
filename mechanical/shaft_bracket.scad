use <nema23_stepper.scad>;
use <pillow_block.scad>;
use <pulley.scad>;
use <motor_bracket.scad>;

$fn=100;

bracket_length = 20;
bracket_outer_dia = 20;
slot_width = 1.4;
clamp_width = 8;
floor=34.5;
kerf=0.2;

module shaft() {
    rotate([0,90,0])
    cylinder(d=in_to_mm(0.5),h=in_to_mm(48));
}

module shaft_mount() {
    rotate([0,90,0])
    cylinder(d=in_to_mm(0.5)+kerf,h=in_to_mm(48),center=true);
}

// on z axis
module screw_hole() {
    d_screw_head = 9;
    d_screw_bore = 5.4;
    cylinder(h=100,d=d_screw_bore,$fn=20,center=true);
    translate([0,0,10]) cylinder(h=20,d=d_screw_head,center=true);
}

module plate() {
    plate_th = 6;
    plate_w = 40;
    plate_d = 20;
    translate([0,0,-floor + plate_th/2]) cube(size=[plate_d,plate_w,plate_th],center=true);
}
    
module shaft_bracket() {
    difference() {
	union () {
	    rotate([0,90,0]) cylinder(d=bracket_outer_dia,h=bracket_length,center=true);
	    translate([0,0,10]) cube(size=[bracket_length,clamp_width,15],center=true);
	    // pillar
	    translate([0,0,-floor/2]) cube(size=[bracket_length,10.5,floor],center=true);
	    plate();
	}
	translate([0,0,50]) cube(size=[50,slot_width,100],center=true);
	for (x = [5,-5]) translate([x,0,14]) rotate([90,0,0]) cylinder(d=3,h=50,center=true);
	for (y = [10,-10]) translate([0,y,-floor + 4]) screw_hole();
	shaft_mount();
    }
}

shaft_bracket();