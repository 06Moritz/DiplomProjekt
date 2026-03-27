#import "../config.typ": *
#aktueller_autor.update([#author3, \ #author1, #klasse])



= 3D <sec_lade-3d>
Die Ladestation nimmt bis zu vier Controller gleichzeitig auf und lädt diese über Federkontakte. Sie kann direkt an das Hauptmodul angeschlossen werden.

== Anforderungen
- gleichzeitige Aufnahme von vier Controllern 
- zuverlässige Ladeverbindung der Controller über    Federkontakte
- Anbindung an das Hauptmodul über @usbc

== Grundstruktur

Das Gehäuse der Ladestation lässt sich in drei Teile aufteilen:
- Grundplatte: bildet die Basis der Ladestation. Sie enthält eine Einkerbung für die Leiterplatte, einen Ausschnitt für die @usbc\-Buchse sowie Befestigungspunkte für den Deckel.
- Einsatz: wird durch Press-fit in die Grundplatte eingesetzt und enthält Einkerbungen für die Federkontakte der Leiterplatte
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



\
Die Ladestation hat eine Gesamtlänge von 234,4mm und eine Breite von 49mm. Im Querschnitt ist der Aufbau der drei Teile sowie die Lage der Federkontakte und der Controller-Vertiefung deutlich zu sehen. Im Längsschnitt sind die vier Federkontakt-Positionen und die @usbc\-Ausnehmung erkennbar.

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

== Federkontakte
Die Federkontakte sind zwischen Grundplatte und Deckel in den Einsatz eingesetzt und stehen nach oben hin durch die Ausnehmungen im Deckel. Beim Einlegen eines Controllers drücken die Federkontakte gegen die Ladekontakte an der Unterseite des Controllers und stellen so die elektrische Verbindung zur Leiterplatte her. // (siehe @sec_ladestation-hw).

== Controller-Aufnahmen
Der Deckel hat vier Vertiefungen, in die die Controller hineingestellt werden. In jeder Vertiefung sind Magnete verbaut, die den Controller in die richtige Position ausrichten und so einen zuverlässigen Kontakt zu den Federkontaktensicherstellen. Eine Verpolung ist durch die Anordnung der Magnete und der Form der Senken am Deckel nicht möglich (siehe @sec_ladestation-hw).

// muss nicht sein ... wenn dann mit so Controller drinnen vllt
#figure(
  image("/Bilder/3d/lade-gesamt.png", width: 70%),
  caption: [3D Modell Ladestation],
)

== Ladeanschluss
Die Ladestation wird über einen kurzen @usbc zu @usbc Adapter mit dem Ladeausgang des Hauptmoduls verbunden und mit 5V versorgt (siehe @sec_bahn-ladeausgang). Eine mechanische Verbindung zwischen Ladestation und Hauptmodul ist nicht vorgesehen, da die Ladestation nebem dem Hauptmodul platziert und versorgt oder extern angeschlossen werden kann.

== 3D-Druck
Alle Teile sind aus schwarzem @abs gedruckt. Da @abs ein Kunststoff ist, der Chemisch geglättet werden kann.

Für ein zuverlässiges Zusammenfügen von Grundplatte und Deckel sind die Press-fit Verbindungen um 2° abgeschrägt. 

Toleranzen für die Pogo-Pin-Aussparungen, die Controller-Vertiefungen und die Einkerbung für die Leiterplatte sind im Design beachtet und durch Testdrucke angepasst.
