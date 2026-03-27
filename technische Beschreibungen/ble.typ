#import "../config.typ": *

#aktueller_autor.update([#author1, \ #author2, #klasse])

= Bluetooth Low Energy (BLE) <sec_ble>
@ble:long ist ein drahtloses Kommunikationsprotokoll, das speziell für die Verbindung von Geräten über kurze Entfernungen entwickelt wurde. @ble ist für Übertragung von kleinen Datenmengen optimiert und zeichnet sich durch folgende Eigenschaften aus:
- energiesparend durch geringen Datendurchsatz
- Sender und Empfänger im @deepsleep:short\-Modus wenn keine Daten gesendet werden 
- kurze Verbindungszeiten
- Anpassbarkeit auf Bedarf der Übertragung
Es ist dadurch geeignet für batteriebetriebene Geräte. @ble besteht aus zwei Geräten: peripheral und central. Bevor die Verbindung aufgebaut wird broadcasted das Peripheral über @ble\-advertising, dass es eine Verbindung aufbauen möchte. Das Central-Gerät verbindet sich mit diesem. Die Übertragung funktioniert mit einem Server-CLient Modell. @ble sieht 6 Übertragungstypen vor (siehe @img-ueb): request, response, command, confirmation, notification und indication. Diese Formen sind für verschiedene Einsatzbereiche vorgesehen. Notifications sind Daten die vom Server zum Client gesendet werden und keine Antwort erwarten, diese Form ist praktisch bei einfachen nicht kritischen Übertragungen. Datenpakete können auch über @ble\-Advertising gesendet werden ohne sich zu verbinden. Kleine Datenmengen können so effizient und schnell gesendet werden. @bleSource \ 

#figure(
  image("../Bilder/blegatt.png", width: 60%),
  caption: [Übertragungsarten]
)<img-ueb>

#pagebreak()