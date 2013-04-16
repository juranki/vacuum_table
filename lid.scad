include <config.scad>;

module lid_plate() {
	cube([plate_length, plate_width, lid_thickness], center=true);
	translate([plate_length/2,0,0])
		cube([ext_length, ext_width, lid_thickness], center=true);
	translate([plate_length/2 + ext_length/2,0,-lid_thickness/2])
		cylinder(r=ext_width/2,h=lid_thickness);
}

module lid_hole() {
	pocket_length = plate_length - wall_thickness * 2;
	pocket_width = plate_width - wall_thickness * 2;
	cube([pocket_length, pocket_width, lid_thickness], center=true);
	translate([plate_length/2 + ext_length/2,0,-lid_thickness/2])
		cylinder(r=(ext_width-wall_thickness*2)/2, h=lid_thickness);
}

module lid() {
	translate([0,0,lid_thickness/2])
	difference() {
		lid_plate();
		lid_hole();
	}
}

lid();