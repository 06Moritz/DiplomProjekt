#import "../config.typ"

= Hardware //blockdiagramm einfügen 

? Der Controller ist Bateriebetrieben und besteht aus einem Mikrocontroller, einem Laderegler, einem ADC und einer Spannungsversorgung.

#figure(
image("../Bilder/DA BlockschaltbildCont.png", width: 100%),
caption: [Blockschaltbild des Systems],
)


== Spannungsversorgung
Der Controller wird mit einem Lipo Akku betrieben, der eine Spannung von 3,7V liefert. Der Laderegler sorgt dafür, dass der Akku sicher geladen wird und schützt vor Überladung und Tiefentladung.  @sec-charger

== Laderegler <sec-charger>

#figure(
image("../Bilder/laderegler.png", width: 100%),
caption: [Laderegler],
)\ Ausbesserungsbedarf:

Als Laderegeler wird der TP4056 verwendet, der speziell für das Laden von Lithium-Ionen-Akkus entwickelt wurde. Er bietet eine konstante Strom- und Spannungsregelung, um den Akku sicher und effizient zu laden.\ \

TP4056 Laderegler:
Der TP4056 (U1) bildet die primäre Ladestufe und operiert als linearer Laderegler nach dem Constant-Current/Constant-Voltage-Verfahren (CC/CV). Die Steuerung des Ladestroms erfolgt über den Programmierwiderstand R3, welcher die Stromamplitude während der Konstantstromphase definiert. Parallel dazu dient die Peripherie um U1 der thermischen Überwachung und der Statussignalisierung des Ladevorgangs.\ 
- Konstantstrom- und Konstantspannungsregelung
- Überladungsschutz
- Tiefentladungsschutz
konstante Stromregelung: Der Ladestrom wird durch den externen Widerstand R3 eingestellt, der zwischen dem PROG-Pin und GND angeschlossen ist. \ 
Der TP4056 (U1) bildet die primäre Ladestufe und operiert als linearer Laderegler nach dem Constant-Current/Constant-Voltage-Verfahren (CC/CV). Die Steuerung des Ladestroms erfolgt über den Programmierwiderstand R3, welcher die Stromamplitude während der Konstantstromphase definiert. Parallel dazu dient die Peripherie um U1 der thermischen Überwachung und der Statussignalisierung des Ladevorgangs.\ \

DW01 Schutz-IC:\
Die nachgeschaltete Schutz-IC besteht aus der Kombination des Überwachungs-ICs DW01 (U2) und des Dual-MOSFETs FS8205A (U3). Diese Baugruppe fungiert als bidirektionale Trenneinheit. Der DW01 evaluiert kontinuierlich das Potenzial an Pin 5 (VCC) gegen Masse, um bei Unterschreitung der Entladeschlussspannung oder Überschreitung der Ladespannung den FS8205A anzusteuern. Dieser unterbricht den Laststromkreis auf der Low-Side (GND-Pfad), wodurch die chemische Integrität der Zelle bei Fehlzuständen oder Kurzschlüssen gewahrt bleibt.\ \

LDO Spannungsregler:
Der LDO Spannungsregler (U4) sorgt dafür, dass die Ausgangsspannung konstant bei 3,3V bleibt, auch wenn die Eingangsspannung zwischen 3,7V und 4,2V variiert. Er bietet eine hohe Effizienz und geringe Wärmeentwicklung, was besonders wichtig ist, da der Controller Akku betrieben ist.
- Eingangsspannung: 3,7V
- Ausgangsspannung: 3,3V
- Maximaler Ausgangsstrom: 500mA

\ \ Berücksichtigt:\
In der Entwicklung des Laderegler- und Spannungsversorgungssystems wurden folgende Aspekte berücksichtigt:
Der widerstand am Laderegler (R) wurde so gewählt, dass der Ladestrom auf 500mA begrenzt ist, um die Lebensdauer des Akkus zu maximieren und eine sichere Ladung zu gewährleisten. Der LDO Spannungsregler wurde aufgrund seiner hohen Effizienz und geringen Wärmeentwicklung ausgewählt, was besonders wichtig ist, da der Controller Akku betrieben ist. Zudem wurde ein Schutz-IC integriert, um den Akku vor Überladung und Tiefentladung zu schützen, was die Sicherheit und Zuverlässigkeit des Systems erhöht.




