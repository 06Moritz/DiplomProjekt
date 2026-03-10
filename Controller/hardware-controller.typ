#import "../config.typ"

= Hardware //blockdiagramm einfügen 

? Der Controller ist Bateriebetrieben und besteht aus einem Mikrocontroller, einem Laderegler, einem ADC und einer Spannungsversorgung.

#figure(
image("../Bilder/DA BlockschaltbildCont.png", width: 100%),
caption: [Blockschaltbild des Systems],
)


== Spannungsversorgung
Die Energieversorgung des Controllers erfolgt über einen Lithium-Polymer-Akku (LiPo), dessen Betriebsspannung zwischen 3,7 V und 4,2 V liegt. Der Akku wird über Federkontakter an einer Ladestation aufgeladen, welche die erforderliche Spannung und Stromstärke liefert.  

Für den sicheren Betrieb des Akkus wurde ein Laderegler implementiert, welcher folgende Funktionalitäten übernimmt:

- Laderegelung: \
Sicherstellung eines geregelten Ladens des Akkus durch Überwachung von Spannung und Stromstärke während des Ladevorgangs. @sec-charger

- Schutzschaltung: 
Verwendung eines Schutzschaltkreises zur verhinderung von Überladung und Tiefentladung. @sec-charger

== Laderegler <sec-charger>

#figure(
image("../Bilder/laderegler.png", width: 100%),
caption: [Laderegler],
) \
- TP4056 Laderegler 
Die Laderegelung erfolgt über den TP4056. Der TP4056 (U1) verfügt über eine integrierte Schaltung, die zur idealen Spannungsreduzierung auf 5 V auf die Betriebsspannung des Akkus führt.
Der Chip bietet eine angepasste Laderegelung, die den Akku schonend lädt. Er überwacht die Spannung und den Strom während des Ladevorgangs, um eine Überladung zu verhindern. Sobald der Akku vollständig geladen ist, schaltet der TP4056 automatisch in den Erhaltngsmodus.
Die dauer des ladevorgangs hängt zum Teil von dem an den Pin2 angeschlossenen Widerstand ab. Dieser legt den Ladestrom fest. In unserem fall wurde ein 1.2kOhm Widerstand verwendet um ein schnelles aufladen zu ermöglichen.\ \

- DW01 Schutzschaltung
Um das Tiefentladen und Überladen des Akkus zuz verhindern, wird der DW01 (U2) verwendet. Dieser Schutzschaltkreis ist zu ständig für die Überwachung des Akkus und Schaltet den Stromflussab, wenn die Spannung über einen Speziellen Schwellenwert steigt beziehungsweise fällt. Das ist notwendig um den Akku langlebig zu halten und Schäden zu verhindern. \ \

- FS8205A MOSFETs
Die genaue Stromfluss steuerung wird durch den DW01 in serie mit zwei FS8205A MOSFETs (Q1 und Q2) erreicht. Diese MOSFETs dienen als Schalter, die den Stromfluss zum Akku steuern. Wenn der DW01 eineÜberladung oder Tiefentladung erkennt, schaltet der FS8205A den Stromfluss ab, um den Akku zu schützen. \ \

- LDO Spannungsregler
Nach dem aufladen des Akkus wird der Controller über dessen Spannung versorgt. Um eine konstante Betriebsspannung von 3,3 V für die Komponenten zu gewährleisten, wird ein LDO Spannungsregler verwendet. Dieser reduziert die Spannung des Akkus auf die benötigten 3,3 V und sorgt für eine stabile Strom und Spannungsversorgung. \ \

== Mikrocontroller
Die steuerung des Systems erfolgt über den CH572D und den Ch32V003. Beide Mikrocontroller sind für die Verarbeitung der Sensordaten und die Steuerung des Potis verantwortlich.
- Ch572D
Der CH572D ist ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über eine hohe Rechenleistung und einen großen Speicher, was ihn ideal für die Verarbeitung von Sensordaten und die Steuerung von Aktoren macht. Der CH572D ist für die Hauptsteuerung des Systems verantwortlich und verarbeitung der Daten.
Aufgrund fehlender ADC Pins auf dem CH572D, wird der CH32V003 als externer ADC verwendet. \ \
- CH32V003
Der CH32V003 ist ebenfalls ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über integrierte ADCs, die es möglich machen, die analogen Signale der Sensoren zu verarbeiten. Da er günsiger als ein externer ADC ist, wurde er als  kosteneffiziente Lösung ausgewählt.

== ADC
signal von poti an chips und umgekehrt


== Steuerung
Potentiometer: geschwindigkeit steuerung
Vibrationsmotor: für hatisches feedback
Display: geschwindigkeit, name, auto,... anzeige
Joaystick: hupe auslösen



== Antenne
auf 50Ohm angepasst, platine extra dünn um leiterbahn zum CH572D dünner halten zu können.







