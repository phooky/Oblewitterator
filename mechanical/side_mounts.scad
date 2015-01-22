use <nema23_stepper.scad>;

module extrusion() {
    rotate([90,0,0])
    linear_extrude(height=100,slices=1)
    import(file="makerslide_profile.dxf",layer="clearance",scale=1);
}

$fn=60;

module screw_hole() {
    d_screw_head = 9.8;
    d_screw_bore = 5.4;
    cylinder(h=100,d=d_screw_bore,$fn=20,center=true);
    translate([0,0,10]) cylinder(h=20,d=d_screw_head,center=true);
}

module motor_bracket() {
    difference() {
	union() {
	    hull() {
		translate([0,28,12.5]) cube(size=[56,60,5],center=true);
		translate([0,-10,-4.5]) cube(size=[50,14,20],center=true);
	    }
	    translate([0,-16,-4.5]) cube(size=[50,36,20.1],center=true);
	    //translate([0,16,0])
	    //translate([0,3.5+overlap,0]) 
	}
	translate([0,30,10]) {
	    rotate([90,0,0]) nema23_mount();
	    cylinder(h=12,d=39);
	}
	//rotate([90,0,0]) cylinder(d=25,h=80,center=true);
	//translate([0,0,50]) cube(size=[25,80,100],center=true);
	for (y = [10,30]) {
	    translate([0,0,5.1])
	    translate([-10,-y,0])
	    screw_hole(); //cylinder(d=5,h=100,center=true);
	}
	for (r=[-90,90]) translate([0,-20,-10]) rotate([0,r,0]) translate([0,0,25]) screw_hole();
	extrusion();
    }
}


module pulley_bracket() {
    shaftw = 26;
    topth = 4;
    ht = shaftw+topth+10;
    bore_dia = 6.5;
    outer_dia = 38;
    pulley_y = 0;
    difference() {
    
	union() {
	    hull() {
		translate([0,25,(shaftw+10)-2])
		cube(size=[52,6,topth],center=true);
		
		translate([0,pulley_y,(shaftw+10)-2])
		cylinder(d=12,h=topth,center=true);
		//translate([0,-10,-4.5]) cube(size=[50,14,20],center=true);
	    }
	    translate([0,25,ht/2-5]) cube(size=[52,6,ht],center=true);
	    translate([0,-1, 0]) cube(size=[52,58,10],center=true);
	    //translate([0,16,0])
	    //translate([0,3.5+overlap,0]) 
	}
	translate([0,pulley_y,0])
	cylinder(d=bore_dia,h=100,center=true);
	//rotate([90,0,0]) cylinder(d=25,h=80,center=true);
	//translate([0,0,50]) cube(size=[25,80,100],center=true);
	//for (r=[-90,90]) translate([0,-20,-10]) rotate([0,r,0]) translate([0,0,25]) screw_hole();
	mirror([1,0,0]) {
	    for (y = [12,24]) {
		translate([0,0,5.1])
		translate([-10,-y,0])
		screw_hole(); //cylinder(d=5,h=100,center=true);
	    }
	    translate([0,-6,0]) extrusion();
	}
    }
}

bore_dia = 6.35;

module pulley_shaft() {
    rotate([90,0,0])
    cylinder(d=bore_dia+0.05,h=90,center=true);
}


pulley_bracket();
//translate([0,10,0])

