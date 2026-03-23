#import "../config.typ": *

= Hardware //blockdiagramm einfügen 



Der Controller ist für die Steuerung des Autos verantwortlich. Er empfängt die Signale von den Sensoren, verarbeitet sie und sendet die entsprechenden Befehle an das Auto. Die Energieversorgung des Controllers erfolgt über einen Lithium-Polymer-Akku, welcher über eine Ladestation aufgeladen wird. 
Der Controller besteht aus folgenden Komponenten:
- Mikrocontroller
- Laderegler
- Akku
- @adc
- Potentiometer
- Vibrationsmotor
- Button

#figure(
image("../Bilder/Blockschaltbild-HW-Controller.svg", width: 70%),
caption: [Blockschaltbild Hardware Controller],
)


#pagebreak()
== Spannungsversorgung
Die Versorgung des Controllers erfolgt über einen @lipo, dessen Betriebsspannung zwischen 3,2 V und 4,2 V liegt. Der Akku wird über Federkontakter an einer Ladestation aufgeladen, welche die erforderliche Spannung und Stromstärke liefert.  

Für den sicheren Betrieb des Akkus wurde ein Laderegler implementiert, welcher folgende Funktionalitäten übernimmt:

- Laderegelung:\ Sicherstellung eines geregelten Ladens des Akkus durch Überwachung von Spannung und Stromstärke während des Ladevorgangs. 

- Schutzschaltung:\ Verwendung eines Schutzschaltkreises zur verhinderung von Überladung und Tiefentladung. 

== Laderegler <sec-charger>

#figure(
image("../Bilder/Laderegler.png", width: 100%),
caption: [Laderegler],
) \
- TP4056 Laderegler\ Die Laderegelung erfolgt über den TP4056. Der TP4056 (U1) verfügt über eine Schaltung, die zur idealen Spannungsreduzierung von 5 V auf die Betriebsspannung des Akkus führt.
Der Chip bietet eine angepasste Laderegelung, die den Akku schonend lädt. Er überwacht die Spannung und den Strom während des Ladevorgangs, um eine Überladung zu verhindern. Sobald der Akku vollständig geladen ist, schaltet der TP4056 automatisch in den Erhaltngsmodus.
Die dauer des ladevorgangs hängt zum Teil von dem an den Pin2 angeschlossenen Widerstand ab. Dieser legt den Ladestrom fest. In unserem fall wurde ein 1.2kOhm Widerstand verwendet um ein schnelles aufladen zu ermöglichen.

#figure(
image("../Bilder/Ladevorgang.png", width: 100%),
caption: [Ladevorgang],
) \ \

Das Aufnehmen der Ladekurve erfolgt über zwei ADC Pins des ESP32. Diese messen die Spannung und den Ladestrom des Akkus. Mit einem Spannungsteiler an einem Pin wird die Ladespannung gemessen, der Ladestrom wird auf dem anderen Pin über einen Shunt-Widerstand gemessen.\ \

Ein Shunt-Widerstand ist ein niederohmiger Widerstand, der zwischen GND und dem GND des Akkus platziert wird. Durch die Messung der Spannung über diesen Widerstand kann der Ladestrom berechnet werden, da der Strom durch den Widerstand proportional zur Spannung ist. \ \

- DW01 Schutzschaltung\ Um das Tiefentladen und Überladen des Akkus zu verhindern, wird der DW01 (U2) verwendet. Dieser Schutzschaltkreis überwacht den Stromfluss des Akkus und schaltet diesen ab, wenn die Spannung über einen speziellen Schwellenwert steigt beziehungsweise fällt. Das ist notwendig um den Akku langlebig zu halten und Schäden zu verhindern. \ \

- FS8205A MOSFETs\ Die genaue Stromflusssteuerung wird durch den DW01 in serie mit zwei FS8205A MOSFETs (Q1 und Q2) erreicht. Diese MOSFETs dienen als Schalter, die den Stromfluss zum Akku steuern. Wenn der DW01 eineÜberladung oder Tiefentladung erkennt, schaltet der FS8205A den Stromfluss ab, um den Akku zu schützen. \ \
\ 
- LDO Spannungsregler\ Nach dem Aufladen des Akkus wird der Controller über dessen Spannung versorgt. Um eine konstante Betriebsspannung von 3,3 V für die Komponenten zu gewährleisten, wird ein LDO Spannungsregler verwendet. Dieser reduziert die Spannung des Akkus auf die benötigten 3,3 V und sorgt für eine stabile Spannungsversorgung. \ \
Der Schaltplan des Ladereglers musste überarbeitet werden, da ein Verbindungsfehler zwischen dem Akku und dem FS8205A an dem Pin G2 vorlag. Dieser Fehler führte dazu, dass die Schutzschaltung für den Akku, den Akku nicht schützt. Der Fehler ist behoben worden, indem die Leiterbahn zwischen Akku und den Mosfets vom GND getrennt und im Schaltplan geändert wurde.  
\ \


