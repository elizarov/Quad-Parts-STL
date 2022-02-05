// Fixed camera angle support for iFlight Protek 35

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// plate
h0 = 8;
w0 = 34;
l0 = 24;

// front cuts
f0 = 2;
fw = 27;
fd = 5.5;

// camera placement
cp_y = 8;
cp_z = 10;
cp_a = 25; // ANGLE

// camera dims
cw = 21;
ch = 21;
cl = 13;
cr = 2;

// mounting hole on camera
cm_y = 4.5;
cm_z = 7.0;

// camera back cutout
cb_w = 10;
cb_h = 2; // remaining height

// duct radius cutout
duct_x = 58;
duct_r = 48;
duct_y = 37;

difference() {
    linear_extrude(h0) {
        difference() {
            translate([-w0 / 2, 0]) square([w0, l0]);
            translate([duct_x, duct_y]) circle(r = duct_r);
            translate([-duct_x, duct_y]) circle(r = duct_r);
            translate([fw / 2, 0]) circle(d = fd);
            translate([-fw / 2, 0]) circle(d = fd);
            translate([fw / 2, 0]) square([w0, f0]);
            translate([-fw / 2 - w0, 0]) square([w0, f0]);
        }
    }
    #translate([0, cp_y, cp_z])
        rotate([-cp_a, 0, 0])
            camera();
    #translate([-cb_w / 2, cl, cb_h])
        cube([cb_w, l0, h0]);
}

module camera() {
    translate([0, cl - cm_y, -cm_z])
        rotate([90, 0, 0])
            linear_extrude(cl) {
                translate([cr - cw / 2, cr]) offset(cr) square([cw - 2 * cr, ch - 2 * cr]);
            }
}