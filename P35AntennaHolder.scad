

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
ash = 7;
asd = 6;

// antenna itself
ad = 4;  // diameter
od = 10; // outer diameter
aa = 20; // angle 

eps = 0.5;

translate([0, 0, bh])
    mirror([0, 0, 1])
        model();

module model() {
    difference() {
        model0();
        rotate([90 - aa, 0, 0])
            translate([0, 0, -2 * asd])
                cylinder(d = ad, h = asd * 4);
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

    intersection() {
        translate([-bw / 2, 0, -ash])
            cube([bw, asd, ash + eps]);
        
        rotate([90 - aa, 0, 0])
            translate([0, 0, -2 * asd])
                cylinder(d = od, h = asd * 4);
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