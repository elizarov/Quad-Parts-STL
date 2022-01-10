

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// standoff
d1 = 4;
d2 = 6;
h = 25;
d = 25;
h0 = 5; // don't fill the lowest part
w0 = 18; // width of the middle hole

// camera
cd = 14;
ca = 25; // camera rotation angle
cbo = 11.2; // camera plane offset to the back
cz = 12.4 + cbo * sin(ca);

cd2 = 18;
cd3 = 22;
cd4 = cd3 + 2;

cf = 15 - cbo / cos(ca); // front offset (was 3 at 20 degress)
crw = 1; // rim width
cri = 1; // inner rim
cva = 15; // camera view angle

crwc = 2; // cut back
crwf = 2; // cut forward

eps = 0.1;
spacing = 2;

if ($preview) {
    #translate([0, -d2, 0]) assembly();
}

translate([0, 0, d2 / 2])
    rotate([-90, 0, 0]) {
        intersection() {
            assembly();
            lowCut();
        }

        translate([0, 0, spacing])
            difference() {
                assembly();
                lowCut();
            }
    }

module lowCut() {
    translate([0, 0, cz])
        rotate([-ca, 0, 0])
            translate([-(d + d2) / 2, -h / 2, -cz - h])
                cube([d + d2, h, cz + h]);
}

module assembly() {
    difference() {
        union() {
            difference() {
                union() {
                    stands() { stand1(); }
                    translate([-d / 2, -d2 / 2, 0])
                        cube([d, d2, h]);
                }
                stands() { stand2(); }
                translate([-w0 / 2, -d2 / 2 - eps, -eps])
                    cube([w0, d2 + 2 * eps, h0 + eps]);
            }
            translateCam() camProtector();
        }
        translateCam() camCutout();
        translate([-w0 / 2, d2 / 2, 0]) 
            cube([w0, d2, 2 * h]);
    }
}

module camProtector() {
    difference() {
        union() {
            cylinder(d = cd2, h = cf + eps);
            translate([0, 0, cf - eps])
                cylinder(d1 = cd2 - 2 * eps, d2 = cd3, h = (cd3 - cd2) / 2 + eps);
            translate([0, 0, cf + (cd3 - cd2) / 2])
                cylinder(d = cd3, h = crw);
        }
    }
}

module camCutout() {
    cfh = cf + (cd3 - cd2) / 2 + crw; // full height
    translate([0, 0, cfh + 2 * cri * tan(cva) - cd3 * tan(cva)])
        cylinder(d1 = 0, d2 = cd3, h = cd3 * tan(cva));
    translate([0, 0, -h / 2]) cylinder(d = cd, h = h);
    cc = cfh - crwc;
    difference() {
        translate([0, 0, cc])
            cylinder(d = cd4, h = crwc + crwf);
        translate([0, 0, cc])
            cylinder(d = cd3, h = crwc + crwf);
    }
    translate([0, 0, cfh])
        cylinder(d = cd3, h = crwf);
}

module translateCam() {
    translate([0, 0, cz])
        rotate([90 - ca, 0, 0])
            children();
}
    
module stands() {
    translate([d / 2, 0, 0]) children();
    translate([-d / 2, 0, 0]) children();
}    

module stand1() {
    cylinder(h = h, d = d2);
}

module stand2() {
    translate([0, 0, -eps])
        cylinder(h = h + 2 * eps, d = d1);
}