       inkscape -E intermediate.eps wing.svg
       pstoedit -dt -f dxf:-polyaslines\ -mm intermediate.eps wing.dxf


## Overview

This project consists of models of chessmen created in December 2016.
I made the models in openscad, used Cura to slice them, and printed 
them on a Prusa i3 built from a kit. I started out with an idea for each piece
and revised it according to aesthetics and printability.

## Lessons learned

1. If a design has even a single element that is near the technical limits of
   the printer, that design will be a repeatability nightmare.
2. The way to tell whether a design is too risky is to ask yourself if you'd
   feel comfortable printing several of them on a plate at once along with
   assorted other pieces.
3. No element should be less than about 4x the width of the print head or else
   the cumulative error of the print head ending layers in the same place will
   cause the head to catch and break the piece.

## Story

Chess pieces have a few jobs. Perhaps most importantly, they have to be
recognizable to the players without much thought. They also have to feel nice in
the hand, be relatively stable, and look nice. The Staunton Chess set, first
created in 1849, was so successful at these jobs that it is now an
international standard.

I love the elegance and proportions of the Staunton set. I wanted to make a set
that was similarly proportioned, but that could take advantage of the strengths
of 3d printing. I also thought that it would be fun to reimagine the pieces from
a more modern perspective.

From a practical standpoint, I took a lot of inspiration from the Staunton set
because 1) it's beautiful; and 2) similarities to the Staunton set will help my
pieces do their main job of being instantly recognizable. I kept the basic shape
of the pawns but removed the collars and made the top s prism rather than a
ball. I kept the queen's coronet and the rook's castle shape and crenelations. I
kept the relative heights of the pieces, with the king tallest, followed by the
queen, bishops, knights, rooks, and pawns.

Some of my changes were for printability. The knight from the Staunton set is
all wrong for printing without supports (it was an exception in the Staunton set
as well; most of the pieces could be produced by turning on a lathe, but the
horse head of the knights and other asymmetric details had to be carved
separately). I started with a four-winged shape, but I worried that its symmetry
was too much of a departure from the Staunton set to be recognizable as a
knight. So I removed all but one of the wings, ending up with a shape that looks
a bit like a pawn with a sword blade, or with the wing reversed, a bit like a
knight's helmet with a plume.

For the rook, I kept the familliar castle design but added some details that
would have been hard using other construction methods. I made the central tower
hollow, and added a spiral staircase from a tiny door all the way to the top.
There are windows positioned to light the stairs, and the windows are wider at
the outside wall than at the inside wall, giving archers firing from within a
broad field without exposing too much of a target to those firing in. The
buttresses were just fun to make and I think they look cool.

For the bishop, I chose not to retain any of the identifying marks from the
Staunton piece. 
