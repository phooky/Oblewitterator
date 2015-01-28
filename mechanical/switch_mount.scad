switch_dim = [27.87, 15.84, 9.82];


module hex_nut() {
    f=5.6;
    t=2.6;
    intersection_for(a = [0, 60, 120])
    rotate([0,0,a])
    cube(size=[f*2,f,t],center=true);
}

module switch_holes() {
    $fn = 80;
    ds = [22.0,10.0];
    for (x = [-ds[0]/2,ds[0]/2]) {
	for (y = [-ds[1]/2,ds[1]/2]) {
	    translate([x,y,0]) {
		cylinder(r=1.6,h=20,center=true);
		hull() {
		    translate([0,0,-1]) hex_nut();
		    translate([0,0,-25]) hex_nut();
		}
	    }
	}
    }
}
module switch() {
    translate([0,0,switch_dim[2]/2])
    difference() {
	cube(size=switch_dim,center=true);
	switch_holes();
    }
}

module switch_mount() {
    $fn=80;
    pt=6.5;
    translate([0,0,-4])
    difference() {
	union() {
	    translate([0,0,pt/2 - 2.5])cube(size=[switch_dim[0]+4,switch_dim[1]+4,pt],center=true);
	    translate([0,-19,0]) cube(size=[19,34,5],center=true);
	}
	translate([0,0,2]) switch_holes();
	for (y = [-15,-30]) {
	    translate([0,y,0])
	    cylinder(r=2.6,h=20,center=true);
	}
    }
}
switch();
//switch_mount();
//translate([0,0,0]) color([0.2,0.2,0.2]) switch();