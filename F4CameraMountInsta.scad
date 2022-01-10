

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

// insta mount
gl = 15;
gs = 3;

ch = 23.5;
cw = 17.0;
cr = 5;   // corner radius
mt = 2.2; // mount thickness
mw = 16;  // mount width

ma = 25; // mount angle (from vertical)

mx = 14;
mz = -1.5; 

// storage cutout
//scw = 7;
//sch = 2.2;
//scd = 4;


ihd = 2.5; // indicator hole diam
lhd = 17; // lens hole diam
lofs = 2.5; // lens offset

eps = 0.5;

m_ty = mx - (cw + 2 * mt) * cos(ma);
m_tz = (cw + 2 * mt) * sin(ma) + mz;

#difference() {
    translate([0, m_ty, m_tz])
        rotate([-ma, 0, 0])
                mount();
    // storage cutout                    
    //    translate([-scw / 2, gs + gl - scd, h0]) 
    //        cube([scw, 2 * scd, sch]);
    
}
          
//mount2d();            
            
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

