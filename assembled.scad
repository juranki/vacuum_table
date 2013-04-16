include <config.scad>;
use <base_plate.scad>;
use <lid.scad>;
use <pcb_holder.scad>;
use <vacuum_collar.scad>;

color("DarkSlateGray")
base_plate();

color("SaddleBrown")
translate([0,0,height])
lid();

color("grey")
translate([0,0,height + lid_thickness])
pcb_holder();

color("DodgerBlue")
translate([0,0,height + lid_thickness])
vacuum_collar();
