pl_hole_d = 5.25;
pl_hole_sep = 20;

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
	    //translate([-25,0,0]) cube(size=[50,th,th]);
	    translate([-24,0,0])
	    cube(size=[24,th+1,belt_mid_h+(cl_hole_sep/2)+3]);

	    for (y = [0,pl_hole_sep]) {
		minkowski() {
		    translate([0,5+pl_hole_sep/2,0.0001]) cube([8,6+pl_hole_sep,0.0001],center=true);
		    cylinder(r=2,h=5);
		}
	    }
	}
	for (x = [-50.8:5.08:50.8]) {
	    translate([x-1.2,-0.1,belt_mid_h-belt_w/2])
	    cube(size=[2.4,1.4,belt_w]);
	}
	for (z = [-cl_hole_sep/2,cl_hole_sep/2]) {
	    translate([-12,0,z+belt_mid_h])
	    rotate([90,0,0])
	    cylinder(d=cl_hole_d,h=20,center=true);
	}
		    

	for (y = [0,pl_hole_sep]) {
	    translate([0,y+5,3.5]) screw_hole();
	    
	}
    }
}

belt_clamp();
translate([20,0,0]) mirror() belt_clamp();