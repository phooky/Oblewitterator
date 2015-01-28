
sv_hole_dz = 10.17;
sv_hole_dx= 47.26;
sv_body_x = 41;
sv_body_z = 20;
sv_mount_hole_d = 4.38;

plate_th = 5;

sv_mnt_face_to_hole = 19.37;
sv_mnt_face_to_edge = sv_mnt_face_to_hole + 5;
plate_hole_x = 60;

$fn = 60;

module sv_mount_bracket() {
    difference() {
	translate([0,-plate_th/2,-plate_th/2]) cube([55,plate_th,sv_body_z+plate_th], center=true);
	translate([0,-plate_th/2,0]) cube([sv_body_x,plate_th+0.1,sv_body_z+0.1],center=true);
	for (x = [sv_hole_dx/2,-sv_hole_dx/2]) {
	    for (z = [sv_hole_dz/2,-sv_hole_dz/2]) {
		translate([x,0,z])
		rotate([90,0,0]) cylinder(d=sv_mount_hole_d,h=20,center=true);
	    }
	}
    }
    difference() {
	translate([0,-sv_mnt_face_to_edge/2,-(sv_body_z+plate_th)/2])
	cube([plate_hole_x+10,sv_mnt_face_to_edge,plate_th],center=true);
	for (x = [plate_hole_x/2,-plate_hole_x/2]) {
	    translate([x,-sv_mnt_face_to_hole,0]) {
		cylinder(d=5,h=40,center=true);
	    }
	}
    }
}

sv_mount_bracket();
