#import "../config.typ": *
#aktueller_autor.update([#author3, #klasse])

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
- Schieberegler

#figure(
image("/Bilder/Blockschaltbild-HW-Controller.svg", width: 70%),
caption: [Blockschaltbild Hardware Controller],
)


#pagebreak()
== Spannungsversorgung
Die Versorgung des Controllers erfolgt über einen @lipo, dessen Betriebsspannung zwischen 3.2 V und 4.2 V liegt. Der Akku wird über Federkontakte an einer Ladestation aufgeladen. (siehe @sec_ladestation-hw)
\ \
Die Spannungsregelung ist in drei Teile gegliedert:
- Laderegelung:\ Sicherstellung eines geregelten Ladens des Akkus durch Überwachung von Spannung und Stromstärke während des Ladevorgangs. 

- Schutzschaltung:\ Verwendung eines Schutzschaltkreises zur verhinderung von Überladung und Tiefentladung. 

- @ldo:both: \ Regelt von Variabler Akkuspannung (3.2-4.2V) auf 3.3V für die Versorgung der Mikrocontroller und anderer Komponenten.  Für die geringe Spannungsdifferenz zwischen Akku und Versorgungsspannung der Komponenten ist ein @ldo:long nötig. 
\ \

== Laderegler <sec-charger>

#figure(
fimage("/Bilder/Laderegler.png", width: 100%),
caption: [Laderegler],
) 

- TP4056 Laderegler\ Die Laderegelung erfolgt über den TP4056. Der TP4056 (U1) , die zur Spannungsreduzierung von 5V Eingangsspannung auf die Betriebsspannung des Akkus führt. 
Der Chip bietet eine angepasste Laderegelung, die den Akku schonend lädt. Er überwacht die Spannung und den Strom während des Ladevorgangs, um eine Überladung zu verhindern. Sobald der Akku vollständig geladen ist, schaltet der TP4056 automatisch in den Erhaltungsmodus.

Um einen Ladestrom von 1A einzustellen, wird ein 1.2kΩ Widerstand an PIN2 des TP4056 angeschlossen. @sourceLipo

\
#figure(
fimage("/Bilder/Ladevorgang.png", width: 100%),
caption: [Ladevorgang],
) \ \

Das Aufnehmen der Ladekurve werden Strom und Spannung des Akkus gemessen. Mit einem Spannungsteiler an einem Pin wird die Ladespannung gemessen, der Ladestrom wird auf dem anderen Pin über einen Shunt-Widerstand gemessen.\ \

#figure(
fimage("/Bilder/LadekSch.png", width: 100%),
caption: [Schaltplan für die Ladekurve aufnehmen],
)
\ 
!!! Schaltung und messvorgang beschreiben
Der Spannungsverlauf beim Laden wird über den Spannungsteiler gemessen. 




Der ladestrom wird über den Shuntwiderstand gemessen. Durch den Spannungsabfall am Shunt, kann der Ladestrom berechnet werden. $U=I*R$
Auf grund einer niedrigen Spannung am Shunt, wird ein OPV als Verstärker verwendet, da der ESP eine Spannung von 0.1V nicht richtig messen kann. Der OPV verstärkt die Spannung am Shunt um den Faktor 19, damit der ESP die Spannung messen kann.

\ \

- DW01 Schutzschaltung\ Um das Tiefentladen und Überladen des Akkus zu verhindern, wird der DW01 (U2) verwendet. Dieser Schutzschaltkreis überwacht den Stromfluss des Akkus und schaltet diesen ab, wenn die Spannung über einen speziellen Schwellenwert() steigt beziehungsweise fällt. Das ist notwenig um den Akku nicht zu zerstörren. Mit dem FS8205A MOSFETs (Q1 und Q2) wird der Stromfluss bei bedarf unterbrochen. \ \




Der Schaltplan des Ladereglers musste überarbeitet werden, da ein Verbindungsfehler zwischen dem Akku und dem FS8205A an dem Pin G2 vorlag. Dieser Fehler führte dazu, dass die Schutzschaltung für den Akku, den Akku nicht schützt. Der Fehler ist behoben worden, indem die Leiterbahn zwischen Akku und den Mosfets vom GND getrennt und im Schaltplan geändert wurde.  
\ \


== Mikrocontroller
Die Steuerung des Systems erfolgt über den CH572. Der Mikrocontroller verarbeitet die Daten und sendet sie über  @ble an das Fahrzeug. Zu beachten ist, dass der CH572 keine integrierten @adc hat, weshalb der CH32V003 als kosteneffizienter externer @adc verwendet wird.  
\ \
- CH572\ Der CH572 ist ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er ist klein, verfügt über integrietes @ble. Der CH572 ist für die Hauptsteuerung des Systems verantwortlich und verarbeitet die Daten.
\ \
- CH32V003\ Er verfügt über integrierten @adc, die es möglich machen, die analogen Signale der Sensoren zu verarbeiten. Da er günsiger als ein externer @adc ist, wurde er als  kosteneffiziente Lösung ausgewählt. \ \

