#import "../config.typ": *

= Hardware //blockdiagramm einfügen 

? Der Controller ist Bateriebetrieben und besteht aus einem Mikrocontroller, einem Laderegler, einem ADC und einer Spannungsversorgung.

#figure(
image("../Bilder/DA BlockschaltbildCont.png", width: 100%),
caption: [Blockschaltbild des Systems],
)



== Spannungsversorgung
Die Energieversorgung des Controllers erfolgt über einen Lithium-Polymer-Akku (LiPo), dessen Betriebsspannung zwischen 3,7 V und 4,2 V liegt. Der Akku wird über Federkontakter an einer Ladestation aufgeladen, welche die erforderliche Spannung und Stromstärke liefert.  

Für den sicheren Betrieb des Akkus wurde ein Laderegler implementiert, welcher folgende Funktionalitäten übernimmt:

- Laderegelung:\ Sicherstellung eines geregelten Ladens des Akkus durch Überwachung von Spannung und Stromstärke während des Ladevorgangs. 

- Schutzschaltung:\ Verwendung eines Schutzschaltkreises zur verhinderung von Überladung und Tiefentladung. 

== Laderegler <sec-charger>

#figure(
image("../Bilder/laderegler.png", width: 100%),
caption: [Laderegler],
) \
- TP4056 Laderegler\ Die Laderegelung erfolgt über den TP4056. Der TP4056 (U1) verfügt über eine Schaltung, die zur idealen Spannungsreduzierung von 5 V auf die Betriebsspannung des Akkus führt.
Der Chip bietet eine angepasste Laderegelung, die den Akku schonend lädt. Er überwacht die Spannung und den Strom während des Ladevorgangs, um eine Überladung zu verhindern. Sobald der Akku vollständig geladen ist, schaltet der TP4056 automatisch in den Erhaltngsmodus.
Die dauer des ladevorgangs hängt zum Teil von dem an den Pin2 angeschlossenen Widerstand ab. Dieser legt den Ladestrom fest. In unserem fall wurde ein 1.2kOhm Widerstand verwendet um ein schnelles aufladen zu ermöglichen.

#figure(
image("../Bilder/Ladevorgang.png", width: 100%),
caption: [
Ladevorgang
],
) \ \

- DW01 Schutzschaltung\ Um das Tiefentladen und Überladen des Akkus zuz verhindern, wird der DW01 (U2) verwendet. Dieser Schutzschaltkreis überwacht den Stromfluss des Akkus und schaltet diesen ab, wenn die Spannung über einen speziellen Schwellenwert steigt beziehungsweise fällt. Das ist notwendig um den Akku langlebig zu halten und Schäden zu verhindern. \ \

- FS8205A MOSFETs\ Die genaue Stromflusssteuerung wird durch den DW01 in serie mit zwei FS8205A MOSFETs (Q1 und Q2) erreicht. Diese MOSFETs dienen als Schalter, die den Stromfluss zum Akku steuern. Wenn der DW01 eineÜberladung oder Tiefentladung erkennt, schaltet der FS8205A den Stromfluss ab, um den Akku zu schützen. \ \

- LDO Spannungsregler\ Nach dem Aufladen des Akkus wird der Controller über dessen Spannung versorgt. Um eine konstante Betriebsspannung von 3,3 V für die Komponenten zu gewährleisten, wird ein LDO Spannungsregler verwendet. Dieser reduziert die Spannung des Akkus auf die benötigten 3,3 V und sorgt für eine stabile Spannungsversorgung. \ \


== Mikrocontroller
Die steuerung des Systems erfolgt über den CH572D. Der Mikrocontroller ist für die Verarbeitung der Sensordaten und die Steuerung des Potis verantwortlich. Zu beachten ist, dass der CH572D keine integrierten ADC Pins hat, weshalb der CH32V003 als kosteneffizienter externer ADC verwendetwird.  
\ 
- Ch572D\ Der CH572D ist ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über eine hohe Rechenleistung und einen großen Speicher, was ihn ideal für die Verarbeitung von Sensordaten und die Steuerung von Aktoren macht. Der CH572D ist für die Hauptsteuerung des Systems verantwortlich und verarbeitung der Daten.
Aufgrund fehlender ADC Pins auf dem CH572D, wird der CH32V003 als externer ADC verwendet. \ 
 

