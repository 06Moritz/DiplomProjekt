#import "../config.typ": *

= Basismodul
#set heading(offset: 1)


#grid(
  columns: (1.3fr, 1fr),
  gutter: 1em,
  align: bottom + center,
  stack(
    spacing: 0.5em,
    image("/Bilder/3d/bahn-3d-mitdisplay.png", height: 150pt),
    text(size: 0.9em)[Basismodul]
  ),
  stack(
    spacing: 0.5em,
    image("/Bilder/hm.png", height:200pt),
    text(size: 0.9em)[Foto des Prototyps]
  ),
)


#include "hardware-bahn.typ"
#include "software-bahn.typ"
#include "3d-bahn.typ"
