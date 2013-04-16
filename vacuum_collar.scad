include <config.scad>

module vacuum_collar() {
	difference() {
		cylinder(r=ext_width/2,h=collar_height);
		cylinder(r=collar_r,h=collar_height);
	}
}

vacuum_collar();

