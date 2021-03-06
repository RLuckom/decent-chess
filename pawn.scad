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
  rotate([0, 180]) scale([1, 1, 1.7]) square_pyramid();
}
module donut() {
  translate([0, 0, -14]) 
    rotate_extrude(convexity = 10, $fn = 100)
    translate([9.6, 0, 0])
    circle(r = 6.8, $fn =100);
}
module pawn() {
  translate([0, 0, 22]) difference() {
    union() {
      translate([0, 0, -22]) cylinder(12, d=18, $fn=50);
      pawn_top();
    }
    donut();
  }
}

module pawn_top() {
  difference() {
    hull() {
      translate([0, 0, -10]) cylinder(1, d=8.2, $fn=50);
      scale([.75, .75, 1]) diamond();
    }
    translate([0, 0, -25]) cylinder(15, d=20, $fn=50);
  }

}
module knight_wing() {
  rotate([90, 0, 45]) scale([.27, .2, 1]) linear_extrude(height = 1, center=true, convexity = 10) import(file = "wing.dxf");
}
module knight() {
  translate([0, 0, 22]) union() {
    translate([0, 0, -22]) pawn();
    translate([0, -0.4, 2.6]) scale([.7, .8, .7]) knight_wing_wedge();
  }
}

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
  scale([1, 1, 1.3]) union() {
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
}

module knight_wing_wedge() {
  rotate([90, 0, 45]) scale([.27, .2, .15]) translate([0, 0, -83]) intersection() {
    linear_extrude(height = 120, convexity = 10) import(file = "wing.dxf");
    translate([-20,0,120])rotate([0, 90, -20]) translate([0, 10, -10]) scale([0.6, 1.2, 1]) linear_extrude(height = 90, convexity = 10) import(file = "knight_wedge.dxf");
    translate([10,200,120])rotate([10, 90, -90]) scale([0.6, 0.4, 1]) linear_extrude(height = 200, convexity = 10) import(file = "knight_wedge.dxf");
  }
}

module bullet_cone() {
  hull() {scale([.25, .25, .3]) rotate_extrude(angle = 360, convexity = 2, $fn = 200) import(file = "bishop_outline.dxf");
  }
}

module bishop() {
  scale([.9, .9, 1.5])
    difference() {
      linear_extrude(height=50, convexity=100, twist=270, $fn=200) {
        union() {
          square([5, 20], center=true);
          rotate([0, 0, 90]) square([4.5, 20], center=true);
        }
      }
      union() {
        scale([0.7, 0.7, 0.9]) bullet_cone();
        translate([0, 0, 0]) difference() {
          scale([3, 3, 3]) bullet_cone();
          scale([1.1, 1.1, 1.1]) bullet_cone();
        }
      }
    }
  cylinder(2, r=11, $fn=100);
}

module twisted_bishop() {
    twist = 425;
    post_rad = 1.6;
    post_dist = 5;
    height = 60;
    for (start = [0, 90, 270, 180]) {
      rotate([0, 0, start]) linear_extrude(height=height, convexity=100, twist=twist, $fn=200) {
          translate([post_dist, 0, 0]) circle(post_rad);
      }
      mirror() rotate([0, 0, start]) linear_extrude(height=height, convexity=100, twist=twist, $fn=200) {
          translate([post_dist, 0, 0]) circle(post_rad);
      }
  }
  cylinder(2, r=8, $fn=100);
}

module queen() {
  module buttress(cylinder_height=20) {
    translate([14, 0, 0]) cylinder(cylinder_height, r=3, $fn=80);
    translate([14, 0, cylinder_height]) cylinder(3, r1=3, r2=0, $fn=50);
    flyer(cylinder_height);
  }
  module flyer(cylinder_height) {
    translate([0, 0, cylinder_height - 15]) rotate([90, 10, 0]) translate([-2.9, 2, 0]) scale([1, 1, 1.3]) scale([.1, .2, 1]) linear_extrude(height = 2.3, center=true, convexity = 10) import(file = "buttress.dxf");
  }
  difference() {
    union() {
      cylinder(2, r=19, $fn=100 );
      difference() {
        union() {
          cylinder(65, r=6, $fn=80);
          rotate([0, 0, 6]) translate([3, 0, 58]) scale([1, 0.6, 2.5]) rotate([45, 0, 0]) cube(4);
          rotate([0, 0, -24])  translate([3, 0, 58]) scale([1, 0.6, 2.5]) rotate([45, 0, 0]) cube(4);
          rotate([0, 0, -57])  translate([3, 0, 58]) scale([1, 0.6, 2.5]) rotate([45, 0, 0]) cube(4);
          rotate([0, 0, -89])  translate([3, 0, 58]) scale([1, 0.6, 2.5]) rotate([45, 0, 0]) cube(4);
        }
        union() {
          translate([0,0,-1]) cylinder(80, r=4, $fn=80);
          difference() {
            translate([0,0,-1]) cylinder(80, r=15, $fn=80);
            translate([0,0,-1]) cylinder(80, r=6, $fn=80);
          }
        }
      }
      difference() {
        union() {
          rotate([0, 0, 45]) translate([0.9, 0, 0]) buttress(44);
          rotate([0, 0, 135]) translate([0.9, 0, 0]) buttress(31);
          rotate([0, 0, 225]) translate([0.9, 0, 0]) buttress(18);
        }
        cylinder(65, r=4, $fn=80);
      }
    }
    union() {
      rotate([0,0, 225]) translate([6,0,21.1]) scale([1, 1.6, 1.6]) rook_window();
      rotate([0,0, 135]) translate([6,0,34.1]) scale([1, 1.6, 1.6]) rook_window();
      rotate([0,0, 45]) translate([6,0,47.1]) scale([1, 1.6, 1.6]) rook_window();
      translate([0, 0, -1]) rotate([0, 0, 180]) linear_extrude(height=78, convexity = 2, twist=470, $fn=100) translate([6, 0, 0]) circle(9);
    }
  }
}

