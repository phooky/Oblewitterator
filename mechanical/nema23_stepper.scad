
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

module nema23_stepper() {
    $fa = 6;
    body = [56.4,41,56.4];
    disc_dia = 38.1;
    disc_depth = 1.6;
    shaft_dia = 6.35;
    shaft_len = 20.6;
    hole_dia = 5;
    hole_distance = 47.1;
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

// Render
nema23_stepper();