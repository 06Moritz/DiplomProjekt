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

- Laderegelung: \
Sicherstellung eines geregelten Ladens des Akkus durch Überwachung von Spannung und Stromstärke während des Ladevorgangs. 

- Schutzschaltung: 
Verwendung eines Schutzschaltkreises zur verhinderung von Überladung und Tiefentladung. 

== Laderegler <sec-charger>

#figure(
image("../Bilder/laderegler.png", width: 100%),
caption: [Laderegler],
) \
- TP4056 Laderegler 
Die Laderegelung erfolgt über den TP4056. Der TP4056 (U1) verfügt über eine Schaltung, die zur idealen Spannungsreduzierung von 5 V auf die Betriebsspannung des Akkus führt.
Der Chip bietet eine angepasste Laderegelung, die den Akku schonend lädt. Er überwacht die Spannung und den Strom während des Ladevorgangs, um eine Überladung zu verhindern. Sobald der Akku vollständig geladen ist, schaltet der TP4056 automatisch in den Erhaltngsmodus.
Die dauer des ladevorgangs hängt zum Teil von dem an den Pin2 angeschlossenen Widerstand ab. Dieser legt den Ladestrom fest. In unserem fall wurde ein 1.2kOhm Widerstand verwendet um ein schnelles aufladen zu ermöglichen.

#figure(
image("../Bilder/Ladevorgang.png", width: 100%),
caption: [
Ladevorgang
],
) \ \

- DW01 Schutzschaltung
Um das Tiefentladen und Überladen des Akkus zuz verhindern, wird der DW01 (U2) verwendet. Dieser Schutzschaltkreis überwacht den Stromfluss des Akkus und schaltet diesen ab, wenn die Spannung über einen speziellen Schwellenwert steigt beziehungsweise fällt. Das ist notwendig um den Akku langlebig zu halten und Schäden zu verhindern. \ \

- FS8205A MOSFETs
Die genaue Stromflusssteuerung wird durch den DW01 in serie mit zwei FS8205A MOSFETs (Q1 und Q2) erreicht. Diese MOSFETs dienen als Schalter, die den Stromfluss zum Akku steuern. Wenn der DW01 eineÜberladung oder Tiefentladung erkennt, schaltet der FS8205A den Stromfluss ab, um den Akku zu schützen. \ \

- LDO Spannungsregler
Nach dem Aufladen des Akkus wird der Controller über dessen Spannung versorgt. Um eine konstante Betriebsspannung von 3,3 V für die Komponenten zu gewährleisten, wird ein LDO Spannungsregler verwendet. Dieser reduziert die Spannung des Akkus auf die benötigten 3,3 V und sorgt für eine stabile Spannungsversorgung. \ \


== Mikrocontroller
Die steuerung des Systems erfolgt über den CH572D. Der Mikrocontroller ist für die Verarbeitung der Sensordaten und die Steuerung des Potis verantwortlich.
- Ch572D
Der CH572D ist ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über eine hohe Rechenleistung und einen großen Speicher, was ihn ideal für die Verarbeitung von Sensordaten und die Steuerung von Aktoren macht. Der CH572D ist für die Hauptsteuerung des Systems verantwortlich und verarbeitung der Daten.
Aufgrund fehlender ADC Pins auf dem CH572D, wird der CH32V003 als externer ADC verwendet. \ \
- CH32V003
Der CH32V003 ist ebenfalls ein 32-Bit-Mikrocontroller, der auf der RISC-V-Architektur basiert. Er verfügt über integrierte ADCs, die es möglich machen, die analogen Signale der Sensoren zu verarbeiten. Da er günsiger als ein externer ADC ist, wurde er als  kosteneffiziente Lösung ausgewählt.

== ADC
signal von poti an chips und umgekehrtig.
Die analogen Signale vom Potentiometer und vom Button werden über die ADC Pins von dem CH32V003 verarbeitet. Der Chip wandelt die analogen Signale in digitale Werte um, die dann com Ch572D verarbeitet werden. Die Daten werden über die SPI Schnittstelle zwischen den Chips und dem Auto übertragen.

- Potentiometer: Für die Drehzahlsteuerung wird ein Potentiometer verwendet, welches die analogen Signale an den CH32V003/ADC sendet. Die Werte werden dann zu digitale Signale umgewandelt, vom CH572D verarbeitet und an den Auto Chip gesendet.

- Button: Der Button dient als spezial Effekt. Wird dieser gedrückt, sendet er ein Signal über den ADC und dem Ch572D an das Auto, welches dann den Buzzer aktiviert und die Hupe auslöst.

- Vibrationsmotor: Der Vibrationsmotor wird für haptisches Feedback verwendet. Er wird über den CH572D gesteuert und aktiviert, wenn bestimmte Ereignisse im Spiel auftreten, wie z.B. Kollisionen oder das Erreichen einer bestimmten Geschwindigkeit.


== Steuerung
Potentiometer: geschwindigkeit steuerung
Vibrationsmotor: für hatisches feedback
Display: geschwindigkeit, name, auto,... anzeige
Joaystick: hupe auslösen



== Antenne
auf 50Ohm angepasst, platine extra dünn um leiterbahn zum CH572D dünner halten zu können.


\

= Software

== App
#figure(
image("../Bilder/Appscreen.png", width: 50%),
caption: [
Startbildschirm
],)
Die App dient zum Einstellen ... . Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen.
- Modis:
  #figure(
    image("../Bilder/Modis.png", width: 100%),

    caption: [
      Modi Definition
    ]
  )


Nach dem start des Rennens zeigt die App die dauer (mit einer Timer Methode) und den Runden fortschritt der Spieler. Nach dem beenden des Rennes werden die Spieler des aktuellen Rennens nach der Bestzeit sortiert und angezeigt. Danach hat man die wahl wieder zum Hauptmenü zu gelangen oder sich das gesamte Ranking aller Rennen anzusehen. Diese werden nach der Bestzeit am Tag, Woche Monat, Gesamt und nach schnellste Runde sortiert.\ \


== Hauptmodul Display
Das Display XX verfügt über einen Kapazitiven Touchscreen, welcher einfache Einstellungen über das Display ermöglicht.
- Modi (einstellbar)
- Spieler anzahl
- Start/Stop
- Leaderboard
- 

== TCP Protokoll

#figure(
  image("../Bilder/TCPApp.png", width: 100%),

  caption: [
    TCP Deklaration in 
  ]
)

Um eine Verbindung zwischen der App und dem Hauptmodul Display herzustellen, wird das Protokoll verwendet. Dieses ermöglicht eine Bidirektionale Kommunikation zwischen den beiden Geräten. Das dient dazu, dass Änderungen, wie das Einstellen der Modi oder Spielernamen, auf das Display übertragen werden können.



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






