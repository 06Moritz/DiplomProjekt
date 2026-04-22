
= Controller
#set heading(offset: 1)


#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: bottom + center,
  stack(
    spacing: 0.5em,
    image("/Bilder/3d/con-sicht1.png", height: 200pt),
    text(size: 0.9em)[Controller]
  ),
  stack(
    spacing: 0.5em,
    image("/Bilder/cont.png", height: 220pt),
    text(size: 0.9em)[Foto des Prototyps]
  ),)

#include "hardware-controller.typ"
#include "software-controller.typ"
#include "3d-controller.typ"