== Mikrocontroller
Die steuerung des Systems erfolgt über den CH572D. Der Mikrocontroller ist für die Verarbeitung der Sensordaten und die Steuerung des Potis verantwortlich. Zu beachten ist, dass der CH572D keine integrierten @adc Pins hat, weshalb der CH32V003 als kosteneffizienter externer @adc verwendetwird.  
\ \
- Ch572D\ Der CH572D ist ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über eine hohe Rechenleistung und einen großen Speicher, was ihn ideal für die Verarbeitung von Sensordaten und die Steuerung von Aktoren macht. Der CH572D ist für die Hauptsteuerung des Systems verantwortlich und verarbeitung der Daten.
\
Aufgrund fehlender @adc Pins auf dem CH572D, wird der CH32V003 als externer @adc verwendet. \ \
 
\
- CH32V003\ Der CH32V003 ist ebenfalls ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über integrierte @adc, die es möglich machen, die analogen Signale der Sensoren zu verarbeiten. Da er günsiger als ein externer @adc ist, wurde er als  kosteneffiziente Lösung ausgewählt. \ \

Bei der Entwicklung der Controller Platine wurde darauf geachtet, dass ein Quarz für eine stabile Taktfrequenz vorhanden ist. Da der interne RC-Oszillator des CH572 nicht ausreicht, wurde ein externer Quarz mit einer Frequenz von 12 MHz an die XO und XI Pins angeschlossen.  
\ \
== @adc:both
Die analogen Signale vom Potentiometer und vom Button werden über die @adc Pins von dem CH32V003 verarbeitet. Der Chip wandelt die analogen Signale in digitale Werte um, die dann vom Ch572D verarbeitet werden. Die Daten werden über die SPI Schnittstelle zwischen den Chips und dem Auto übertragen.
Bauteile die zum auslesen @adc brauchen: 
- Potentiometer
- Button
- Vibrationsmotor

\
== Steuerung
Die genannten Bauteile werden für die Steuerung des Autos verwendet. Sie ermöglichen es dem Spieler, die geschwindigkeit zu steuern, Spezialeffekte auszulösen und haptisches Feedback zu erhalten. 

- Potentiometer: Für die Drehzahlsteuerung wird ein Potentiometer verwendet, welches die analogen Signale an den CH32V003/@adc sendet. Die Werte werden dann zu digitale Signale umgewandelt, vom CH572D verarbeitet und an den Auto Chip gesendet.

- Button: Der Button dient als spezial Effekt. Wird dieser gedrückt, sendet er ein Signal über den @adc und dem Ch572D an das Auto, welches dann den Buzzer aktiviert und die Hupe auslöst.

- Vibrationsmotor: Der Vibrationsmotor wird für haptisches Feedback verwendet. Er wird über den CH572D gesteuert und aktiviert, wenn bestimmte Ereignisse im Spiel auftreten, wie z.B. bei Kollisionen oder das Erreichen einer bestimmten Geschwindigkeit.
\
== Antenne

Die Antenne ist auf 50 Ω angepasst, um eine optionale Verbindung über @ble zwischen dem Controller und dem Auto zu ermöglichen. Damit die Anpassung erhalten bleibt, wurde die Leiterbahn zwischen Antenne und dem CH572D entsprechend dimensioniert. Die Platine des Controllers ist relativ dünn, wodurch die benötigte Leiterbahnbreite für den 50 Ohm Wellenwiderstand dünner wird. \ 

Für eine möglichst geringe Störanfälligkeit wird die Leiterbahn zwischen Antenne und CH572D möglichst kurz gehalten. Längere Leiterbahnen erhöhen die parasitäre Induktivität und können bei der @ble -Kommunikation zu Signalverzerrungen führen. Zusätzlich wurden entlang der Leiterbahn mehrere Ground-Vias platziert, um einen stabilen Rückstrompfad zu gewährleisten und hochfrequente Störungen zu reduzieren.

#figure(
image("../Bilder/Cantenne.png", width: 50%),
caption: [@ble Antennendesign],
)
\ \
Um Störungen durch andere Signale auf der Platine zu vermeiden, sind keine unnötigen Bauteile in der Nähe der Antennen Leiterbahn platziert. Dadurch wird verhindert, dass hochfrequente Signale in benachbarte Leiterbahnen einkoppeln und die @ble -Kommunikation beeinflussen.\ \

Da Mikrocontroller kurzzeitig erhöhte Ströme aufnehmen können, entstehen Stromspitzen auf der Versorgungsspannung. Diese können zu kurzzeitigen Spannungsausfall führen. Aus diesem Grund wurde ein Stützkondensator in der Nähe des Mikrocontrollers platziert. Dieser fängt die Stromspitzen ab und sorgt für eine stabile Versorgung während der @ble -Kommunikation bei.\ \

#figure(
  image("../Bilder/ChipStrom.png", width: 100%),
  caption: [ohne Kondensator]
)\
In dieser Abbildung sieht man den Strom- und Spannungsverlauf eines Mikrocontrollers ohne Stützkondensator. Es ist deutlich zu erkennen, dass die Spannung während der Stromspitzen kurzzeitig abfällt.
\ \
#figure(
  image("../Bilder/ChipStromC.png", width: 100%),
  caption: [mit Kondensator]
)\
In dieser Abbildung sieht man den Strom- und Spannungsverlauf eines Mikrocontrollers mit einem Stützkondensator. Es ist deutlich zu erkennen, dass die Spannung stabil bleibt, auch während der Stromspitzen.

\ \ \ \ \ \ \ \ \ \ \ \ \ \ \



