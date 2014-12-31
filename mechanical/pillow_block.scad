
overlap = 0.05;

function in_to_mm(in) = in*25.4;

block_len = in_to_mm(3.5);
block_width = in_to_mm(2);
top_to_shaft = in_to_mm(11.0/16.0);
block_height = in_to_mm(1.25);
hole_dia = in_to_mm(5.0/32.0);
hole_y_dist = in_to_mm(2.5);
hole_x_dist = in_to_mm(1.0 + (11.0/16.0));
shaft_dia = in_to_mm(0.5);

// Origin at center of shaft, center of block. Block aligned along y axis.
module pillow_block() {
    difference() {
	// block
	translate([0,0,top_to_shaft-block_height/2])
	cube(size=[block_width,block_len,block_height],center=true);
	rotate([90,0,0]) cylinder(d=shaft_dia,h=block_len+overlap,center=true);
	for (x = [hole_x_dist/2, -hole_x_dist/2]) {
	    for (y = [hole_y_dist/2,-hole_y_dist/2]) {
		translate([x,y,0])
		cylinder(d=hole_dia,h=2*block_height,center=true);
	    }
	}
   }
}

pillow_block();

    