- CH32V003\ Der CH32V003 ist ebenfalls ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über integrierte ADCs, die es möglich machen, die analogen Signale der Sensoren zu verarbeiten. Da er günsiger als ein externer ADC ist, wurde er als  kosteneffiziente Lösung ausgewählt. \ \

Bei der Entwicklung der Controller Platine wurde darauf geachtet, dass ein Quarz für eine stabile Taktfrequenz vorhanden ist. Da der interne RC-Oszillator des CH572 nicht ausreicht, wurde ein externer Quarz mit einer Frequenz von 12 MHz an die XO und XI Pins angeschlossen.  
\ \
== ADC
Die analogen Signale vom Potentiometer und vom Button werden über die ADC Pins von dem CH32V003 verarbeitet. Der Chip wandelt die analogen Signale in digitale Werte um, die dann vom Ch572D verarbeitet werden. Die Daten werden über die SPI Schnittstelle zwischen den Chips und dem Auto übertragen.
Bauteile die zum auslesen ADC brauchen: 
- Potentiometer
- Button
- Vibrationsmotor

\
== Steuerung
Die genannten Bauteile werden für die Steuerung des Autos verwendet. Sie ermöglichen es dem Spieler, die geschwindigkeit zu steuern, Spezialeffekte auszulösen und haptisches Feedback zu erhalten. 

- Potentiometer: Für die Drehzahlsteuerung wird ein Potentiometer verwendet, welches die analogen Signale an den CH32V003/ADC sendet. Die Werte werden dann zu digitale Signale umgewandelt, vom CH572D verarbeitet und an den Auto Chip gesendet.

- Button: Der Button dient als spezial Effekt. Wird dieser gedrückt, sendet er ein Signal über den ADC und dem Ch572D an das Auto, welches dann den Buzzer aktiviert und die Hupe auslöst.

- Vibrationsmotor: Der Vibrationsmotor wird für haptisches Feedback verwendet. Er wird über den CH572D gesteuert und aktiviert, wenn bestimmte Ereignisse im Spiel auftreten, wie z.B. bei Kollisionen oder das Erreichen einer bestimmten Geschwindigkeit.
\
== Antenne

Die Antenne ist auf 50 Ω angepasst, um eine optionale Verbindung über BLE zwischen dem Controller und dem Auto zu ermöglichen. Damit die Anpassung erhalten bleibt, wurde die Leiterbahn zwischen Antenne und dem CH572D entsprechend dimensioniert. Die Platine des Controllers ist relativ dünn, wodurch die benötigte Leiterbahnbreite für den 50 Ohm Wellenwiderstand dünner wird. \ 

Für eine möglichst geringe Störanfälligkeit wird die Leiterbahn zwischen Antenne und CH572D möglichst kurz gehalten. Längere Leiterbahnen erhöhen die parasitäre Induktivität und können bei der BLE-Kommunikation zu Signalverzerrungen führen. Zusätzlich wurden entlang der Leiterbahn mehrere Ground-Vias platziert, um einen stabilen Rückstrompfad zu gewährleisten und hochfrequente Störungen zu reduzieren.

#figure(
image("../Bilder/Cantenne.png", width: 50%),
caption: [
BLE Antennendesign
],
)

Um Störungen durch andere Signale auf der Platine zu vermeiden, sind keine unnötigen Bauteile in der Nähe der Antennen Leiterbahn platziert. Dadurch wird verhindert, dass hochfrequente Signale in benachbarte Leiterbahnen einkoppeln und die BLE-Kommunikation beeinflussen.\ \

