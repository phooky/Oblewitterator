pl_hole_d = 5.25;
pl_hole_sep = 40;

belt_mid_h = 12.5;
belt_w = 10;

cl_hole_d = 3.2;
cl_hole_sep = 16;
cl_sep=63;
th = 4;

$fn=50;

module screw_hole() {
    d_screw_head = 9.8;
    d_screw_bore = pl_hole_d;
    cylinder(h=50,d=d_screw_bore,center=true);
    translate([0,0,20]) cylinder(h=40,d=d_screw_head,center=true);
}

module belt_clamp() {
    difference() {
	union() {
	    translate([-25,0,0]) cube(size=[50,th,th]);
	    for (x = [-37,37]) {
		translate([-14+x,0,0])
		cube(size=[28,th+1,belt_mid_h+(cl_hole_sep/2)+3]);
	    }

	    for (x = [-pl_hole_sep/2,pl_hole_sep/2]) {
		minkowski() {
		    translate([x,5,0.0001]) cube([8,6,0.0001],center=true);
		    cylinder(r=2,h=th);
		}
	    }
	}
	for (x = [-50.8:5.08:50.8]) {
	    translate([x-1.2,-0.1,belt_mid_h-belt_w/2])
	    cube(size=[2.4,1.4,belt_w]);
	}
	for (z = [-cl_hole_sep/2,cl_hole_sep/2]) {
	    for (x = [-cl_sep/2,cl_sep/2]) {
		translate([x,0,z+belt_mid_h])
		rotate([90,0,0])
		cylinder(d=cl_hole_d,h=20,center=true);
	    }
	}
		    

	for (x = [-pl_hole_sep/2,pl_hole_sep/2]) {
	    translate([x,5,3.5]) screw_hole();
	    
	}
    }
}

belt_clamp();