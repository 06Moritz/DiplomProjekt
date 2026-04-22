#import "../config.typ":*

#aktueller_autor.update([#author2, #klasse])

= Software

#import "../config.typ":*

#aktueller_autor.update([#author2, #klasse])


== Controller Display
Der CH572 wird in C programmiert. Auf dem Display werden Renndaten wie Rundenzeit und Spielername angezeigt (siehe @sec-controllerui). Das Display wird direkt über @spi\-Befehle angesprochen.

== Bluetooth Low Energy (BLE) <sec_controller-ble>
Die Basis der Implementierung bildet der @ble Beispielcode von WCH. Dieser Code stellt die notwendigen Low-Level-Funktionen für den Bluetooth-Stack und das @tmos zur Verfügung.
Das Auto ist als Peripheral-Device konfiguriert. Es advertised und wartet bis das Auto sich damit verbindet.
Der Controller sendet periodisch die aktuellen Analogwerte die er vom @adc über @uart einliest. Die Daten werden als notify gesendet da keine Antwort notwendig ist.

#figure(
  image("/Bilder/flowchart-controllerble.png", width: 80%),
  caption: [Blockschaltbild BLE Kommunikation Controller]
)


== Analog-Digital-Wandler (ADC)
Potentiometer, Schieberegler und Akkuspannung werden mit dem CH32v003 gemessen. Die Messwerte werden in periodischen Abständen über @uart an den Hauptcontroller CH572 gesendet.
Die Analogwerte werden verarbeitet oder über @ble gesendet. Die Akkuspannung wird gemessen um den Ladestand des Akkus zu berechnen und anzuzeigen. Der Ladestand wird aus einer @lut:long abgelesen.




