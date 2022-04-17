// Insta Go 2 TPU camera mount for iFlight Protek 35

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

// Mount base dimensions
gl = 14;
gs = 10;

// Camera mount placement
mx = 22;
mz = -1.0; 

ch = 23.5;
cw = 17.0;
cr = 5;   // corner radius
mt = 2.2; // mount thickness
mw = 16;  // mount width

ma = 25; // mount angle (from vertical)

ihd = 2.5; // indicator hole diam
lhd = 17; // lens hole diam
lofs = 2.5; // lens offset

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
    translate([cr - ch - mt, cr + mt])
        offset(cr + mt) square([ch - 2*cr, cw - 2*cr]);
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
        translate([0, mt + eps, ch / 2 + mt])
            rotate([90, 0, 0])
                cylinder(d = ihd, h = mt + 2 * eps);
        translate([lofs + lhd / 2, mt + eps, ch / 2 + mt])
            rotate([90, 0, 0])
                cylinder(d = lhd, h = mt + 2 * eps);
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
