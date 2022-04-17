// SMO 4K TPU top protector

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// protector
tw = 6; // top width
sw = 6; // side width
ph = 12; // protected height
pch = 1; // chamfer for protector

// camera and its mount dimensions
ch = 40.0;
cw = 11.0;
cx = 62;  // horizontal camera size
cr = 0.5; // corner radius
mt = 2.5; // mount thickness
mw = 16;  // mount width

// bottom support
bh = 5;  // bottom height
bcx = 3; // bottom connector x-dim
bcy = 4; // bottom connector y-dim
bc_extra = 0.5; // extra height of bottom connector 

// lens front
lfw = 23;
lfh = 23;
lfr = 3; // radius
lfx = 1.5;
lfz = 11.3;

lock_d1 = 29.8; // d1 from the lens cap
lock_h = 1.5; // height of lock pin
lock_w = 1.5; // lock widht
lock_vsize = 15; // lock vertical size
lock_vstop = 1.5; // lock vertical stopper

// lens back
lbw = 26.8;
lbh = 21.8;
lbr = 0.5; // radius
lbx = 1.0;
lbz = 12;
lbd = 10; // depth back

// buttons cut
but_x = 8;
but_y_extra = 1.5; // extra on both side
but_w = 16;

// led cut
led_z = 8.2; // from top
led_h = 14;
led_w = 7;

// sd card
sd_z = 14; // from bottom
sd_h = 14;
sd_w = 6.5;

// top connector
tcw = 5;
tsd = 2; // screw diameter

eps = 0.5;

//camera();

difference() {
    side_x = sw + lfx + lfr;
    side_y = cw + 2 * mt;
    side_z = tw + (ch - bh);
    union() {
        translate([-cx / 2 - sw, 0, 0])
            chamfer_cube([cx + 2 * sw, cw + 2 * mt, ph + tw], pch);
        translate([-cx / 2 - sw, -tw + mt, 0])
            chamfer_cube([cx + 2 * sw, cw + 2 * tw, tw], pch);
        // left cover (around lens)
        translate([-cx / 2 - sw, 0, 0])
            chamfer_cube([side_x, side_y, side_z], pch);
        translate([-cx / 2 - bcx, side_y / 2 - bcy / 2, tw + ch - eps])
            cube([bcx, bcy, mt + eps + bc_extra]);
        intersection() {
            mount_cut();
            translate([-cx / 2 - sw, 0, 0])
                cube([sw, side_y, tw + ch], pch);
        }
        // right cover
        translate([cx / 2 + sw - side_x, 0, 0])
            chamfer_cube([side_x, side_y, side_z], pch);
        translate([cx / 2, side_y / 2 - bcy / 2, tw + ch - eps])
            cube([bcx, bcy, mt + eps + bc_extra]);
        intersection() {
            mount_cut();
            translate([cx / 2, 0, 0])
                cube([sw, side_y, tw + ch], pch);
        }
        // cap lock mechanism
        camera_placement() {
            translate([cx / 2 - lfw / 2 - lfx, -mt, lfz + lfh / 2])
                rotate([90, 180, 0])
                    cap_lock();
        }
    }
    camera_placement() {
        camera();
    }
}

module camera_placement() {
    translate([0, mt, tw + ch]) 
        rotate([180, 0, 180])
            children();
}

module camera() {
    translate([-mw / 2, -mt, -mt])
        rotate([90, 90, 90])
            linear_extrude(mw) {
                mount2d_outer();
            }
    translate([-cx / 2, cw, 0])
        rotate([90, 0, 0])
            linear_extrude(cw)       
                translate([cr, cr])
                    offset(cr) square([cx - 2 * cr, ch - 2 * cr]);
    translate([lfr + (cx / 2 - lfw - lfx), eps, lfr + lfz])
        rotate([90, 0, 0])
            linear_extrude(mt + 2 * eps)
                offset(lfr)
                    square([lfw - 2 * lfr, lfh - 2 * lfr]);
    translate([lbr + (cx / 2 - lbw - lbx), cw + lbd, lbr + lbz])
        rotate([90, 0, 0])
            linear_extrude(lbd + eps)
                offset(lbr)
                    square([lbw - 2 * lbr, lbh - 2 * lbr]);
    // buttons                
    translate([-cx / 2 + but_x, cw / 2, ch])
        linear_extrude(tw, scale=[1, 1 + 2 * but_y_extra / cw]) {
            translate([0, -cw / 2])
                square([but_w, cw]);
        }
    // led & wires connector       
    translate([-cx / 2, cw, ch - led_h - led_z])
        cube([led_w, mt + eps, led_h]);
    // sd card
    translate([-cx / 2 - sw, cw - sd_w, sd_z])
        cube([sw + eps, sd_w, sd_h]);
        
    // top connector    
    translate([-tcw / 2, -tcw / 2 + cw / 2, ch])
        cube([tcw, tcw, tw + eps]);
    translate([0, cw + tw + eps, ch + mt])
        rotate([90, 0, 0])
            cylinder(d = tsd, h = cw + 2 * tw + 2 * eps);
}

module mount_cut() {
    translate([-cx / 2 - sw - eps, 0, tw - mt])
        rotate([90, 90, 90])
            linear_extrude(cx + 2 * sw + 2 * eps) {
                mount2d_inner();
            }
            
}

module mount2d_outer() {
    offset(mt) mount2d_inner();
}

module mount2d_inner() {
    translate([cr - ch - mt, cr + mt])
        offset(cr) square([ch - 2*cr, cw - 2*cr]);
}

module cap_lock() {
    difference() {
        union() {
            intersection() {
                difference() {
                    cylinder(d = lock_d1 + 4 * lock_w, h = lock_h + lock_w);
                    translate([0, 0, -eps])
                        cylinder(d = lock_d1 + 2 * lock_w, h = lock_h + eps);
                }
                translate([-lock_d1 - 4 * lock_w, -lock_vsize / 2, 0])
                    cube([lock_d1 + 4 * lock_w, lock_vsize, lock_h + lock_w]);
            }
            intersection() {
                cylinder(d = lock_d1 + 4 * lock_w, h = lock_h + lock_w);
                translate([-lock_d1 - 4 * lock_w, -lock_vsize / 2 - lock_vstop, 0])
                    cube([lock_d1 + 4 * lock_w, lock_vstop, lock_h + lock_w]);
            }
        }
        translate([0, 0, -eps])
            cylinder(d = lock_d1, h = lock_h + lock_w + 2 * eps);
    }
}


module chamfer(d, ch) {
    translate([-eps, 0, 0])
        rotate([90, 0, 0]) rotate([0, 90, 0])
            linear_extrude(d + 2 * eps)
                polygon([[-eps, -eps], [ch + eps, -eps], [-eps, ch + eps]]);
}

module chamfer_cube(s, ch) {
    difference() {
        cube(s);
        chamfer_cube_bottom(s, ch);
        translate([0, s.y, s.z])
            rotate([180, 0, 0]) chamfer_cube_bottom(s, ch);
    }
}

module chamfer_cube_bottom(s, ch) {
    chamfer(s.x, ch);
    translate([s.x, s.y, 0])
        rotate([0, 0, 180]) chamfer(s.x, ch);
    translate([s.x, 0, 0])
        rotate([0, 0, 90]) chamfer(s.y, ch);
    translate([0, s.y, 0])
        rotate([0, 0, -90]) chamfer(s.y, ch);
    translate([0, 0, s.z])
        rotate([0, 90, 0]) chamfer(s.z, ch);
    translate([s.x, 0, 0])
        rotate([0, -90, 0]) chamfer(s.z, ch);
}

