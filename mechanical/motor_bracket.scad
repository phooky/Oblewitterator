use <nema23_stepper.scad>;
use <pillow_block.scad>;
use <pulley.scad>;

bracket_thickness = 5.5;
belt_offset = 41.43125;
pulley_rise = 1.3;

module bracket() {
    top_to_shaft = in_to_mm(11.0/16.0);
    translate([0,0,top_to_shaft])
    rotate([0,0,-90])
    linear_extrude(height=bracket_thickness,slices=1)
    import(file="pillowblock_makerslide_mount.dxf",layer="bracket",scale=1);
}

module shaft() {
    rotate([0,90,0])
    cylinder(d=in_to_mm(0.5),h=in_to_mm(48));
}


$fn=100;


//translate([0,10,0])
translate([0,belt_offset,pulley_rise])
metal_pulley();
color([0.3,0.5,0.9])
translate([0,belt_offset-16,pulley_rise])
nema23_stepper();


translate([35,0,0])
color([0.6,0.8,0.2])
shaft();

translate([100,0,0])
bracket();

translate([100,0,0])
rotate([0,0,90])
color([0.9,0.2,0.3])
pillow_block();