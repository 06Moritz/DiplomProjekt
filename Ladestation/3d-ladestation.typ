#import "../config.typ": *
#aktueller_autor.update([#author3, \ #author1, #klasse])

// Geschwindigkeitsregelung und Joystick noch schreiben

= 3D <sec_lade-3d>
*!* Die Ladestation nimmt bis zu vier Controller gleichzeitig auf und lädt diese über Pogo Pins. Sie ist direkt mit dem Hauptmodul verbindbar.

== Anforderungen
- einfache Aufnahme von vier Controllern gleichzeitig
- zuverlässige Kontaktierung der Controller über Pogo Pins
- Anbindung an das Hauptmodul über @usbc

== Grundstrukutr
/* Das Gehäuse der Ladestation lässt sich in drei Teile aufteilen:
- Grundplatte: Einsatz durch Press-fit in der Grundplatte eingebaut. Einkerbung für Platine. Enthält Befestigungspunkte für den Deckel. Auschnitt für die USB-C Buchse.
- Einsatz: Einkerbungen für die Pogo Pins auf der Platine. //für stabilität?
- Deckel: Vertiefungen für die Controller und Einkerbungen für die Magnete */

- Grundplatte: bildet die Basis der Ladestation. Sie enthält eine Einkerbung für die Leiterplatte, einen Ausschnitt für die @usbc\-Buchse sowie Befestigungspunkte für den Deckel.
- Einsatz: wird durch Press-fit in die Grundplatte eingesetzt und enthält Einkerbungen für die Pogo Pins der Leiterplatte
- Deckel: enthält die vier Vertiefungen zur Aufnahme der Controller und Einkerbungen für die Magnete

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0em,
    align: bottom + center,
    stack(
      spacing: 0.5em,
      image("/Bilder/3d/lade-bot.png", height: 100pt),
      text(size: 0.9em)[Grundplatte],
    ),
    stack(
      spacing: 0.5em,
      image("/Bilder/3d/lade-mitte.png", height: 100pt),
      text(size: 0.9em)[Einsatz],
    ),
    stack(
      spacing: 0.5em,
      image("/Bilder/3d/lade-top.png", height: 100pt),
      text(size: 0.9em)[Deckel],
    ),
  ),
  caption: [Übersicht 3D-Teile der Ladestation],
  gap: 1em,
)

/*Gesamt:
- 234,4mm Lang
- 48,99mm breit
- Grundplatte: 12,39mm hoch
- Deckel: 14,93mm hoch

Einsatz:
- 227,9mm lang
- 16,67mm breit
- 6,5mm hoch
*/

\
Die Ladestation hat eine Gesamtlänge von 234,4mm und eine Breite von 49mm. Im Querschnitt ist der Aufbau der drei Teile sowie die Lage der Pogo Pins und der Controller-Vertiefung deutlich zu sehen. Im Längsschnitt sind die vier Pogo-Pin-Positionen und die @usbc\-Ausnehmung erkennbar.

#figure(
  grid(
    columns: (1fr, 4fr),
    gutter: 0.5em,
    figure(
      image("/Bilder/3d/lade-schnitt-breite.png", fit: "contain"),
    ),
    figure(
      image("/Bilder/3d/lade-schnitt-laenge.png", fit: "contain"),
    ),
  ),
  caption: [Quer- und Längsschnitt der Ladestation],
)

== Pogo Pins
Die Pogo Pins sind zwischen Grundplatte und Deckel in den Einsatz eingesetzt und stehen nach oben hin durch die Löcher im Deckel. Beim Einlegen eines Controllers drücken die Federkontakte gegen die Ladekontakte an der Unterseite des Controllers und stellen so die elektrische Verbindung zur Leiterplatte her. // (siehe @sec_ladestation-hw).

== Controller-Aufnahmen
Der Deckel enthält vier Vertiefungen, in die die Controller hineingestellt werden. In jeder Vertiefung sind Magnete verbaut, die den Controller in die richtige Position ausrichten und so einen zuverlässigen Kontakt zu den Pogo Pins sicherstellen. Eine Verpolung ist durch die Anordnung der Magnete und der Form der Senken am Deckel nicht möglich (siehe @sec_ladestation-hw).

// muss nicht sein ... wenn dann mit so Controller drinnen vllt
#figure(
  image("/Bilder/3d/lade-gesamt.png", width: 70%),
  caption: [3D Modell Ladestation],
)

== Ladeanschluss
Die Ladestation wird über einen kurzen @usbc zu @usbc Adapter mit dem Ladeausgang des Hauptmoduls verbunden und mit 5V versorgt (siehe @sec_bahn-ladeausgang). Eine mechanische Verbindung zwischen Ladestation und Hauptmodul ist nicht vorgesehen, da die Ladestation nebem dem Hauptmodul platziert und versorgt oder extern angeschlossen werden kann.

== 3D-Druck
Alle Teile sind aus schwarzem @abs gedruckt. Es bietet eine hohe Festigkeit, Schlagzähigkeit und Hitzebeständigkeit, was für die Langlebigkeit der Ladestation vorteilhaft ist.

Da @abs ein Hitzebeständiger Kunststoff ist, kann die Oberfläche der gedruckten Teile durch Bedampfen mit Aceton geglättet werden, ohne dass die Form darunter leidet.

Für ein zuverlässiges Zusammenfügen von Grundplatte und Deckel sind die Press-fit Verbindungen um 2° abgeschrägt. // um 2° nach außen abgeschrägt. // um 2° vom Hauptmodul weg abgeschrägt

Toleranzen für die Pogo-Pin-Aussparungen, die Controller-Vertiefungen und die Einkerbung für die Leiterplatte sind im Design beachtet und durch Testdrucke angepasst.

/* 
Der 3D Druck wird aus @abs gedruckt, da dieses Material eine hohe Festigkeit, Schlagzähigkeit und Hitzebeständigkeit bietet, was für die Funktionalität und Langlebigkeit der Ladestation beiträgt.

Da @abs ein Hitzebeständiger Kunststoff ist, kann man ihn  mit Aceton bedampfen, ohne dass die Form des 3D Drucks darunter leidet. Durch das Bedampfen wird die Oberfläche der gedruckten Teile geglättet.

Toleranzen für die Pogo Pin Aussparungen, der Controller-Vertiefungen und für die Platine-Auskerbung sind im Design beachtet und durch Testdrucke angepasst.

Für ein besseres Zusammenfügen der Grundplatte und des Deckels, wurden die Press-fit Verbindungen so angepasst, dass sie von dem Hauptdruck weg 2 Grad abgeschrägt sind.
 */