// SMO 4K TPU camera mount for iFlight Protek 35

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// mounting holes placement
dh = 2.3; // hole diameter
br = 4; // border radius from hole center
l1 = 24;
w1 = 14;
fa = 30;
sd = 5.0; // scredriwer diameter

// duct radius cutout
duct_x = 58;
duct_r = 48;
duct_y = br + l1 - 3;

// base plate
h0 = 2.5;
w0 = 26;
l0 = l1 + 2 * br;

// camera mount base dimensions
gl = 16; // length
gs = 8; // offset from the front

ch = 40.0;
cw = 11.0;
cx = 62; // horizontal camera size
cr = 0.5;   // corner radius
mt = 2.5; // mount thickness
mw = 16;  // mount width

// bottom support
sw = 6;  // side width
bh = 5;  // bottom height
pch = 1; // chamfer for protector
bcx = 3; // bottom connector x-dim
bcy = 4; // bottom connector y-dim

// top connector
tw = 6; // top width
tcw = 5;
tsd = 2; // top screw diameter


ma = 25; // mount angle (from vertical) 

// camera mount location
mx = 16;
mz = -0.8; 

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

eps = 0.5;

m_ty = mx - (cw + 2 * mt) * cos(ma);
m_tz = (cw + 2 * mt) * sin(ma) + mz;

//mount();

difference() {
    union() {
        mount_placement() {
            mount();
            translate([-cx / 2 - sw, 0, 0])
                chamfer_cube([cx + 2 * sw, cw + 2 * mt, mt + bh], pch);
        }
        base_plate(); 
    }
    // cut from base support
    mount_placement() {
        #mount_cut();
    }
    translate([-cx / 2 - sw - eps, 0, -bh])
        cube([cx + 2 * sw + 2 * eps, l0, bh]);
    // baseplate holes
    translate([0, br, -eps]) cylinder(d = dh, h = h0 + 2 * eps);
    translate([w1 / 2, br + l1, -eps]) cylinder(d = dh, h = h0 + 2 * eps);
    translate([-w1 / 2, br + l1, -eps]) cylinder(d = dh, h = h0 + 2 * eps);
    // screwdriver 
    translate([0, br, h0]) cylinder(d = sd, h = ch);
}

module mount_placement() {
    translate([0, m_ty, m_tz])
        rotate([-ma, 0, 0])
            children();
}
          
            
module mount2d() {
    difference() {
        hull() {
            mount2d_outer();
            mount2d_base();
        }
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

module mount2d_base() {
    rotate([0, 0, ma])
        translate([m_tz, -m_ty])
            translate([-h0, gs])
                square([h0, gl]);
}

module mount_cut() {
    translate([-cx / 2 - sw - eps, 0, 0])
        rotate([90, 90, 90])
            linear_extrude(cx + 2 * sw + 2 * eps) {
                mount2d_inner();
            }
            
    translate([-cx / 2 - bcx, mt + cw / 2 - bcy / 2, -eps])
        cube([bcx, bcy, mt + eps]);
    translate([cx / 2, mt + cw / 2 - bcy / 2, -eps])
        cube([bcx, bcy, mt + eps]);
}
 
module mount() {
    difference() {
        union() {
            translate([-mw / 2, 0, 0])
                rotate([90, 90, 90])
                    linear_extrude(mw) {
                        mount2d();
                    }
            // top connector
            translate([-tcw / 2, -tcw / 2 + cw / 2 + mt, ch + mt])
                cube([tcw, tcw, tw + eps]);
        }
        // top connector screw
        translate([0, cw + tw + eps, ch + 2 * mt])
            rotate([90, 0, 0])
                cylinder(d = tsd, h = cw + 2 * tw + 2 * eps);
        // lens holes
        #translate([lfr + (cx / 2 - lfw - lfx), mt + eps, lfr + mt + lfz])
            rotate([90, 0, 0])
                linear_extrude(mt + 2 * eps)
                    offset(lfr)
                        square([lfw - 2 * lfr, lfh - 2 * lfr]);
        #translate([lbr + (cx / 2 - lbw - lbx), cw + lbd + 2 * mt, lbr + mt + lbz])
            rotate([90, 0, 0])
                linear_extrude(mt + lbd + eps)
                    offset(lbr)
                        square([lbw - 2 * lbr, lbh - 2 * lbr]);
    }
    // cap lock mechanism
    translate([cx / 2 - lfw / 2 - lfx, 0, mt + lfz + lfh / 2])
        rotate([90, 0, 0])
            cap_lock();
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

module base_plate() {   
    linear_extrude(h0) {
        difference() {
            hull() {
                translate([0, br]) circle(r = br);
                translate([w1 / 2, br + l1]) circle(r = br);
                translate([-w1 / 2, br + l1]) circle(r = br);
                translate([w0 / 2, br + w0 / 2 * tan(fa)]) circle(r = br);
                translate([-w0 / 2, br + w0 / 2 * tan(fa)]) circle(r = br);
            }
            translate([duct_x, duct_y]) circle(r = duct_r);
            translate([-duct_x, duct_y]) circle(r = duct_r);
        }
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

