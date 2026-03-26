//#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#import "../config.typ": *

#v(1cm)
 
// --- Titelbereich ---
#align(center)[
  #set text(size: 34pt, weight: "bold")
  DIPLOMARBEIT \
  #set text(size: 20pt, fill: rgb("#565656"))
  #projekt \
  #v(1cm)
  #image("../Bilder/logofinal.svg", width: 70%)
]
 
#v(3cm)

// --- Projektinformationen ---
#grid(
  columns: (1fr, 1fr),
  gutter: 3cm,
  // Linke Spalte: Linksbündig
  align(left)[
    #text(size: 14pt, weight: "bold")[Ausgeführt im Schuljahr\ 2025/26 von:] \
    #v(0.2cm)
    #author1  #klasse \
    #author2  #klasse \
    #author3  #klasse
  ],  
  // Rechte Spalte: Rechtsbündig
  align(left)[
    \
    #text(size: 14pt, weight: "bold")[Betreuer:] \
    #v(0.2cm)
    Prof. Dipl.-Ing. Reinhard Lindner  
  ]
)

#v(3cm)
//#pagebreak()
#line(length: 100%, stroke: 0.5pt)

Abgabevermerk:
#grid(
  gutter: 3cm,
  columns: (1fr, 1fr),
  [
    Datum: 27.03.2026
  ],
  [
    übernommen von:
  ]
)

#pagebreak()