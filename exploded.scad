include <config.scad>;
use <base_plate.scad>;
use <lid.scad>;
use <pcb_holder.scad>;
use <vacuum_collar.scad>;

e=50;

color("DarkSlateGray")
base_plate();

color("SaddleBrown")
translate([0,0,e])
lid();

color("grey")
translate([0,0,2*e])
pcb_holder();

color("DodgerBlue")
translate([plate_length/2 + ext_length/2,0,2*e])
vacuum_collar();
