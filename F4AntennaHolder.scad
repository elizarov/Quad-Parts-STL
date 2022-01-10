

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// standoff
d1 = 4;
d2 = 6;
h = 20;
d = 16;
w = 4.5;

// antenna holder
d3 = 3.9;
d4 = 8;
l = 10;
b0 = 14;
a = 45;

// led cut
hl1 = 10;
wl1 = 8;
dl1 = 2;
hl2 = 8;
wl2 = 5;
hl3 = 1;

eps = 0.1;


translate([d / 2, 0, 0]) stand();
translate([-d / 2, 0, 0]) stand();


difference() {
    union() {
        translate([-d / 2 + d1 / 2, -w / 2, 0]) 
            cube([d - d1, w, h]);
        translate([0, 0, b0])
            rotate([a, 0, 0])
                translate([0, 0, -d4 * sin(a)])
                    cylinder(d = d4, h = l + d4 * sin(a));
    }
    // antenna holder cut
    translate([0, 0, b0])
        rotate([a, 0, 0])
            translate([0, 0, -d4 * sin(a) - eps])
                cylinder(d = d3, h = l + d4 * sin(a) + 2 * eps);
    
    translate([-d /2 + d1 / 2, w / 2, 0])
        cube([d - d1, d4, h]);
    // led cut
    translate([-wl1 / 2, -dl1 / 2, -eps])
        cube([wl1, dl1, hl1 + eps]);
    translate([-wl2 / 2, -d2 / 2 - eps, -eps])
        cube([wl2, d2 / 2 + eps, hl2 + eps]);
    translate([-wl1 / 2, 0, -eps])
        cube([wl1, d2 / 2 + eps, hl3 + eps]);
}

module stand() {
    difference() {
        cylinder(h = h, d = d2);
        translate([0, 0, -eps])
            cylinder(h = h + 2 * eps, d = d1);
    }   
}