#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author1, #klasse])

// DREHREGLER????????

= Gehäuse <sec_con-3d>
Im Gehäuse des Controllers sind alle elektronischen Komponenten verbaut. Die Form ermöglicht eine ergonomische Handhabung. Der Controller ist so gestaltet, dass er sowohl die Funktionalität als auch die Ästhetik berücksichtigt.

== Anforderungen <sec_con-anforderungen>
- ergonomische Formgebung für einhändiges Spielen
- sichere Aufnahme von Platine, Akku und Vibrationsmotor
- zugängliche Positionierung des Geschwindigkeitsreglers und Joysticks
- sichtbares Display für Informationen
- zuverlässige Kontaktierung der Ladestation über Federkontakte an der Unterseite

== Grundstruktur <sec_con-struktur>
Das Gehäuse besteht aus drei einzelnen Teilen, die zusammengefügt werden:
- linke Hälfte: Aufnahme von Leiterplatte, Vibrationsmotor und Potentiometer
- rechte Hälfte: Aufnahme des Akkus
- Reglerkomponente: Drehregler für die Geschwindigkeitssteuerung über das Potentiometer


#grid(
  columns: (1fr, 1fr),
  figure(
    image("/Bilder/3d/controller-links.png", height: 250pt),
    caption: [Controllerhälfte links],
  ),
  figure(
    image("/Bilder/3d/controller-rechts.png", height: 250pt),
    caption: [Controllerhälfte rechts],
  ),
)

Die beiden Hälften werden über drei sechseckige Stifte zusammengesteckt. Die sechseckige Form verhindert ein Verdrehen unter Belastung und erhöht die Stabilität der Druckverbindung.

Die Leiterplatte mit dem Joystick sowie die Federkontakte werden zwischen die beiden Hälften geklemmt und so an der Position gehalten.

== Ergonomie <sec_con-ergonomie>
Der Controller ist als Einhand-Controller konzipiert und als Pistolengriff ausgeführt. Die Gesamtgröße beträgt in etwa 110 × 55 mm und liegt somit gut in der Hand. Der Zeigefinger steuert die Geschwindigkeitsregelung, während der Daumen den Joystick auf der Oberseite des Gehäuses bedient.

\
#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 0em,
    align: bottom + center,
    image("/Bilder/3d/con-sicht1.png", height: 300pt), 
    image("/Bilder/3d/con-sicht2.png", height: 300pt),
  ),
  caption: [3D-Modell Controller],
  gap: 1em,
)

#pagebreak()

== Display <sec_con-display>
Das Display wird oben am Gehäuse angebracht und liegt auf zwei Balken auf, die eine gerade Ausrichtung sicherstellen und ein Verrutschen verhindern. Es ist so positioniert, dass es während des Spielens gut ablesbar ist, ohne die Handhabung zu beeinträchtigen. Die Gehäuseöffnung ist an die Form der Displayplatine angepasst, sodass ausschließlich die aktive Displayfläche sichtbar ist.

#grid(
  columns: (1fr, 1fr),
  figure(
    image("/Bilder/3d/con-display.png", height: 155pt),
    caption: [Displayposition],
  ),
  figure(
    image("/Bilder/3d/con-schnitt-display_cr.png", height: 155pt),
    caption: [Schnittanalyse Display],
  ),
)

== Geschwindigkeitsreglung <sec_con-regelung>
Die Geschwindigkeitsregelung erfolgt über einen keilförmigen Drehregler, der direkt unter dem Display angebracht ist. Er ist über einen Achsstift mit einem Potentiometer verbunden, das fest in der linken Gehäusehälfte eingeklemmt ist. Rechts wird der Achsstift in die Gehäusewand gesteckt und so gelagert. Über eine eingehängte Feder innerhalb des Drehelements wird der Regler gegen den im Gehäuse fixierten Joystick gedrückt, der als mechanischer Widerstand dient und so eine definierte Rückstellkraft erzeugt.

#grid(
  columns: (1fr, 1fr),
  figure(
    image("/Bilder/3d/controller-regler.png", height: 155pt),
    caption: [Geschwindigkeitsregler],
  ),
  figure(
    image("/Bilder/3d/con-schnitt-regler_cr.png", height: 155pt),
    caption: [Schnittanalyse Regler],
  ),
)

== Joystick <sec_con-joystick>
Der Joystick ist durch eine Aussparung im oberen Bereich des Gehäuses zugänglich und kann gedrückt oder nach unten gezogen werden. Die beiden Aktionen sind softwareseitig mit je einer Funktion belegt //(siehe @sec_con-software).

#grid(
  columns: (1fr, 1fr),
  figure(
    image("/Bilder/3d/con-schnitt-joystick.png", height: 170pt),
    caption: [Schnittanalyse Joystick],
  ),
  figure(
    image("/Bilder/3d/con-schnitt-joystick2.png", height: 170pt),
    caption: [Schnitt Joystickhalterung],
  ),
)

== Komponentenmontage <sec_con-montage>
Die Platine wird über eine Klemmverbindung eingesteckt und über Stifte auf einen gleichmäßigen Abstand fixiert. Akku und Vibrationsmotor werden ebenfalls eingeklemmt. Der obere Teil des Vibrationsmotors kann sich dabei frei drehen und wird durch die Biegung des Gehäuses nicht eingeschränkt.

#grid(
  columns: (1fr, 1fr),
  figure(
    image("/Bilder/3d/con-schnitt-akku.png", height: 190pt),
    caption: [Schnittanalyse Akku],
  ),
  figure(
    image("/Bilder/3d/con-schnitt-vib.png", height: 190pt),
    caption: [Schnittanalyse Leiterplatte und Vibrationsmotor],
  ),
)

#pagebreak()

== Ladeanbindung <sec_con-laden>
An der Unterseite des Controllers befinden sich
Federkontakte sowie Magnete zur Verbindung an die
Ladestation. Die Magnete sorgen für eine definierte
Ausrichtung beim Andocken, während die Federkontakte
den elektrischen Kontakt herstellen
(siehe @sec_lade-3d).

/* - Position der Federkontakte an der Unterseite
- Magnet-Verpolschutz (wie in Abschnitt 7 beschrieben)
- Ausrichtung zur Ladestation
 */

#grid(
  columns: (1fr, 1fr),
  figure(
    image("/Bilder/3d/con-laden_cr.png", height: 85pt),
    caption: [Ladeanbindung],
  ),
  figure(
    image("/Bilder/3d/con-schnitt-laden.png", height: 85pt),
    caption: [Schnittanalyse Federkontakte],
  ),
)

== 3D-Druck <sec_con-druck>
Das Gehäuse ist in @fusion360:short modelliert und aus schwarzem @abs gedruckt. @abs bietet gegenüber @pla eine höhere Schlagfestigkeit und Temperaturbeständigkeit, was für ein täglich genutztes Handgerät vorteilhaft ist. Toleranzen für die Klemmverbindungen sowie die Aussparungen für Display und Regler sind durch Testdrucke angepasst.
