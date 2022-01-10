

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

bw = 1.6; // border width

// base plate
h0 = 3.0;
w0 = 20.5 + bw;
d0 = 13 + 2 * bw;

hd = 2; // hole diameter
hh = 15; // hole distance
hp = 4; // hole placement
sd = 3.4; // scredriwer diameter

hcd = 3.9; // hole cap diameter
hch = 1.4; // hole cap height

// right cover
h1 = 12;
l1 = 10;

con_z = 7.0;
con_h = 4;
con_y = 3.5;
con_w = 8;

but_z = 7.0;
but_h = 4.5;
but_x = 1.0;
but_w = 7.5;

led_d = 3.2;
led_d2 = 4;
led_x = 7;

buz_d = 12.5;
buz_x = 14;

// left cover
h2 = 16;
l2 = w0 - bw - l1;

// back cut
back_w = 10;
back_h = 10;

// bottom cut
bot_w = 10;
bot_d = 5;

ch = 1.5; // front chamfer

eps = 0.5;

// base plate
difference() {
    linear_extrude(h0) {
        difference() {
            translate([-w0 / 2, 0])
                square([w0, d0]);
            translate([hh / 2, hp])
                circle(d = hd);
            translate([-hh / 2, hp])
                circle(d = hd);
        }
    }
    translate([hh / 2, hp, h0 - hch])
        cylinder(d = hcd, h = hch + eps);
    translate([-hh / 2, hp, h0 - hch])
        cylinder(d = hcd, h = hch + eps);
    translate([-w0 / 2, 0, 0])
        chamfer(w0);
    translate([-w0 / 2, d0, 0])
        mirror([0, 1, 0]) chamfer(w0);
    translate([-bot_w / 2, (d0 - bot_d) / 2, -eps])
        cube([bot_w, bot_d, h0 + 2 * eps]);
}

difference() {
    union() {
        right_cover();
        left_cover();
    }
    translate([-back_w / 2, d0 - bw - eps, h0])
        cube([back_w, bw + 2 * eps, back_h]);
}

module right_cover() {
    difference() {
        union() {
            translate([w0 / 2 - bw, 0, h0 - eps])
                cube([bw, d0, h1 + 2 * eps]);
            translate([w0 / 2 - bw - l1, 0, h0 - eps])
                cube([l1, bw, h1 + 2 * eps]);
            translate([w0 / 2 - bw - l1, d0 - bw, h0 - eps])
                cube([l1, bw, h1 + 2 * eps]);
            translate([w0 / 2 - bw - l1, 0, h0 + h1])
                cube([l1 + bw, d0, bw]);
        }
        // connector hole
        translate([w0 / 2 - bw - eps, con_y + bw, con_z + h0])
             cube([bw + 2 * eps, con_w, con_h]);
        // button hole
        translate([w0 / 2 - bw - but_x - but_w, -eps, but_z + h0])
            cube([but_w, bw + 2 * eps, but_h]);
        // led hole
        translate([w0 / 2 - bw - led_x, d0 - bw - (led_d2 + led_d) / 4, h1 + h0 - eps])
            cylinder(d1 = led_d, d2 = led_d2, h = bw + 2 * eps);  
        // buzzer hole
        translate([w0 / 2 - bw - buz_x, d0 / 2, h1 + h0 - eps])
            cylinder(d = buz_d, h = bw + 2 * eps);
        // screwdriver hole
        translate([hh / 2, hp, h1 + h0 - eps])
            cylinder(d = sd, h = bw + 2 * eps);
    }
}

module left_cover() {
    difference() {
        union() {
            translate([-w0 / 2, 0, h0 - eps])
                cube([l2, bw, h2 + 2 * eps]);
            translate([-w0 / 2, d0 - bw, h0 - eps])
                cube([l2, bw, h2 + 2 * eps]);
            translate([-w0 / 2, 0, h0 + h2])
                cube([l2, d0, bw]);
        }
        // screwdriver hole
        translate([-hh / 2, hp, h2 + h0 - eps])
            cylinder(d = sd, h = bw + 2 * eps);
    }
}   

module chamfer(d) {
    translate([-eps, 0, 0])
        rotate([90, 0, 0]) rotate([0, 90, 0])
            linear_extrude(d + 2 * eps)
                polygon([[-eps, -eps], [ch + eps, -eps], [-eps, ch + eps]]);
}