Bei der Entwicklung der Controller Platine wurde darauf geachtet, dass ein Quarz für eine stabile Taktfrequenz, die für @ble notwenig ist, vorhanden ist. Da der interne RC-Oszillator des CH572 nicht ausreicht, ist ein externer Quarz mit einer Frequenz von 32 MHz an die Pins XO und XI angeschlossen.  
\ \
== @adc:both
Die analogen Signale vom Potentiometer und vom Schieberegler werden über den @adc von dem CH32V003 eingelesen. Der Chip wandelt die analogen Signale in digitale Werte um, sie werden über UART an den Ch572 gesendet. 
Bauteile die zum auslesen @adc brauchen: 
- Potentiometer
- Schieberegler

\
== Steuerung
Die genannten Bauteile werden für die Steuerung des Autos verwendet. Sie ermöglichen es dem Spieler, die Geschwindigkeit zu steuern, Spezialeffekte auszulösen und haptisches Feedback zu erhalten. 

- Potentiometer: An dem Potentiometer wird die Geschwindigkeit des Autos eingestellt. Das Potentiometer sendet ein analoges Signal an den @adc, welcher es dann in digitale werte umwandelt und an den Ch572 sendet. Der Mikrokontroller verarbeitet die Daten und sendet die Befehle über @ble an das Auto.

- Schieberegler: Der Schieberegler dient als Spezialeffekt. Wird dieser betätigt, sendet er ein Signal über den @adc und dem CH572 an das Auto, welches dann den Buzzer aktiviert und die Hupe auslöst.

- Vibrationsmotor: Der Vibrationsmotor wird für haptisches Feedback verwendet. Er wird über den CH572 gesteuert und aktiviert, wenn bestimmte Ereignisse im Spiel auftreten, wie z.B. bei Kollisionen oder das Erreichen einer bestimmten Geschwindigkeit.
\
== Antenne

Die Antenne ist auf 50 Ω angepasst, um eine optionale Verbindung über @ble zwischen dem Controller und dem Auto zu ermöglichen. Damit die Anpassung erhalten bleibt, wurde die Leiterbahn zwischen Antenne und dem CH572 entsprechend dimensioniert. Die Platine des Controllers ist relativ dünn, wodurch die benötigte Leiterbahnbreite für den 50 Ohm Wellenwiderstand dünner wird. \ 

Für eine möglichst geringe Störanfälligkeit wird die Leiterbahn zwischen Antenne und CH572 möglichst kurz gehalten. Längere Leiterbahnen erhöhen die parasitäre Induktivität und können bei der @ble Kommunikation zu Signalverzerrungen führen. Zusätzlich wurden entlang der Leiterbahn mehrere Ground-Vias platziert, um einen stabilen Rückstrompfad zu gewährleisten und hochfrequente Störungen zu reduzieren.

#figure(
fimage("/Bilder/Cantenne.png", width: 50%),
caption: [@ble Antennendesign],
)
\
#figure(
fimage("/Bilder/AntBode.png", width: 100%),
caption: [Bodediagramm der Antenne],
)
\
In dem angegebenen Bodediagramm ist der Reflexionsfaktor S11 aufgetragen. Zu erkennen ist, dass die Antenne im Bereich von 2.34GHz die beste Dämpfung hat. Da @ble im 2.4GHz Bereich arbeitet, ist die Antenne nicht ideal. Dennoch ist sie mit einer Dämpfung von -15dB ausreichend für die Kommunikation.
//Dämpfung?

#figure(
fimage("/Bilder/AntStrom.png", width: 100%),
caption: [Stromverteilung der Antenne],
)
//In diesem Diagramm ist die Stromverteilung auf der Antenne dargestellt. Es ist zu erkennen, dass die Stromdichte entlang der Leiterbahn variiert, mit einem Maximum in der Nähe des Speisepunkts. Dies ist typisch für eine Antenne und zeigt, dass die Energie effizient in den Raum abgestrahlt wird.


\ \
Um Störungen durch andere Signale auf der Platine zu vermeiden, sind keine Bauteile in der Nähe der Antenne und Leiterbahn platziert. 
Dadurch wird verhindert, dass hochfrequente Signale in benachbarte Leiterbahnen einkoppeln und die @ble -Kommunikation beeinflussen.@antennaSource\ \ 

Da Mikrocontroller kurzzeitig erhöhte Ströme aufnehmen können, entstehen Stromspitzen auf der Versorgungsspannung. Diese können zu kurzzeitigen Spannungsausfall führen. Aus diesem Grund wurde ein Stützkondensator in der Nähe des Mikrocontrollers platziert. Dieser fängt die Stromspitzen ab und sorgt für eine stabile Versorgung während der @ble -Kommunikation bei.\ \

#figure(
  fimage("/Bilder/ChipStrom.png", width: 100%),
  caption: [ohne Kondensator]
)\
In dieser Abbildung sieht man den Strom- und Spannungsverlauf eines Mikrocontrollers ohne Stützkondensator. Es ist deutlich zu erkennen, dass die Spannung während der Stromspitzen kurzzeitig abfällt.
\ \
#figure(
  fimage("/Bilder/ChipStromC.png", width: 100%),
  caption: [mit Kondensator]
)\
In dieser Abbildung sieht man den Strom- und Spannungsverlauf eines Mikrocontrollers mit einem Stützkondensator. Es ist deutlich zu erkennen, dass die Spannung stabil bleibt, auch während der Stromspitzen.

#pagebreak()



