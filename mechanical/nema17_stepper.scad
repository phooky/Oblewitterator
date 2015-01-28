
// Motor measurements:
// * exterior dimensions (all +/- 1mm?)
// ** 56.4 mm tall
// ** 56.4 mm wide
// ** 41 mm deep
// * extruded disc on shaft side: 1.6mm deep, 38.1+/-0.03 diameter
// * shaft:
// ** 6.35mm diameter
// ** 20.6mm long
// * holes:
// ** 5mm diameter
// ** 47.1mm apart

// aligned with center of face at origin, shaft pointing
// in the +Y direction

overlap = 0.05;
kerf = 0.03;

$fa = 6;
$fn=100;
body = [42.5,36,42.5];
disc_dia = 22.4;
disc_depth = 2;
shaft_dia = 5;
shaft_len = 20.6;
hole_dia = 3.2;
hole_distance = 31;

module nema17_stepper() {
    i = hole_distance / sqrt(2);
    difference() {
	union() {
	    // body block
	    translate([0,-body[1]/2,0]) cube(size=body,center=true);
	    // extruded disc
	    translate([0,-overlap,0]) rotate([-90,0,0])
	    cylinder(d=disc_dia,h=disc_depth+overlap);
	    // shaft
	    translate([0,-overlap,0]) rotate([-90,0,0])
	    cylinder(d=shaft_dia,h=shaft_len+overlap);
	}
	// subtract mounting holes
	for (a = [45,135,225,315]) {
	    rotate([0,a,0])
	    translate([i,overlap/2,0]) rotate([90,0,0]) cylinder(d=hole_dia,h=body[1]+overlap);
	}
    }
}

face_th = 4;

pl_hole_d = 5.25;
pl_hole_sep = 60;

module screw_hole() {
    d_screw_head = 9.8;
    d_screw_bore = pl_hole_d;
    cylinder(h=50,d=5,center=true);
    translate([0,0,20]) cylinder(h=40,d=d_screw_head,center=true);
}

module nema17_mount() {
    i = hole_distance / sqrt(2);
    hole_len = 20;
    union() {
	// face
	difference() {
	    translate([0,face_th/2,0])
	    cube(size=[body[0]+1,face_th,body[2]+1],center=true);
	    // extruded disc
	    translate([0,-50,0]) rotate([-90,0,0])
	    cylinder(d=disc_dia,h=100);
	    // add mounting shafts
	    for (a = [45,135,225,315]) {
		rotate([0,a,0])
		translate([i,overlap/2+hole_len,0])
		rotate([90,0,0])
		cylinder(d=hole_dia+kerf,h=body[1]+hole_len);
	    }
	}
	for (x = [(body[0]/2)+face_th/2+0.4,-(body[0]/2)-face_th/2-0.4]) {
	    translate([x-face_th/2,0,-(body[2]+2)/2]) hull() {
		cube([face_th,face_th,15]);
		translate([0,-15+face_th,0]) cube([face_th,15,face_th]);
	    }
	}
	// bottom
	difference() {
	    translate([0,-10+face_th,-(body[2]+1+face_th)/2]) cube(size=[70,20,face_th],center=true);
	    for (x = [30,-30]) {
		translate([x,-12.7+face_th,(-(body[2]+1+face_th)/2)+1]) screw_hole();
	    }
	}
	

    }    
}

// Render

//translate([0,- 0.5,0]) nema17_stepper();
color([0.85,0.3,0.3]) nema17_mount();
///screw_hole();