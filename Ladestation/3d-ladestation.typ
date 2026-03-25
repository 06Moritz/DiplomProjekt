#import "../config.typ": *
#aktueller_autor.update(author1+",\n"+author3) // Melanie 



// Bilder fehlen noch :)

= 3D <sec_lade-3d>
*!* Die Ladestation nimmt bis zu vier Controller gleichzeitig auf und lädt diese über Pogo Pins. Sie ist direkt mit dem Hauptmodul verbindbar.


== Anforderungen
- einfache Aufnahme von vier Controllern gleichzeitig
- zuverlässige Kontaktierung der Controller über Pogo Pins
- Anbindung an das Hauptmodul über @usbc

== Grundstrukutr
Das Gehäuse der Ladestation lässt sich in drei Teile aufteilen:
- Grundplatte: Einsatz durch Press-fit in der Grundplatte eingebaut. Einkerbung für Platine. Enthält Befestigungspunkte für den Deckel. Auschnitt für die USB-C Buchse.

- Einsatz: Einkerbungen für die Pogo Pins auf der Platine. //für stabilität?

- Deckel: Vertiefungen für die Controller und Einkerbungen für die Magnete


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


// vielleicht: Abstand zwischen den Controllerhalterungen & gesamte Länge bzw. Breite der Ladestation

== Pogo Pins
Die Pogo Pins sind zwischen Grundplatte und Deckel in den Einsatz eingesetzt und stehen nach oben hin durch die Löcher im Deckel. Beim Einlegen eines Controllers drücken die Federkontakte gegen die Ladekontakte an der Unterseite des Controllers und stellen so die elektrische Verbindung zur Leiterplatte her // (siehe @sec_ladestation-hardware).

== Controller-Aufnahmen
Der Deckel enthält vier Vertiefungen, in die die Controller hineingestellt werden. In jeder Vertiefung sind Magnete verbaut, die den Controller in die richtige Position ausrichten und so einen zuverlässigen Kontakt zu den Pogo Pins sicherstellen. Eine Verpolung ist durch die Anordnung der Magnete und der Form der Senken am Deckel nicht möglich (siehe @sec_ladestation-hw).

== Ladeanschluss
Die Ladestation wird über einen kurzen @usbc zu @usbc Adapter mit dem Ladeausgang des Hauptmoduls verbunden und mit 5V versorgt (siehe @sec_bahn-ladeausgang). Eine mechanische Verbindung zwischen Ladestation und Hauptmodul ist nicht vorgesehen, da die Ladestation flexibel nebem dem Hauptmodul platziert und versorgt oder extern angeschlossen werden kann.


== 3D-Druck

Der 3D Druck wird aus @abs gedruckt, da dieses Material eine hohe Festigkeit, Schlagzähigkeit und Hitzebeständigkeit bietet, was für die Funktionalität und Langlebigkeit der Ladestation beiträgt. 

Da @abs ein Hitzebeständiger Kunststoff ist, kann man ihn  mit Aceton bedampfen, ohne dass die Form des 3D Drucks darunter leidet. Durch das Bedampfen wird die Oberfläche der gedruckten Teile geglättet.

Toleranzen für die Pogo Pin Aussparungen, der Controller-Vertiefungen und für die Platine-Auskerbung sind im Design beachtet und durch Testdrucke angepasst.

Für ein Besseres zusammenfügen der Grundplatte und des deckels, wurden die Press-fit Verbindungen so angepasst, dass sie von dem Hauptdruck weg 2 grad abgeschrägt sind.
