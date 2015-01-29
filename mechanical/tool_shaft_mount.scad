
shaft_d = 5;
collar_d = 24;
ss_d = 2.5; // drill size; tap is larger
ss_head_d = 4.5;
collar_th = 5;
mount_w = 13;
mount_th = 14;

$fn=86;

module collar() {
    difference() {
	union() {
	    cylinder(d = collar_d, h=collar_th+0.1);
	    translate([0,0,collar_th])
	    intersection_for( a = [0,120,-120] ) {
		rotate([0,0,a])
		translate([0,0,mount_th/2]) cube([mount_w,100,mount_th],center=true);
	    }
	}
	cylinder(d = shaft_d, h=100,center=true); // shaft
	rotate([0,0,60])
	translate([0,0,collar_th/2]) rotate([0,90,0]) cylinder(d = ss_d, h=50);
	for ( a = [0,120,-120] ) {
	    rotate([0,0,a])
	    translate([mount_w/2+ss_head_d/2,0,0]) cylinder(d = ss_d, h=100, center=true);
	}
    }
}

collar();
