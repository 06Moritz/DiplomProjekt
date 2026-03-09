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
Der widerstand am Laderegler (R) wurde so gewählt, dass der Ladestrom auf 500mA begrenzt ist, um die Lebensdauer des Akkus zu maximieren und eine sichere Ladung zu gewährleisten. Der LDO Spannungsregler wurde aufgrund seiner hohen Effizienz und geringen Wärmeentwicklung ausgewählt, was besonders wichtig ist, da der Controller Akku betrieben ist. Zudem wurde ein Schutz-IC integriert, um den Akku vor Überladung und Tiefentladung zu schützen, was die Sicherheit und Zuverlässigkeit des Systems erhöht.\ \

== Hauptcontroller

Der Mikrocontroller U5 übernimmt die zentrale Steuerungsfunktion des Controllersystems. Er verarbeitet eingehende Signale vom Fahrzeug sowie von angeschlossenen Sensoren und führt auf Basis dieser Daten die Steuerung der Aktoren aus. Zusätzlich koordiniert er die Kommunikation zwischen den einzelnen Systemkomponenten.\ \

Beim eingesetzten Mikrocontroller handelt es sich um den CH572D. Dieser ist ein leistungsfähiger Mikrocontroller mit einer Vielzahl von Peripherie- und Kommunikationsschnittstellen, die für die Anforderungen des Projekts geeignet sind.
- 32-Bit RISC-V Architektur
- Taktfrequenz: bis zu 120 MHz
- Kommunikationsschnittstellen: UART, SPI, I2C, USB 
Diese Schnittstellen ermöglichen den Datenaustausch mit externen Modulen, Sensoren sowie weiteren Mikrocontrollern innerhalb des Systems.

Für die Verarbeitung analoger Sensorsignale ist ein Analog-Digital-Wandler (ADC) erforderlich. Da der CH572D keine integrierten ADC-Eingänge bereitstellt, wurde ein zusätzlicher Mikrocontroller zur Erfassung analoger Messwerte in das System integriert. Hierfür wird der CH32V003DSO (U6) eingesetzt.

Der Mikrocontroller U6 übernimmt die Digitalisierung der analogen Sensorsignale über seine integrierten ADC-Kanäle. Die erfassten Messwerte werden anschließend digital verarbeitet und über eine Kommunikationsschnittstelle an den Hauptmikrocontroller U5 übertragen. Der CH572D nutzt diese Daten zur weiteren Signalverarbeitung und zur Steuerung des Systems.

Durch diese Aufteilung der Funktionen wird die Verarbeitung analoger und digitaler Signale getrennt realisiert, wobei der Hauptmikrocontroller die zentrale Steuerung des Systems übernimmt und der zusätzliche Mikrocontroller die Datenerfassung der analogen Sensoren durchführt.



