include <config.scad>


module pcb_holder_body() {
	cube([plate_length, plate_width, height], center=true);
}

module pcb_pocket() {
	translate([0,0,height/2-pcb_pocket_depth/2])
	cube([pcb_length, pcb_width, pcb_pocket_depth], center=true);
}

module pcb_holder() {
	translate([0,0,height/2])
		difference() {
			pcb_holder_body();
			pcb_pocket();
			pcb_holes();
			pcb_grooves();
		}
	
}

module pcb_hole() {
	translate([0,0,-height/2])
		cylinder(r=1.5,h=height);
}

module pcb_groove() {
	translate([0,0,height/2-pcb_pocket_depth])
		rotate([90,0,0])
			cylinder(r=2.5, h=pcb_width-20, center=true);
}
module pcb_grooves() {
	for(x=[-4:4]) {
		translate([x*10,0,0]) pcb_groove();
	}
}

module pcb_holes() {
	for(x=[-4:4]) {
		for(y=[-6:6]) 
			translate([x*10,y*10,0]) pcb_hole();
	}
}

pcb_holder();
	