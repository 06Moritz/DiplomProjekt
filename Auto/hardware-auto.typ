#import "../config.typ": *
#aktueller_autor.update(author2) // Moritz

= Hardware
*!* Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung...

== Blockschaltbild
#figure(
image("../Bilder/BlockschaltbildAuto.png", width: 100%),
caption: [
Blockschaltbild des Systems
],
)

== Spannungsversorgung
*!* An den Schienen liegt eine Spannung von 12V an, die Schleifkontakte greifen die Spannung ab. Die Eingangspannung wird mit einem Buck-Converter auf 5V geregelt, dann auf 3,3V mit einem Linear-Regler. Die Stufenweise Spannungsregelung dient dazu eine sauberere Spannung mit geringen Ripple zu erhalten. 
== Motor 
*!* Als Motor wird ein 12V Gleichstrommotor verwendet, der über eine H-Brücke gesteuert wird. Die H-Brücke ermöglicht es, die Drehrichtung des Motors zu ändern und die Geschwindigkeit zu steuern. siehe @sec-hbridge Die Motorleistung wird über @pwm gesteuert.

== H-Brückenschaltung<sec-hbridge>
https://www.a-m-c.com/de/erfahrung/technologien/stromverbraucher/h-brucke/
#figure(
image("../Bilder/HBrueke.png", width: 50%),
caption: [
H-Brückenschaltung
],
)

*!* Eine H-Brücke ist eine Schaltung mit der man Motoren ansteuern kann. Die Drehrichtung kann durch die Ansteuerung der Transitoren geändert werden. Mit der Brücke kann man mit Signalspannung Motoren mit viel höherer Spannung steuren.

== Hauptcontroller – WCH CH585
^*!* https://www.wch-ic.com/products/CH585.html \
Der Hauptcontroller ist ein Risc-V Microcontroller von WCH. Er hat native Periferals für Bluetooth Low Energy (BLE) und Near Field Communication (NFC). 
== Funkverbindung – BLE 
*!* @ble ist für die Übertragung von kleinen Datenmengen optmiert, dadurch auch Energiesparend. Es funktioniert mit einem Server-Client System. Das schnelle und einfache Verbinden ist ein weiter Pluspunkt. @bleSource \
Implementierung in unserem Fall: Der Controller ist als Server konfiguriert, der Motorleistungswerte an das Auto sendet. Der Clinet ist das Auto,
- scannt nach Geräten
- Verbindet mit eingestellter MAC-Adresse
- Service- und Characteristic-Discovery
- Aktivieren von Notifications
- Verarbeitung empfangener Daten 




== Zeitmessung – NFC

== Leiterplatte