Da Mikrocontroller kurzzeitig erhöhte Ströme aufnehmen können, entstehen Stromspitzen auf der Versorgungsspannung. Diese können zu kurzzeitigen Spannungsausfall führen. Aus diesem Grund wurde ein Stützkondensator in der Nähe des Mikrocontrollers platziert. Dieser fängt die Stromspitzen ab und sorgt für eine stabile Versorgung während der BLE-Kommunikation bei.\ \

#figure(
  image("../Bilder/ChipStrom.png", width: 100%),
  caption: [
    ohne Kondensator
  ]
)
In dieser 

#figure(
  image("../Bilder/ChipStromC.png", width: 100%),
  caption: [
    mit Kondensator
  ]
)

\

= Software

== App
#figure(
image("../Bilder/Appscreen.png", width: 50%),
caption: [
Startbildschirm
],)
Die App dient zum Einstellen vieler Parameter. Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen so wie die Verbindung zum Hauptmodul Display herzustellen. \
Es gibt verschiedene Modi, die unterschiedliche Schwierigkeitsgrade bieten. Je nach Modus variiert die Anzahl der Runden und die Schwierigkeit der Steuerung. Unter Schwierigkeit der Steuerung versteht man mit welcher Motorleistung die Autosfahren.
- Modis:
  #figure(
    image("../Bilder/Modis.png", width: 100%),

    caption: [
      Modi Definition
    ]
  )
  - DefaultLaps: Hier werden die Rundenanzahl standardisiert.
  - speedFactor: Hier wird die Motorleistung eingestellt. Zum Beispiel: 0.5f bedeutet, dass die Autos mit halber Leistung fahren.

\
Nach dem start des Rennens zeigt die App die dauer (mit einer Timer Methode) und den Runden fortschritt der Spieler. Nach dem beenden des Rennes werden die Spieler des aktuellen Rennens nach der Bestzeit sortiert und angezeigt. Danach hat man die wahl wieder zum Hauptmenü zu gelangen oder sich das gesamte Ranking aller Rennen anzusehen. Diese werden nach der Bestzeit am Tag, Woche Monat, Gesamt und nach schnellste Runde sortiert.\ \


== Hauptmodul Display
Das Display XX verfügt über einen Kapazitiven Touchscreen, welcher einfache Einstellungen über das Display ermöglicht.
- Modi (einstellbar)
- Spieler anzahl
- Start/Stop
- Leaderboard
- 
\ \
== TCP Protokoll

#figure(
  image("../Bilder/TCPApp.png", width: 100%),

  caption: [
    TCP Deklaration in 
  ]
)

Um eine Verbindung zwischen der App und dem Hauptmodul Display herzustellen, wird das Protokoll verwendet. Dieses ermöglicht eine Bidirektionale Kommunikation zwischen den beiden Geräten. Das dient dazu, dass Änderungen, wie das Einstellen der Modi oder Spielernamen, auf das Display übertragen werden können.


\ 
== Controler Display
Das Controller Display XY zeigt folgende funktionen an:
- aktuelle Motorleistung (PWM)
- Timer
- Durchschnittsgeschwindigkeit
- beste Rundendauer
- abweichung zur besten
- Spielername
- Zugewiesenes Auto
- Runden anzahl z.B.: 2/5 Runden // in dem fall leichter modus

Das Display dient dazu, wichtige Informationen während des Rennens anzuzeigen. Es zeigt die aktuelle Motorleistung an, die über die PWM gesteuert wird, sowie einen Timer, der die Dauer des Rennens anzeigt. In der mitte des Displays wird die Durchschnittsgescchwindigkeit angezeigt, welche mithilfe der Drehzahl des Motors berechnet wird. Darunter wird die schnellste Runde angezeigt, sowie die Abweichung. 
\
$ v = (n*π*d)/60 $

- v: Geschwindigkeit in m/s
- n: Drehzahl in U/min
- d: Durchmesser des Rades in m \ \
Der Spielername und das zugewiesene Auto werden ebenfalls auf dem Display angeziegt, um verwechslungen zu vermeiden. Zudem wird die aktuelle Rundenanzahl angezeigt, um den Spieler zu informieren, in welcher Runde er sich befindet.

