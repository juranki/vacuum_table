include <config.scad>;

module base_body() {
	cube([plate_length, plate_width, height], center=true);
	translate([plate_length/2,0,0])
		cube([ext_length, ext_width, height], center=true);
	translate([plate_length/2 + ext_length/2,0,-height/2])
		cylinder(r=ext_width/2,h=height);
}

module base_pocket() {
	pocket_length = plate_length - wall_thickness * 2;
	pocket_width = plate_width - wall_thickness * 2;
	pocket_length_2 = ext_length - wall_thickness * 2;
	pocket_width_2 = ext_width - wall_thickness * 2;
	pocket_depth = height / 2;
	translate([0,0,pocket_depth])
		cube([pocket_length, pocket_width, height], center=true);
	translate([plate_length/2,0,pocket_depth])
		cube([ext_length, pocket_width_2, height], center=true);
	translate([plate_length/2 + ext_length/2,0,0])
		cylinder(r=(ext_width-wall_thickness*2)/2, h=10);
	
}

module base_plate() {
	translate([0,0,height/2])
	difference() {
		base_body();
		base_pocket();
	}
}

base_plate();


//vacuum_collar();
