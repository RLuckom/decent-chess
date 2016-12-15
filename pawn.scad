module square_pyramid() {
polyhedron(
  points=[ [10,10,0],[10,-10,0],[-10,-10,0],[-10,10,0], // the four points at base
           [0,0,10]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}
module diamond() {
square_pyramid();
rotate([0, 180]) {square_pyramid();}
}
module donut() {
translate([0, 0, -14]) 
rotate_extrude(convexity = 10, $fn = 100)
translate([9, 0, 0])
circle(r = 6.8, $fn =100);
}
module pawn() {
difference() {
    union() {
    translate([0, 0, -22]) cylinder(12, d=18, $fn=50);
        hull() {
            translate([0, 0, -10]) cylinder(1, d=7, $fn=50);
            scale([.75, .75, 1]) diamond();
        }
    }
donut();
}
}
module knight_wing() {
rotate([90, 0, 45]) scale([.27, .2, 1]) linear_extrude(height = 1, center=true, convexity = 10) import(file = "wing.dxf");
}
module knight() {
    pawn();
    knight_wing();
    rotate([0, 0, 90]) knight_wing();
    rotate([0, 0, 180]) knight_wing();
    rotate([0, 0, 270]) knight_wing();
}

knight();