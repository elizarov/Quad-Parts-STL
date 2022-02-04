// M80 Pro GPS + VIFLY Finder 2 mount for iFlight Protek 35

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// base plate
h0 = 2.5;

// P35 mounting plate
w0 = 40;
l0 = 45;

// mounting holes placement
dh = 2.3; // hole diameter
w1 = 26.5;
l1 = 6;
sd = 4.0; // scredriver diameter
sdh = 15; // scredriver hold heights

// duct radius cutout
duct_x = 58;
duct_y = 41;
duct_r = 48;

// cutout for the power connector
pw = 10;
pl = 18;
py = 6;
ssh = 10; // side support height

// cutouts for strap
stw = 10;
stl = 5;
std = 4; // distance betweem them
st0 = l1 + 29; // central location for coutouts

// GPS mount
gmw = 26;
gmh = 8;
gml = 22; // real lenght = 25

bw = 1.6; // side border width

gcl = 5; // top cover length
gcw = 1.5; // top plate width

// GPS mount bottom
gmw0 = gmw + 2 * bw;
gml0 = gml + bw;

// GPS mount location
gmloc_a = 30; // angle
gmloc_z = 20;

// GPS mount support
gmsl = 20;
gmsw = 2;

// Beeper mount
bmw0 = 20.5 + bw;
bmd0 = 13 + 2 * bw;
bmh2 = 16;

eps = 0.5;

linear_extrude(h0) {
    difference() {
        translate([-w0 / 2, 0]) square([w0, l0]);
        translate([-w1 / 2, l1]) circle(d = dh);
        translate([ w1 / 2, l1]) circle(d = dh);
        translate([ duct_x, duct_y]) circle(r = duct_r);
        translate([-duct_x, duct_y]) circle(r = duct_r);
        translate([-pw / 2, py]) square([pw, pl]);
        translate([-stw / 2, st0 - stl - std / 2]) square([stw, stl]);
        translate([-stw / 2, st0       + std / 2]) square([stw, stl]);
    }
}

difference() {
    union() {
        translate([0, 0, gmloc_z])
            rotate([-gmloc_a, 0, 180]) 
                translate([0, -gml0, 0])
                    gps_case();
        translate([-gmw0 / 2, 0, 0]) gps_support();
        translate([ gmw0 / 2 - gmsw, 0, 0]) gps_support();
    }
    translate([-gmw0 / 2 - eps, l1 - sd / 2, h0]) cube([gmw0 + 2 * eps, sd, sdh]);
}

translate([bmd0 / 2, l0 - bmw0 / 2, 0])
    rotate([0, 0, 90])
        beeper_mount();

inner_side_structure();
mirror([1, 0, 0]) inner_side_structure();

module inner_side_structure() {
    // connector to beeper mount
    translate([0, 0, h0]) bg_connector(bmh2 + bw);
    // side support
    x0 = (bmd0 - 2 * bw) / 2;
    y0 = l1 + sd / 2;
    h = h0 + ssh;
    x1 = gmw / 2;
    hull() {
        translate([x0, y0, 0])
            cube([bw, pl + py - y0, h]);
        translate([x0, y0, 0])
            cube([x1 - x0, bw, h]);
        bg_connector(h);
    }
}

module bg_connector(h) {
    linear_extrude(h) {
        hull() {
            translate([bmd0 / 2 - bw / 2, l0 - bmw0 + bw / 2])
                circle(d = bw);
            translate([gmw0 / 2 - bw / 2, gmsl - bw / 2])
                circle(d = bw);
        }
    }
}

module gps_support() {
    rotate([90, 0, 90])
        linear_extrude(gmsw) {
            polygon([
                [gmsl, h0],
                [0, h0], 
                [0, gmloc_z],
                [gml0 * cos(gmloc_a), gmloc_z + gml0 * sin(gmloc_a)]
            ]);
        }
}

module gps_case() {
    translate([-gmw / 2 - bw, 0, 0]) {
        difference() {
            cube([gmw + 2 * bw, gml + bw, gmh + gcw]);        
            translate([bw, bw, -eps]) cube([gmw, gml + eps, gmh + gcw + 2 * eps]);
        }
        translate([0, 0, gmh + gcw]) gps_case_top();
    }
    translate([-gmw / 2 - bw, 0, 0]) gps_case_top();
}

module gps_case_top(w) {
    translate([0, 0, 0])
        cube([gmw + 2 * bw, gcl + bw, gcw]);
    translate([0, gml - gcl, 0])
        cube([gmw + 2 * bw, gcl + bw, gcw]);
}

module beeper_mount() {
    // right cover
    h1 = 12;
    l1 = 10;

    con_z = 7.0;
    con_h = 4;
    con_y = 3.5;
    con_w = 8;

    but_z = 6.5;
    but_h = 5.0;
    but_x = 0.0;
    but_w = 9.5;

    led_d = 3.2;
    led_d2 = 4;
    led_x = 7;

    buz_d = 12.5;
    buz_x = 14;

    // left cover
    h2 = bmh2;
    l2 = bmw0 - bw - l1;

    // back cut
    back_w = 10;
    back_h = 10;

    difference() {
        union() {
            right_cover();
            left_cover();
        }
        translate([-back_w / 2, bmd0 - bw - eps, h0])
            cube([back_w, bw + 2 * eps, back_h]);
    }

    module right_cover() {
        difference() {
            union() {
                translate([bmw0 / 2 - bw, 0, h0 - eps])
                    cube([bw, bmd0, h1 + 2 * eps]);
                translate([bmw0 / 2 - bw - l1, 0, h0 - eps])
                    cube([l1, bw, h1 + 2 * eps]);
                translate([bmw0 / 2 - bw - l1, bmd0 - bw, h0 - eps])
                    cube([l1, bw, h1 + 2 * eps]);
                translate([bmw0 / 2 - bw - l1, 0, h0 + h1])
                    cube([l1 + bw, bmd0, bw]);
            }
            // connector hole
            translate([bmw0 / 2 - bw - eps, con_y + bw, con_z + h0])
                 cube([bw + 2 * eps, con_w, con_h]);
            // button hole
            translate([bmw0 / 2 - bw - but_x - but_w, -eps, but_z + h0])
                cube([but_w, bw + 2 * eps, but_h]);
            // led hole
            translate([bmw0 / 2 - bw - led_x, bmd0 - bw - (led_d2 + led_d) / 4, h1 + h0 - eps])
                cylinder(d1 = led_d, d2 = led_d2, h = bw + 2 * eps);  
            // buzzer hole
            translate([bmw0 / 2 - bw - buz_x, bmd0 / 2, h1 + h0 - eps])
                cylinder(d = buz_d, h = bw + 2 * eps);
        }
    }

    module left_cover() {
        difference() {
            union() {
                translate([-bmw0 / 2, 0, h0 - eps])
                    cube([l2, bw, h2 + 2 * eps]);
                translate([-bmw0 / 2, bmd0 - bw, h0 - eps])
                    cube([l2, bw, h2 + 2 * eps]);
                translate([-bmw0 / 2, 0, h0 + h2])
                    cube([l2, bmd0, bw]);
            }
        }
    }   
}