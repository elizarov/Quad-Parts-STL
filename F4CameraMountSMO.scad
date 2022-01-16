// SMO 4K TPU camera mount for HGLRC Recon 4 FR frame

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// base plate
h0 = 2.5;
w0 = 5;
d1 = 25;
d2 = 20;
l0 = 28.3;
s12 = (d1 - d2) / 2;
dh = 2;

br = 2; // bevel radius (on inner corners)

// Mount base dimensions
gl = 15;
gs = 3;

ch = 40.0;
cw = 11.0;
cr = 0.5;   // corner radius
mt = 2.2; // mount thickness
mw = 16;  // mount width

ma = 25; // mount angle (from vertical) 

mx = 14;
mz = 0.0; 

// lens front
cx = 60; // horizontal camera size to compute offset
lfw = 23;
lfh = 23;
lfr = 3; // radius
lfx = 1.5;
lfz = 11.3;

// lens back
lbw = 26.8;
lbh = 21.8;
lbr = 0.5; // radius
lbx = 1.0;
lbz = 12;

eps = 0.5;

m_ty = mx - (cw + 2 * mt) * cos(ma);
m_tz = (cw + 2 * mt) * sin(ma) + mz;

translate([0, m_ty, m_tz])
    rotate([-ma, 0, 0])
            mount();
          
//#mount2d_inner();            
//mount2d_outer();            
            
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
 
//mount();

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
        #translate([lbr + (cx / 2 - lbw - lbx), cw + 4 * mt + eps, lbr + mt + lbz])
            rotate([90, 0, 0])
                linear_extrude(3 * mt + 2 * eps)
                    offset(lbr)
                        square([lbw - 2 * lbr, lbh - 2 * lbr]);
    }
}    

   
linear_extrude(h0) {
    difference() {
        union() {
            hull() {
                translate([d1 / 2, 0]) circle(d = w0);
                translate([d2 / 2 + s12, l0 - s12]) circle(d = w0);
            }
            hull() {
                translate([d2 / 2 + s12, l0 - s12]) circle(d = w0);
                translate([d2 / 2, l0]) circle(d = w0);
            }

            hull() {
                translate([-d1 / 2, 0]) circle(d = w0);
                translate([-d2 / 2 - s12, l0 - s12]) circle(d = w0);
            }
            hull() {
                translate([-d2 / 2 - s12, l0 - s12]) circle(d = w0);
                translate([-d2 / 2, l0]) circle(d = w0);
            }
            translate([-d1 / 2, gs])
                square([d1, gl]);
            translate([-d1 / 2 + w0 / 2, gs - br])
                difference() {
                    translate([-eps, 0]) square([br + eps, br + eps]);
                    translate([br, 0]) circle(r = br);
                }
            translate([d1 / 2 - w0 / 2 - br, gs - br])
                difference() {
                    translate([0, 0]) square([br + eps, br + eps]);
                    circle(r = br);
                }
            translate([-d1 / 2 + w0 / 2, gs + gl])
                difference() {
                    translate([-eps, -eps]) square([br + eps, br + eps]);
                    translate([br, br]) circle(r = br);
                }
            translate([d1 / 2 - w0 / 2 - br, gs + gl])
                difference() {
                    translate([0, -eps]) square([br + eps, br + eps]);
                    translate([0, br]) circle(r = br);
                }
        }
        translate([d1 / 2, 0]) circle(d = dh);
        translate([d2 / 2, l0]) circle(d = dh);
        translate([-d1 / 2, 0]) circle(d = dh);
        translate([-d2 / 2, l0]) circle(d = dh);
    }
} 

