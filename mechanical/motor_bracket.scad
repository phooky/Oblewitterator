use <nema23_stepper.scad>;
use <pulley.scad>;

bracket_thickness = 5.5;
belt_offset = 41.43125;
pulley_rise = 1.3;
overlap=0.05;

$fn=100;


module motor_bracket() {
    difference() {
	union() {
	    translate([0,0,-31]) cube(size=[100,40,7],center=true);
	    translate([0,belt_offset-16,-2.5]) cube(size=[56,12,63],center=true);
	    hull() {
	    translate([0,belt_offset-16,-18]) cube(size=[56,12,33],center=true);
	    translate([0,5,-31]) cube(size=[80,30,7],center=true);
	    }
	    //translate([0,16,0])
	    //translate([0,3.5+overlap,0]) 
	}
	translate([0,belt_offset-16,pulley_rise]) nema23_mount();
	rotate([90,0,0]) cylinder(d=25,h=80,center=true);
	translate([0,0,50]) cube(size=[25,80,100],center=true);
	for (x = [45, -45]) {
	    for (y = [10,-10]) {
		translate([0,0,-33])
		translate([x,y,0])
		cylinder(d=5,h=100,center=true);
	    }
	}
    }
}

bore_dia = 6.35;

module pulley_shaft() {
    rotate([90,0,0])
    cylinder(d=bore_dia+0.05,h=90,center=true);
}

module pulley_bracket() {
    washer = 1.5+1;
    inner_p = 14.3 + washer;
    outer_p = 7.9 + washer;
    inner_y = belt_offset - inner_p;
    outer_y = belt_offset + outer_p;
    blen = 35;
    bearing_d = 17.5 + 0.2;
    difference() {
	union() {
	    hull() {
		translate([0,0,-32]) cube(size=[blen,35,5],center=true);
		translate([0,outer_y+4,-32]) cube(size=[30,8,5],center=true);
	    }
	    hull() {
		translate([0,0,-31]) cube(size=[6,8,2],center=true);
		translate([0,belt_offset+(11.5),-25.5]) cube(size=[6,8,10],center=true);
		translate([0,belt_offset-(11.5+7.1),-24]) cube(size=[6,8,7],center=true);
	    }
	    for ( y = [outer_y+4,inner_y-4]) {
		translate([0,y,0]) {
		    hull() {
			translate([0,0,pulley_rise])
			rotate([90,0,0]) cylinder(d=bearing_d+10,h=6,center=true);
			translate([0,0,-31]) cube(size=[30,6,7],center=true);
		    }
		}
	    }
	    //translate([0,belt_offset-16,-2.5]) cube(size=[56,12,63],center=true);
	    hull() {
	    //translate([0,belt_offset-16,-18]) cube(size=[56,12,33],center=true);
	    //translate([0,5,-31]) cube(size=[80,30,7],center=true);
	    }
	    //translate([0,16,0])
	    //translate([0,3.5+overlap,0]) 
	}
	//rotate([90,0,0]) cylinder(d=25,h=80,center=true);
	//translate([0,0,50]) cube(size=[25,80,100],center=true);
	translate([0,belt_offset,pulley_rise])
	rotate([90,0,0])
	cylinder(d=bearing_d+0.15,h=90,center=true);
	for (x = [blen/2-5, -blen/2+5]) {
	    for (y = [10,-10]) {
		translate([0,0,-33])
		translate([x,y,0])
		cylinder(d=5.25,h=100,center=true);
	    }
	}
    }
}

pulley_bracket();

//motor_bracket();

//translate([0,belt_offset-16,pulley_rise]) color([0.8,0.2,0.2]) nema23_mount();

//translate([0,10,0])
translate([0,belt_offset,pulley_rise])
{
    //metal_pulley();
    //color([0.9,0.1,0.3])
    //pulley_shaft();
    //translate([0,-16,0])
    //nema23_stepper();
}

