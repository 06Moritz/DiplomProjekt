= Fahrzeug
#set heading(offset: 1)


#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: bottom + center,
  stack(
    spacing: 0.5em,
    image("/Bilder/3d-car.png", height: 150pt),
    text(size: 0.9em)[Fahrzeug]
  ),
  stack(
    spacing: 0.5em,
    image("/Bilder/auto.png", height:200pt),
    text(size: 0.9em)[Foto des Prototyps]
  ),
)
#include "hardware-auto.typ"
#include "software-auto.typ"
#include "mec-auto.typ"
#include "3D-auto.typ"