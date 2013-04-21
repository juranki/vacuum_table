include <config.scad>


module rect(w, l) {
	x = w/2;
	y = l/2;
	polygon(points=[[x,y], [x,-y], [-x,-y], [-x,y]],
			  paths=[[0,1,2,3]]);
}

module stock_2d() {
	rect(stock_w, stock_l);
}

module base_outline_2d() {
	translate([0,-ext_length/2,0]) {
		rect(plate_width, plate_length);
		translate([0,plate_length/2,0])
			rect(ext_width, ext_length);
		translate([0,plate_length/2 + ext_length/2,0])
			circle(r=ext_width/2);
	}
}

module base_pocket_outline_2d() {
	pocket_length = plate_length - wall_thickness * 2;
	pocket_width = plate_width - wall_thickness * 2;
	pocket_length_2 = ext_length - wall_thickness * 2;
	pocket_width_2 = ext_width - wall_thickness * 2;
	pocket_depth = height / 2;
	translate([0,-ext_length/2,0]) {
		rect(pocket_width, pocket_length);
		translate([0,plate_length/2,0])
			rect(pocket_width_2,ext_length);
		translate([0,plate_length/2 + ext_length/2,0])
			circle(r=(ext_width-wall_thickness*2)/2);
	}
}

module base_pocket_supports_2d() {
	pocket_length = plate_length - wall_thickness * 2;
	pocket_width = plate_width - wall_thickness * 2;
	pocket_length_2 = ext_length - wall_thickness * 2;
	pocket_width_2 = ext_width - wall_thickness * 2;
	pocket_depth = height / 2;
	xc = floor(pocket_width/70);
	yc = floor(pocket_length/70);
	translate([0,-ext_length/2,0]) {
		for(x=[-xc : xc]) {
			for(y=[-yc : yc]) {
				translate([x*35, y*35, 0]) rect(5,5);
			}
		}
	}
}

module base_pocket_2d() {
    difference() {
	base_pocket_outline_2d();
	base_pocket_supports_2d();
    }
}

module base_pocket_3d() {
	pocket_length = plate_length - wall_thickness * 2;
	pocket_width = plate_width - wall_thickness * 2;
	pocket_length_2 = ext_length - wall_thickness * 2;
	pocket_width_2 = ext_width - wall_thickness * 2;
   translate([0,0,0]) {
        difference() {
	    linear_extrude(height=10) {
			rect(pocket_width+8, pocket_length+ext_length+8);
			
	    }
	    
	    translate([0,0,4]) {
		linear_extrude(height=6) {
		    base_pocket_2d();
		}
	    }
	}
    }
}

module base_pocket_finish_3d() {
	pocket_length = plate_length - wall_thickness * 2;
	pocket_width = plate_width - wall_thickness * 2;
	pocket_length_2 = ext_length - wall_thickness * 2;
	pocket_width_2 = ext_width - wall_thickness * 2;
   translate([0,0,0]) {
        difference() {
	    linear_extrude(height=13) {
			rect(pocket_width+8, pocket_length+ext_length+8);
			
	    }
	    
	    translate([0,0,4]) {
		linear_extrude(height=10) {
		    base_pocket_2d();
		}
	    }
	}
    }
}
//stock_2d();
//base_pocket_finish_3d();
//base_pocket_supports_2d();
base_outline_2d();
//base_pocket_outline_2d();