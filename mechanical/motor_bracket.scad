use <nema23_stepper.scad>;
use <pillow_block.scad>;
use <pulley.scad>;

module shaft() {
    rotate([0,90,0])
    cylinder(d=in_to_mm(0.5),h=in_to_mm(48));
}

$fn=100;
translate([0,10,0])
metal_pulley();

color([0.3,0.5,0.9])
nema23_stepper();


translate([0,16,0])
color([0.6,0.8,0.2])
shaft();

translate([100,16,0])
rotate([0,0,90])
color([0.9,0.2,0.3])
pillow_block();