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
  knight_wing_wedge();
}

knight();

module rook_crown() {
  for (rot= [0:45:359]) {
    rotate([0, 0, rot]) translate([0, 5.5, 0]) cube([2, 1, 2.5], center=true);
  }
}

module rook_window() {
  hull() {
    translate([-3, -.2, 0]) rotate([90, 0, 90]) scale([.01, .03, 1])  linear_extrude(height = .1, center=true, convexity = 10) import(file = "rook_window.dxf");
    translate([0, -1, 0]) rotate([90, 0, 90]) scale([.05, .04, 1])  linear_extrude(height = .1, center=true, convexity = 10) import(file = "rook_window.dxf");
  }
}

module rook_center_tower() {
  difference() {
    union() {
      union() {
        cylinder(28, r=1, $fn=100);
        difference() {
          union() {
            translate([0, 0, 30]) rook_crown();
            cylinder(30, r=6, $fn=100);
          }
          union() {
            translate([0, 0, 27.9]) cylinder(5, r=5.2, $fn=100);
            translate([0, 0, 3]) cylinder(28, r=4, $fn=100);
            difference() {
              cylinder(38, r=7, $fn=100);
              cylinder(38, r=6, $fn=100);
            }
          }
        }
        for (height=[0:1:27]) {
          rotate([0, 0, height * 15]) translate([-.5, 0, height]) cube([1.3, 4, 1]);

        }
      }
    }
    union() {
      translate([6,0,20]) rook_window();
      translate([3,-1.25,3])  rotate([0, 0, 0]) cube([10, 2.5, 6]);
      rotate([0,0,90]) translate([6,0,5]) rook_window();
      rotate([0,0,180]) translate([6,0,10]) rook_window();
      rotate([0,0,270]) translate([6,0,15]) rook_window();
    }
  }
}

module rook_buttress() {
  translate([14, 0, 0]) cylinder(20, r=2.5, $fn=80);
  translate([14, 0, 20]) cylinder(3, r1=2.5, r2=0, $fn=50);
  translate([0, 0, 15]) rotate([90, 10, 0]) translate([-2, 2, 0]) scale([.1, .1, 1]) linear_extrude(height = 1, center=true, convexity = 10) import(file = "buttress.dxf");
}

module rook() {
rook_center_tower();
cylinder(1, r=16.5, $fn=100);
difference() {
  union() {
    rotate([0, 0, 45]) rook_buttress();
    rotate([0, 0, 135]) rook_buttress();
    rotate([0, 0, 225]) rook_buttress();
    rotate([0, 0, 315]) rook_buttress();
  }
  translate([0, 0, 3]) cylinder(28, r=4, $fn=100);
}
}

module knight_wing_wedge() {
rotate([90, 0, 45]) scale([.27, .2, .15]) translate([0, 0, -83]) intersection() {
linear_extrude(height = 120, convexity = 10) import(file = "wing.dxf");
    translate([-20,0,120])rotate([0, 90, -20]) translate([0, 10, -10]) scale([0.6, 1, 1]) linear_extrude(height = 90, convexity = 10) import(file = "knight_wedge.dxf");
    translate([10,200,120])rotate([10, 90, -90]) scale([0.6, 0.35, 1]) linear_extrude(height = 200, convexity = 10) import(file = "knight_wedge.dxf");
}
}