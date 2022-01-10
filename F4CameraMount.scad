

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// base plate
h0 = 3;
w0 = 5;
d1 = 25;
d2 = 20;
l0 = 29;
s12 = (d1 - d2) / 2;
dh = 2;

// gopro mount
gl = 13;
gs = 3;
gh = 16.5;
gw0 = 3;
gw1 = 5;
gss = 3.2; // spacing between stands
gd = 5;

// hex nut
hd = 8.8;
hw = 2;
eps = 0.1;



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
        }
        translate([d1 / 2, 0]) circle(d = dh);
        translate([d2 / 2, l0]) circle(d = dh);
        translate([-d1 / 2, 0]) circle(d = dh);
        translate([-d2 / 2, l0]) circle(d = dh);
    }
} 

gstand(gw0);
translate([gw0 + gss, 0, 0]) gstand(gw0);

difference() {
    translate([-0.5 * gw0 - 0.5 * gw1 - gss, 0, 0]) gstand(gw1);
    translate([-0.5 * gw0 - gw1 - gss - eps, gs + gl / 2, gh - gl / 2]) 
        rotate([0, 90, 0])
            cylinder($fn = 6, d = hd, h = hw + eps);
}

module gstand(w) {
    translate([w / 2, gl / 2 + gs, 0]) rotate([-90, 0, 90]) {
        linear_extrude(w) {
            translate([0, -gh + gl / 2]) {
                difference() {
                    union() {
                        circle(d = gl);
                        translate([-gl / 2, 0]) square([gl, gh - gl / 2]);
                    }
                    circle(d = gd);
                }
            }
        }
    }
    
}