#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author3, #klasse])

= 3D-Druck <sec_auto-3d>
Das Auto ist so Designt, dass die Auto-Platine fest im Auto sitzt und die Schienen mit den Schleifkontakten, sowie für NFC lesen gut erreichbar ist. 
 == Anforderungen
- sichere Unterbringung der Leiterplatte
- gute Erreichbarkeit der Schienen mit den Schleifkontakten
- gute Erreichbarkeit der NFC Module
- Platz für den Motor


 == Grundstruktur
 Das Auto besteht aus einem Körper. Innen ist Platz für die Leiterplatte und dem Motor. 
 Innen auf der Unterseite ist ein Versatz eingebaut, der verhindert, dass die Leiterplatte zu weit in die Karosserie rutscht. Um das Hinausrutschen zu verhindern, ist ein Klippselement eingebaut.
\
#figure(
  fimage("/Bilder/3d/auto-gesamt.png", width: 100%),
  caption: [3d Auto Design]
)\

