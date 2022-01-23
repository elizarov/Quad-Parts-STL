// DJI Air Unit pair antennae holder for iFlight Protek 35

$fs = $preview ? 0.5 : 0.2;
$fa = $preview ? 10 : 2;

// basic block
bw = 20;
bh = 5;
bl = 30;

// legs that keep it in place
c0 = 10;
cl = 10;
cw = 3;
ct = 1.5;

// cutout for the power connector
pw = 10;
pl = 18;

// antenna support
ash = 10;
asw = 4; // width

// antenna itself
ad = 6;  // diameter
od = 14; // outer diameter
aa = 35; // angle 
aao = 11; // offset angle
axo = 6; // x offset
ayo = -2; // y offset
azo = -2; // z offset

eps = 0.5;

translate([0, 0, bh])
    mirror([0, 0, 1])
        model();

module model() {
    difference() {
        model0();
        // holes for antennas
        translate([axo, ayo, azo])
            rotate([90 - aa, 0, aao])
                translate([0, 0, - 2 * asw])
                    cylinder(d = ad, h = asw * 4);
        translate([-axo, ayo, azo])
            rotate([90 - aa, 0, -aao])
                translate([0, 0, - 2 * asw])
                    cylinder(d = ad, h = asw * 4);
    }
}

module model0() {
    difference() {
        translate([-bw / 2, 0, 0])
            cube([bw, bl, bh]);
        translate([-pw / 2, (bl - pl) / 2, -eps]) 
            cube([pw, pl, bh + 2 * eps]);
    }
        
    translate([bw / 2, 0, 0]) 
        leg();
    translate([-bw / 2, 0, 0]) mirror([1, 0, 0])
        leg();

    // antenna supports
    difference() {
        union() {
            intersection() {
                translate([axo, ayo, azo])
                    rotate([-aa, 0, aao])
                        translate([-bw / 2, -asw / 2, -ash])
                            cube([bw, asw, 2 * ash]);
                translate([axo, ayo, azo])
                    rotate([90 - aa, 0, aao])
                        translate([0, 0, -2 * asw])
                            cylinder(d = od, h = asw * 4);
            }
            intersection() {
                translate([-axo, ayo, azo])
                    rotate([-aa, 0, -aao])
                        translate([-bw / 2, -asw / 2, -ash])
                            cube([bw, asw, 2 * ash]);
                translate([-axo, ayo, azo])
                    rotate([90 - aa, 0, -aao])
                        translate([0, 0, -2 * asw])
                            cylinder(d = od, h = asw * 4);
            }
        }
        // cut the join
        translate([0, ayo - (od + ad) / 4 * sin(aao), azo])
            rotate([-aa, 0, 0])
                translate([-bw, -1.5 * asw, -ash])
                    cube([2 * bw, asw, 2 * ash]);
        // cut the top
        translate([-bw, -bl, bh])
            cube([2 * bw, 2 * bl, bh]);
    }
}
    
module leg() {
    translate([0, c0, 0])
        difference() {
            cube([cw, cl, bh]);
            translate([0, -eps, -eps])
                cube([cw / 2, cl + 2 * eps, bh - ct + eps]);
        }
}