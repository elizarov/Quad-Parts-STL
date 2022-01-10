

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// base plate
h0 = 3;
w0 = 5;
d1 = 25;
d2 = 20;
l0 = 28.3;
s12 = (d1 - d2) / 2;
dh = 2;

br = 2; // bevel radius (on inner corners)

// support bar
gl = 20;
gs = 1.5;

// GPS mount
gmw = 26;
gmh = 8;
gml = 22; // real lenght = 25

bw = 2; // side border width

gcl = 5; // top cover length
gcw = 1.5; // top plate width

eps = 0.5;

translate([-gmw / 2 - bw, gs, h0]) {
    difference() {
        cube([gmw + 2 * bw, gml + bw, gmh]);        
        translate([bw, bw, -eps]) cube([gmw, gml + eps, gmh + 2 * eps]);
    }
    translate([0, 0, gmh])
        cube([gmw + 2 * bw, gcl + bw, gcw]);
    translate([0, gml - gcl, gmh])
        cube([gmw + 2 * bw, gcl + bw, gcw]);
}


linear_extrude(h0) {
    difference() {
        union() {
            hull() {
                translate([d1 / 2, 0]) circle(d = w0);
                translate([d2 / 2 + s12, l0 - s12]) circle(d = w0);
            }
            hull() {
                translate([d2 / 2 + s12, l0 - s12]) circle(d = w0);
                translate([d2 / 2, l0]) circle(d = w0);
            }

            hull() {
                translate([-d1 / 2, 0]) circle(d = w0);
                translate([-d2 / 2 - s12, l0 - s12]) circle(d = w0);
            }
            hull() {
                translate([-d2 / 2 - s12, l0 - s12]) circle(d = w0);
                translate([-d2 / 2, l0]) circle(d = w0);
            }
            translate([-d1 / 2, gs])
                square([d1, gl]);
            translate([-d1 / 2 + w0 / 2, gs - br])
                difference() {
                    translate([-eps, 0]) square([br + eps, br + eps]);
                    translate([br, 0]) circle(r = br);
                }
            translate([d1 / 2 - w0 / 2 - br, gs - br])
                difference() {
                    translate([0, 0]) square([br + eps, br + eps]);
                    circle(r = br);
                }
            translate([-d1 / 2 + w0 / 2, gs + gl])
                difference() {
                    translate([-eps, -eps]) square([br + eps, br + eps]);
                    translate([br, br]) circle(r = br);
                }
            translate([d1 / 2 - w0 / 2 - br, gs + gl])
                difference() {
                    translate([0, -eps]) square([br + eps, br + eps]);
                    translate([0, br]) circle(r = br);
                }
        }
        translate([d1 / 2, 0]) circle(d = dh);
        translate([d2 / 2, l0]) circle(d = dh);
        translate([-d1 / 2, 0]) circle(d = dh);
        translate([-d2 / 2, l0]) circle(d = dh);
    }
} 

