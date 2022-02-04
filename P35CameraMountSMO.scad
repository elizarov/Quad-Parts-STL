// SMO 4K TPU camera mount for iFlight Protek 35

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// mounting holes placement
dh = 2.3; // hole diameter
br = 4; // border radius from hole center
l1 = 24;
w1 = 14;
fa = 30;
sd = 4.0; // scredriwer diameter

// duct radius cutout
duct_x = 58;
duct_r = 48;
duct_y = br + l1 - 3;

// base plate
h0 = 2.5;
w0 = 26;
l0 = l1 + 2 * br;

// camera mount base dimensions
gl = 15; // length
gs = 9; // offset from the front

ch = 40.0;
cw = 11.0;
cr = 0.5;   // corner radius
mt = 2.5; // mount thickness
mw = 16;  // mount width

ma = 25; // mount angle (from vertical) 

// camera mount location
mx = 17;
mz = -0.5; 

// lens front
cx = 60; // horizontal camera size to compute offset
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

difference() {
    union() {
        translate([0, m_ty, m_tz])
            rotate([-ma, 0, 0])
                    mount();
        base_plate(); 
    }
    // baseplate holes
    translate([0, br, -eps]) cylinder(d = dh, h = h0 + 2 * eps);
    translate([w1 / 2, br + l1, -eps]) cylinder(d = dh, h = h0 + 2 * eps);
    translate([-w1 / 2, br + l1, -eps]) cylinder(d = dh, h = h0 + 2 * eps);
    // screwdriver 
    translate([0, br, h0]) cylinder(d = sd, h = ch);
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
 
module mount() {
    difference() {
        translate([-mw / 2, 0, 0])
            rotate([90, 90, 90])
                linear_extrude(mw) {
                    mount2d();
                }
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
