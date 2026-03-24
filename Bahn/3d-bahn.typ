#import "../config.typ": *
#pagebreak()
#aktueller_autor.update(author1) // Melanie

= 3D <sec_bahn-3d>
*!* Das Hauptmodul nimmt die Leiterplatte, das Display sowie die Schienen auf. Ein kompaktes Design hält alle Komponenten sicher zusammen und ermöglicht eine einfache Montage.

== Anforderungen
- platzsparende und sichere Unterbringung von Leiterplatte und Display
- Zugängigkeit von @usbc\-Eingang (12V Versorgung) und @usbc\-Ladeausgang für die Ladestation
- Positionierung der @nfc\-Module flexibel unter den Schienen möglich

== Grundstruktur
Das Gehäuse besteht aus drei separat gedruckten Teilen, die ohne zusätzlichem Werkzeug zusammengefügt werden:
- Bahn: Hauptteil, das die Leiterplatte, die beiden Fahrspuren sowie die schräge Displayhalterung trägt
- Einschub: schließt hinter dem Display die Rückseite des Gehäuses ab
- Fixierung: Klemmelement, das Bahn und Einschub zusammenhält

#figure(
  grid(
    columns: (1.6fr, 1fr, 1fr),
    gutter: 1em,
    align: bottom + center,
    stack(
      spacing: 0.5em,
      image("/Bilder/3d/bahn-3d-schienen-vorne.png", height: 100pt),
      text(size: 0.9em)[Bahn]
    ),
    stack(
      spacing: 0.5em,
      image("/Bilder/3d/bahn-3d-einschub-rechts.png", height: 100pt),
      text(size: 0.9em)[Einschub]
    ),
    stack(
      spacing: 0.5em,
      image("/Bilder/3d/bahn-3d-deckel-rechts.png", height: 100pt),
      text(size: 0.9em)[Fixierung]
    ), 
  ),
  caption: [Übersicht 3D-Teile der Bahn],
  gap: 1em
)

== Bahn
// ! RICHTIGES REFERENZIEREN !
Die Bahn ist 30cm lang und 11,4cm breit. Die Steckverbindungen und Maße sind so gewählt, dass das Schienenteil mit handelsüblichen Carrera-GO!-Schienen kompatibel ist. Die Metallschienen werden in die gedruckten Führungen eingesteckt und sind dadurch leicht austauschbar. Die Schienen sind so ausgeführt, dass Fahrzeuge über Schleifkontakte die anliegende Spannung von 12V abgreifen können (siehe @sec_auto-spgversorgung).

Unter jeder Fahrspur befindet sich eine Aussparung für je ein @nfc\-Modul (siehe @sec_bahn-nfc). Durch die Kabelverbindung zur Leiterplatte können die Module unabhängig vom Gehäuse exakt unter den Schienen positioniert werden.

#figure(
  stack(
    spacing: 1em,      // Abstand zwischen den beiden Bildern
    image("/Bilder/3d/bahn-3d-schienen-schnitt.png", width: 70%),
    image("/Bilder/3d/bahn-3d-schienen-schnitt-nfc.png", width: 70%),
  ),
  caption: [Querschnittvergleich bei NFC],
)

== Displayhalterung
Die Displayhalterung ist direkt mit dem Schienenteil verbunden und vor den Schienen positioniert. Das Display wird in einem 35° Winkel gehalten, um eine gute Sichtbarkeit aus der Spielerperspektive zu gewährleisten. Die Breite der Halterung orientiert sich an den Maßen der Leiterplatte und beträgt 115mm.

#figure(
  image("/Bilder/3d/bahn-3d-mitdisplay.png", width: 80%),
  caption: [Bahn und Displayhalterung],
)

== Einschub
Der Einschub wird von rechts in die Bahn eingeschoben und bildet den hinteren Abschluss des Gehäuses. Er verdeckt die Leiterplatte sowie die Rückseite des Displays. Auf der rechten Seite befindet sich eine Aussparung für den @usbc\-Eingang der Spannungsversorgung.

#figure(
  grid(
    columns: (1fr, 1fr, auto),
    gutter: 1em,
    align: horizon + center,
    image("/Bilder/3d/bahn-3d-einschub-rechts.png", height: 110pt),
    image("/Bilder/3d/bahn-3d-einschub-seite.png", height: 110pt),
    image("/Bilder/3d/bahn-3d-einschub-links.png", height: 100pt),
  ),
  caption: [Einschub],
)

== Fixierung
Die Fixierung wird auf der linken Seite aufgesteckt und hält die Displayhalterung und den Einschub durch eine Press-fit Verbindung zusammen. Auf dieser Seite befindet sich außerdem die Aussparung für den @usbc\-Ladeausgang zur Versorgung der Ladestation mit 5V (siehe @sec_bahn-ladeausgang).

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1em,
    align: horizon + center,
    image("/Bilder/3d/bahn-3d-deckel-rechts.png", height: 90pt),
    image("/Bilder/3d/bahn-3d-deckel-vorne.png", height: 80pt),
    image("/Bilder/3d/bahn-3d-deckel-links.png", height: 90pt),
  ),
  caption: [Fixierung],
)

== 3D-Druck
Alle Teile sind in Autodesk Fusion 360 modelliert und aus schwarzem ABS gedruckt. Die Wandstärken sind so dimensioniert, dass nötige Verbindungen stabil zusammenhalten. Toleranzen für die Schienenführungen sowie die Display- und @nfc\-Aussparungen sind durch Testdrucke angepasst.
