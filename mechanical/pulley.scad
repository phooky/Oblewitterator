

// Metal pulleys:
// * bore: 0.25"/6.35mm
// * outer diameter 1.375"/34.925mm
// * pitch diameter 1.146"/29.1084mm
// * outer width 0.5625"/14.2875mm
// * extruded disc on side:
// ** outer diameter: 0.8125"/20.6375mm
// ** extrusion length: 0.21875"/5.55625
// * inner width: 0.422"/10.7188mm

overlap = 0.05;

// centered with collar facing in -Y direction and origin at
// center of belt radius
module metal_pulley() {
    $fa = 6;
    bore_dia = 6.35;
    outer_dia = 34.925;
    pitch_dia = 29.1084;
    outer_w = 14.2875;
    inner_w = 10.7188;
    collar_dia = 20.6375;
    collar_w = 5.55625;
    total_w = collar_w + outer_w;
    translate([0,-outer_w/2,0])
    difference() {
	union() {
	    // pulley body
	    rotate([-90,0,0]) cylinder(d=outer_dia,h=outer_w);
	    // collar
	    translate([0,overlap,0]) rotate([90,0,0])
	    cylinder(d=collar_dia,h=collar_w+overlap);
	}
	// slot for belt
	difference() {
	    translate([0,(outer_w-inner_w)/2,0])
	    rotate([-90,0,0])
	    cylinder(d=outer_dia+overlap,h=inner_w);
	    translate([0,(outer_w-inner_w)/2 - overlap,0])
	    rotate([-90,0,0])
	    cylinder(d=pitch_dia+overlap,h=inner_w+overlap*2);
	    
	}
	rotate([90,0,0]) cylinder(d=bore_dia,h=2*total_w,center=true);
    }    

	
}

metal_pulley();