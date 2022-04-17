// SMO 4K TPU lens protector

print_cap = false;

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

d0 = 23.8;
dr = 3;
h0 = 6;
h1 = 2;
h_rim = 1;

d1 = d0 + 2 * dr;
echo("d1", d1);

h_cap = h_rim + 0.8;
w_cap = 1.6;
notch_w = 3;

fov = 110;

// lock pin
lock_h = 1.5; // height of lock pin
lock_w = 1.5; // lock widht
lock_vsize = 15; // lock vertical size


eps = 0.5;

d_outer = d1 + 2 * tan(fov / 2) * h1;
echo("d_outer", d_outer);

if (print_cap) {
    cap();
} else {
    protector();
    if ($preview) {
        translate([0, 0, h0 + h1 + w_cap])
            mirror([0, 0, 1])
                #cap();
    }
}

module protector() {
    difference() {
        union() {
            cylinder(d = d1, h = h0 + h1);
            translate([0, 0, h0 - h_rim])
                cylinder(d1 = d1, d2 = d_outer, h = h1);
            translate([0, 0, h0 + h1 - h_rim])
                cylinder(d = d_outer, h = h_rim);
        }
        translate([0, 0, -eps])
            cylinder(d = d0, h = h0 + h1 + 2 * eps);
        translate([0, 0, h0])
            cylinder(d1 = d0, d2 = d0 + 2 * tan(fov / 2) * (h1 + eps), h = h1 + eps);
    }
    intersection() {
        difference() {
            cylinder(d = d1 + 2 * lock_w, h = lock_h);
            translate([0, 0, -eps])
                cylinder(d = d0, h = lock_h + 2 * eps);
        }
        translate([-d1 / 2 - lock_w, -lock_vsize / 2, 0])
            cube([d1 + 2 * lock_w, lock_vsize, lock_h]);
    }
}

module cap() {
    difference() {
        cylinder(d = d_outer + 2 * w_cap, h = h_cap + w_cap);
        translate([0, 0, w_cap])
            cylinder(d = d_outer, h = h_cap + eps);
    }
    // nothces
    intersection() {
        // contour
        translate([0, 0, w_cap + h_rim])
            difference() {
                cylinder(d = d_outer, h = h_cap - h_rim);
                cylinder(d2 = d1, d1 = d_outer, h = h1);
            }
        // placement
        translate([-notch_w / 2, -d_outer / 2, 0])
            cube([notch_w, d_outer, h0 + h1]);    
    }
}