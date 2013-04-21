#include $(wildcard *.deps)

BASE_GCODE=\
	gcode/base_1_rough.nc\
	gcode/base_2_finish_pocket_side.nc\
	gcode/base_3_finish_pocket_support.nc\
	gcode/base_4_finish_pocket_floor.nc\
	gcode/base_5_cut.nc

COLLAR_GCODE=\
	gcode/collar_1_hole.nc\
	gcode/collar_2_cut.nc

DECK_GCODE=\
	gcode/deck_1_holes.nc\
	gcode/deck_2_grooves.nc\
	gcode/deck_3_cut.nc

IMAGES=\
	image/assembled.png\
	image/explode.png

PYCAM=~/src/pycam-0.5.1/pycam
OPENSCAD=openscad

all: cnc

cnc: base
# collar deck

base: ${BASE_GCODE}

gcode/base_1_rough.nc: stl/base_pocket_3d.stl gcode
	${PYCAM}\
		--export-gcode=$@\
		--tool-shape=cylindrical\
		--tool-size=3.175\
		--tool-feedrate=2000\
		--tool-spindle-speed=10000\
		--process-path-direction=x\
		--process-path-strategy=layer\
		--process-step-down=1.0\
		--process-overlap-percent=0\
		--process-material-allowance=0.5\
		--safety-height=13\
		--bounds-type=fixed-margin\
		--bounds-lower=0,0,0\
		--bounds-upper=0,0,0\
		--gcode-no-start-stop-spindle\
		$<

gcode/base_2_finish_pocket_side.nc: dxf/base_pocket_outline_2d.dxf gcode
	${PYCAM}\
		--export-gcode=$@\
		--tool-shape=cylindrical\
		--tool-size=3.175\
		--tool-feedrate=1000\
		--tool-spindle-speed=10000\
		--process-path-strategy=engrave\
		--process-engrave-offset=1.5875\
		--process-step-down=1.0\
		--safety-height=13\
		--bounds-type=fixed-margin\
		--bounds-lower=0,0,-4\
		--bounds-upper=0,0,10\
		--gcode-no-start-stop-spindle\
		$<

gcode/base_3_finish_pocket_support.nc: dxf/base_pocket_supports_2d.dxf gcode
	${PYCAM}\
		--export-gcode=$@\
		--tool-shape=cylindrical\
		--tool-size=3.175\
		--tool-feedrate=1000\
		--tool-spindle-speed=10000\
		--process-path-strategy=engrave\
		--process-engrave-offset=-1.5875\
		--process-step-down=1.0\
		--safety-height=13\
		--bounds-type=fixed-margin\
		--bounds-lower=4,4,-4\
		--bounds-upper=4,4,10\
		--gcode-no-start-stop-spindle\
		$<

gcode/base_4_finish_pocket_floor.nc: stl/base_pocket_finish_3d.stl gcode
	${PYCAM}\
		--export-gcode=$@\
		--tool-shape=cylindrical\
		--tool-size=3.175\
		--tool-feedrate=1000\
		--tool-spindle-speed=10000\
		--process-path-direction=x\
		--process-path-strategy=surface\
		--process-overlap-percent=30\
		--process-material-allowance=0.0\
		--safety-height=13\
		--bounds-type=fixed-margin\
		--bounds-lower=0,0,0\
		--bounds-upper=0,0,0\
		--gcode-no-start-stop-spindle\
		$<

gcode/base_5_cut.nc: dxf/base_outline_2d.dxf gcode
	${PYCAM}\
		--export-gcode=$@\
		--tool-shape=cylindrical\
		--tool-size=3.175\
		--tool-feedrate=1000\
		--tool-spindle-speed=10000\
		--process-path-strategy=engrave\
		--process-engrave-offset=1.5875\
		--process-step-down=1.0\
		--safety-height=13\
		--bounds-type=custom\
		--bounds-lower=-99,-104,-1\
		--bounds-upper=99,104,10\
		--gcode-no-start-stop-spindle\
		--support-type=grid\
		--support-profile-height=-2\
		--support-profile-thickness=7\
		--support-grid-distance-x=35\
		--support-grid-distance-y=35\
		$<

gen_scad/%.scad: gen_scad scad/shapes.scad scad/config.scad
	echo -n 'use <../scad/shapes.scad>\n$*();' > $@

stl/%.stl: gen_scad/%.scad stl
	${OPENSCAD} -m make -o $@ -d $@.deps $<

dxf/%.dxf: gen_scad/%.scad dxf
	${OPENSCAD} -m make -o $@ $<

gen_scad:
	mkdir gen_scad

stl:
	mkdir stl

dxf:
	mkdir dxf

gcode:
	mkdir gcode

clean:
	rm -rf gen_scad stl dxf gcode