module king() {
  union() {
    difference() {
      cylinder(50, d=18, $fn=80);
      union() {
        for (height = [13:2.5:50]) {
          for (theta = [0:15:359]) {
            rotate([0, 0, theta]) translate([7, 0, height]) cube([2, 1.4, 1.4]);
          }
        }
        translate([0, 0, -1]) cylinder(51, d=16, $fn=80);
      }
    }
    cylinder(12, d=21, $fn=80);
    translate([0, 0, 50]) pawn();

  }
}

module bell() {
   rotate([0, 180, 0]) rotate_extrude(convexity = 10, $fn = 100) rotate([0, 0, 180]) translate([45, 0, 0]) rotate([0, 180, 0]) translate([-40, 0, 0]) import(file="flower.dxf");
}

module bell_flower() {
    bell();
    scale([.9, .9, 1]) translate([0, 0, 100]) bell();
    scale([.8, .8, 1]) translate([0, 0, 200]) bell();
    scale([.6, .6, 1]) translate([0, 0, 275]) bell();
    scale([.4, .4, 1]) translate([0, 0, 325]) bell();
}

module cage() {
      rotate_extrude(convexity = 10, $fn = 100) import(file="flower.dxf");
}

module new_bishop() {
    cylinder(2, r=10, $fn=100);
    translate([0,0,2]) scale([.06, .06, .09]) union() {
    intersection() {
    difference() {
    scale([4, 4, 5.5]) rotate_extrude(angle = 360, convexity = 2, $fn = 200) import(file = "bishop_outline.dxf");
        scale([3.2, 3.2, 5.0]) rotate_extrude(angle = 360, convexity = 2, $fn = 200) import(file = "bishop_outline.dxf");
    }
    for(height = [0:50:650]) {
    translate([0, 0, height]) cylinder(12, r=200);
    }
}
    intersection() {
    difference() {
    scale([4, 4, 5.5]) rotate_extrude(angle = 360, convexity = 2, $fn = 200) import(file = "bishop_outline.dxf");
        scale([3.2, 3.2, 5.0]) rotate_extrude(angle = 360, convexity = 2, $fn = 200) import(file = "bishop_outline.dxf");
    }
    for(x = [0:22.5:170]) {
    rotate([0, 0, x]) rotate([0, 90, 0]) cylinder(12, r=700, center=true);
    }
}
    bell_flower();
}
}

module dna() {
linear_extrude(height=60, twist=360, $fn=90) {
union() {
    translate([0, 5, 0], $fn=100) circle(2.5);
    translate([0, -5, 0], $fn=100) circle(2.5);
}
}
     for (height=[1:4:59]) {
         translate([0, 0, height]) rotate([90, 0, -360 * (height / 60.0)]) cylinder(10, r=1, center=true, $fn=40);
     }
 }
 
 module helix_bishop() {
     cylinder(2, r=8, $fn=100);
     dna();
 }
 
 
 module full_set() {
 pawn();
 translate([30, 0, 0]) rook();
 translate([60, 0, 0]) knight();
 translate([90, 0, 0]) helix_bishop();
 translate([120, 0, 0]) queen();
 translate([150, 0, 0]) king();
 }
 
 king();
 //translate([10, 0, 0]) mirror() helix_bishop();
 
 
//new_bishop();
//scale([.06, .06, .09]) bell_flower();
//bell();
//twisted_bishop();
//bishop();
//translate([-40, 0, 0]) knight();
//rook();
//pawn();
//translate([40, 0, 0]) queen();
//rotate([0,0,-130]) translate([4,0,9]) rook_window();
//translate([80, 0, 0]) king();
//rook_window();
//pawn_top();


