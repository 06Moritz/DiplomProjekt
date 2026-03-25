#import "../config.typ": *
#aktueller_autor.update(author1) // Melanie

// Bilder fehlen noch :)

= 3D <sec_lade-3d>
*!* Die Ladestation nimmt bis zu vier Controller gleichzeitig auf und lädt diese über Pogo Pins. Sie ist direkt mit dem Hauptmodul verbindbar.

== Anforderungen
- einfache Aufnahme von vier Controllern gleichzeitig
- zuverlässige Kontaktierung der Controller über Pogo Pins
- Anbindung an das Hauptmodul über @usbc

== Grundstrukutr
Das Gehäuse der Ladestation lässt sich in drei Teile aufteilen:
- Grundplatte: ...
- Pogo-Pin-Halterung: ... // 2 Teile schließen Pogo Pins ein
- Oberteil: vier Mulden zur Aufnahme der Controller

// vielleicht: Abstand zwischen den Controllerhalterungen & gesamte Länge bzw. Breite der Ladestation

== Pogo Pins
Die Pogo Pins sind zwischen Grundplatte und Oberteil eingesetzt und stehen nach oben durch das Oberteil hindurch in die Mulden. Beim Einlegen eines Controllers drücken die Federkontakte gegen die Ladekontakte an der Unterseite des Controllers und stellen so die elektrische Verbindung zur Leiterplatte her // (siehe @sec_ladestation-hardware).

== Controller-Aufnahmen
Das Oberteil enthält vier Mulden, in die die Controller eingelegt werden. In jeder Mulde sind Magnete verbaut, die den Controller automatisch in die richtige Position ausrichten und so einen zuverlässigen Kontakt zu den Pogo Pins sicherstellen. Eine Verpolung ist durch die Anordnung der Magnete nicht möglich (siehe @sec_ladestation-hw).

== Ladeanschluss
Die Ladestation wird über einen kurzen @usbc zu @usbc Adapter mit dem Ladeausgang des Hauptmoduls verbunden und mit 5V versorgt (siehe @sec_bahn-ladeausgang). Eine mechanische Verbindung zwischen Ladestation und Hauptmodul ist nicht vorgesehen, da die Ladestation flexibel neben dem Hauptmodul platziert oder extern angeschlossen werden kann.

== 3D-Druck
Alle Teile sind in Autodesk Fusion 360 modelliert und aus schwarzem ABS gedruckt. Die Wandstärken sind so dimensioniert, dass die Press-fit Verbindung zwischen Grundplatte und Oberteil stabil hält. Toleranzen für die Pogo Pin Aussparungen sowie die Controller-Mulden sind im Design beachtet und durch Testdrucke angepasst.