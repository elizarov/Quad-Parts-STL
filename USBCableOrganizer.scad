

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

cd = 3.4; // cable diameter
cg = 1.4; // cable insert gap

// holder box
bw = 11;
bh = 15;
bl = 24;

// hole
hd = 9.5;
hh = 2.5;
hs = 5; // slot width at the bottom

eps = 0.5;

difference() {
    cube([bw, bl, bh]);
    translate([bw / 2, bl, bh - cg])
        rotate([90, 0, 0])
            translate([0, 0, -eps])
                cylinder(d = cd, h = bl + 2 * eps);
    translate([0, bl / 4, (bh - cd) / 2])
        hole(8.2, 2.4, 7.0); // usb-c
    translate([0, 3*bl / 4, (bh - cd) / 2])
        hole(6.8, 2.0, 5.2); // mini usb
}


module hole(rw, rh, rl) {
    rotate([0, 90, 0]) {
        translate([0, 0, -eps])
            cylinder(d = hd, h = hh + eps);
        translate([-rw / 2, -rh / 2, hh - eps])
            cube([rw, rh, rl + eps]);
    }
    translate([-eps, -hs / 2, -hd])
        cube([hh + eps, hs, hd]);
}