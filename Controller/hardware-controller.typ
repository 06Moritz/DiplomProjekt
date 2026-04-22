#import "../config.typ": *
#aktueller_autor.update([#author3, #klasse])

= Hardware //blockdiagramm einfügen 



Der Controller ist für die Steuerung des Autos verantwortlich. Er empfängt die Signale von den Sensoren, verarbeitet sie und sendet die entsprechenden Befehle an das Auto. 
Die Energieversorgung des Controllers erfolgt über einen Lithium-Polymer-Akku, welcher über eine Ladestation aufgeladen wird. 
Der Controller besteht aus folgenden Komponenten:

#figure(
image("/Bilder/Blockschaltbild-HW-Controller.svg", width: 75%),
caption: [Blockschaltbild Hardware Controller],
gap: 1em
)


// - Empfangene Daten: \ aktuelle Drehzahl des Fahrzeugs \ Spielername vom Basismodul

// - Datenprotokoll: \ serielle bidirektionale Kommunikation (z. B. UART) \ zyklischer Datenaustausch zwischen Controller und Basismodul

// - Gesendete Daten: \ ADC-Wert des Potentiometers zur Vorgabe der Geschwindigkeit \ Status des Schiebereglers 

// - Sende- und Empfangsrate: \ ADC-Wert: zyklisch, z. B. alle 20 ms (50 Hz) \ Drehzahl: zyklisch, z. B. alle 100 ms (10 Hz) \ Spielername: beim Start oder bei Änderung \ Vibrationssignal: ereignisbasiert bei maximaler Geschwindigkeit

// - Zusätzliche Funktion: \ Ansteuerung des Vibrationsmotors für haptisches Feedback bei Maximaltempo


//#pagebreak()

== Spannungsversorgung <sec_controller-spgversorgung>
Die Versorgung des Controllers erfolgt über einen @lipo, dessen Betriebsspannung zwischen 3.2 V und 4.2 V liegt. Der Akku wird über Federkontakte an einer Ladestation aufgeladen. (siehe @sec_ladestation-hw)

#figure(
  image("/Bilder/LadeB.png", width: 85%),
  caption: [Blockschaltbild Laderegler],

  )
\ 
Die Spannungsregelung ist in drei Teile gegliedert:
- Laderegelung:\ Sicherstellung eines geregelten Ladens des Akkus durch Überwachung von Spannung und Stromstärke während des Ladevorgangs. 

- Schutzschaltung:\ Verwendung eines Schutzschaltkreises zur verhinderung von Überladung und Tiefentladung. 

- @ldo:both: \ Regelt von Variabler Akkuspannung (3.2-4.2V) auf 3.3V für die Versorgung der Mikrocontroller und anderer Komponenten.  Für die geringe Spannungsdifferenz zwischen Akku und Versorgungsspannung der Komponenten ist ein @ldo:long nötig. 


#figure(
fimage("/Bilder/laderegler.png", width: 100%),
caption: [Spannungsregler],
) 

== Laderegler <sec-charger>

- TP4056 Laderegler\ Die Laderegelung erfolgt über den TP4056. Der TP4056 (U1) übernimmt die Spannungsreduzierung von 5 V Eingangsspannung auf die Betriebsspannung des Akkus.
Der TP4056 schützt den Akku durch eine geregelte Ladung. Er überwacht die Spannung und den Strom während des Ladevorgangs, um eine Überladung zu verhindern. Sobald der Akku vollständig geladen ist, schaltet der TP4056 automatisch in den Erhaltungsmodus.

Um einen Ladestrom von 1A einzustellen, wird ein 1.2kΩ Widerstand an PIN2 des TP4056 angeschlossen. @sourceLipo



Beim Aufnehmen der Ladekurve werden Strom und Spannung des Akkus gemessen. Die Ladespannung mittels einem Spannungsteiler, der Lade Ladestrom über einen Shunt-Widerstand.
#figure(
fimage("/Bilder/Ladevorgang.png", width: 100%),
caption: [Ladevorgang],
) 


//Mit einem Spannungsteiler wird die Ladespannung gemessen, der Ladestrom wird über einen Shunt-Widerstand gemessen.\ \
//englisch auf deutsch cc-cv
\ \
Das Aufladen eines Lithium-Polymer-Akkus erfolgt über den TP4056 mittels @cccv Prinzip. Der Akku wird mit einem konstanten Strom geladen, bis die Spannung des @lipo 4.2V erreicht. Ist diese Spannung erreicht, wird der Ladestrom reduziert, damit die Spannung konstant bleibt. Fällt der Strom unter einen bestimmten Schwellenwert, ist der Akku vollständig geladen. @sourceCCCV

#figure(
fimage("/Bilder/LadekSch.png", width: 100%),
caption: [Schaltplan für die Ladekurve aufnehmen],
)
\ 

Der Spannungsverlauf beim Laden wird über den Spannungsteiler erfasst, damit ein kleinerer Messbereich am Messgereit eingestellt werden kann und dadurch die Auflösung genauer wird. 
\

Der ladestrom wird mithilfe des Shuntwiderstands bestimmt. Durch den Spannungsabfall am Shunt, kann der Ladestrom berechnet werden. $U=I*R$
Der kleine Spannungsabfall am Shunt wird mit einer OPV-Schaltung verstärkt, um gemessen werden zu können.
\ \
- Schutzschaltung\ Um das Tiefentladen und Überladen des Akkus zu verhindern, wird der DW01 (U2) verwendet. Dieser Schutzschaltkreis überwacht den Stromfluss des Akkus und schaltet diesen mittels FS8205A MOSFETs (Q1 und Q2) ab, wenn die Spannung über einen speziellen Schwellenwert  steigt (4.25V), beziehungsweise fällt (2.4V). Das ist notwendig um den Akku nicht zu zerstören. @sourceDW01  \

Der Schaltplan des Ladereglers musste überarbeitet werden, da ein Verbindungsfehler zwischen dem Akku und dem FS8205A an dem Pin G2 vorlag. Dieser Fehler führte dazu, dass die Schutzschaltung für den Akku, den Akku nicht schützt. Der Fehler ist behoben worden, indem die Leiterbahn zwischen Akku und den Mosfets vom GND getrennt und im Schaltplan geändert wurde.  


== Mikrocontroller
Die Steuerung des Systems erfolgt über den CH572. Der Mikrocontroller verarbeitet die Daten und sendet sie über  @ble an das Fahrzeug. Zu beachten ist, dass der CH572 keine integrierten @adc hat, weshalb der CH32V003 als kosteneffizienter externer @adc verwendet wird.  
\ \
- CH572\ Der CH572 ist ein 32-Bit-Mikrocontroller, der auf RISC-V basiert. Er ist klein, verfügt über integrierte @ble Peripherie. Der CH572 ist für die Hauptsteuerung des Systems verantwortlich und verarbeitet die Daten. @sourceCH572

- CH32V003\ Der CH32V003 verfügt über einen integrierten @adc, der es möglich macht, die Analogen Signale der Peripherie Geräte zu verarbeiten. Da er kostengünstiger als ein externer @adc ist, wurde er ausgewählt. @sourceCH32 //die analogen Signale der Komponenten zu verarbeiten.
\ \

Bei der Entwicklung der Controller Platine wurde darauf geachtet, dass ein Quarz für eine stabile Taktfrequenz, die für @ble notwendig ist, vorhanden ist. Da der interne RC-Oszillator des CH572 zu instabil ist, ist ein externer Quarz mit einer Frequenz von 32 MHz an die Pins XO und XI angeschlossen.  
\ \


== Analog-Digital-Wandler (ADC)
Die analogen Signale vom Potentiometer und vom Schieberegler werden über den @adc von dem CH32V003 eingelesen. Der Chip wandelt die analogen Signale in digitale Werte um, sie werden über UART an den CH572 gesendet. 
Bauteile die zum auslesen einen @adc brauchen: 
- Potentiometer
- Schieberegler

== Steuerung
Die Bauteile (Potentiometer, Schieberegler, Vibrationsmotor) werden für die Steuerung des Autos verwendet. Sie ermöglichen es dem Spieler, die Geschwindigkeit zu steuern, die Hupe zu betätigen und ein haptisches Feedback zu erhalten. 

- *Potentiometer*: Das Potentiometer ist mit dem Gashebel verbunden. Die Stellung des Potentiometers wird über den @adc eingelesen und in ein digitales Signal umgewandelt, das an das Auto gesendet wird, um die Geschwindigkeit zu steuern. 

- *Schieberegler*: Der Schieberegler wird vom @adc eingelesen, wenn dieser einen bestimmten Schwellenwert überschreitet, wird ein Signal an das Auto gesendet, um die Hupe zu betätigen.

- *Vibrationsmotor*: Der Vibrationsmotor wird für haptisches Feedback verwendet. Er wird über den CH572 gesteuert. Bei bestimmten Ereignissen im Spiel, wie z.B. beim Erreichen der maximalen Geschwindigkeit, wird der Vibrationsmotor aktiviert, um dem Spieler ein haptisches Feedback zu geben.

== Antenne

Die Zuleitung ist auf 50 Ω angepasst, damit die Antenne optimal abstrahlt und eine optionale Verbindung über @ble zwischen dem Controller und dem Auto ermöglicht. Damit die Anpassung erhalten bleibt, wurde die Leiterbahn zwischen Antenne und dem CH572 entsprechend dimensioniert. Die Platine des Controllers ist 0.6mm dünn, wodurch die benötigte Leiterbahnbreite für den 50 Ohm Wellenwiderstand 0.8mm beträgt. \ 

Für eine möglichst geringe Störanfälligkeit wird die Leiterbahn zwischen Antenne und CH572 möglichst kurz gehalten. Längere Leiterbahnen erhöhen die parasitäre Induktivität und können bei der Übertragung zu Signalverzerrungen führen. Zusätzlich wurden entlang der Leiterbahn viele Ground-Vias platziert, um einen stabilen Rückstrompfad zu gewährleisten und hochfrequente Störungen zu reduzieren.

#figure(
fimage("/Bilder/Cantenne.png", width: 60%),
caption: [@ble Antennendesign],
)
\
#figure(
fimage("/Bilder/AntBode.png", width: 100%),
caption: [Bodediagramm der Antenne],
)
\
In dem angegebenen Bodediagramm der Antennensimulation ist der Reflexionsfaktor S11 aufgetragen. Zu erkennen ist, dass die Antenne im Bereich von 2.34GHz die beste Dämpfung hat. Da @ble im 2.4GHz Bereich arbeitet, ist die Antenne nicht ideal. Dennoch ist sie mit einer Dämpfung von -15dB ausreichend für die Kommunikation.
//Dämpfung?

#figure(
fimage("/Bilder/AntStrom.png", width: 100%),
caption: [Stromverteilung der Antenne],
)
\
In der Abbildung ist die Stromverteilung entlang der Antennenleiterbahn dargestellt. Die Stromdichte variiert entlang der Leiterbahn, mit einem Maximum in der Nähe des Speisepunkts.
//In diesem Diagramm ist die Stromverteilung auf der Antenne dargestellt. Es ist zu erkennen, dass die Stromdichte entlang der Leiterbahn variiert, mit einem Maximum in der Nähe des Speisepunkts. Dies ist typisch für eine Antenne und zeigt, dass die Energie effizient in den Raum abgestrahlt wird.
 
Um Störungen durch andere Signale auf der Platine zu vermeiden, sind keine Bauteile in der Nähe der Antenne und Leiterbahn platziert. 
Dadurch wird verhindert, dass hochfrequente Signale in benachbarte Leiterbahnen einkoppeln und die @ble -Kommunikation beeinflussen.@antennaSource\ \ 

== Leiterplatte

#figure(
image("/Bilder/controllerUberblick.png", width: 100%),
caption: [Leiterplatte des Controllers],
)

Zum Programmieren der Mikrocontrollers ist auf der Unterseite der Leiterplatte ein Überlötjumper platziert (CH572-Data-CH32). Durch das Umlöten der Pads, wird Platz auf der Oberseite eingespart, da ein programmier Pin doppelt belegt werden kann.

#pagebreak()



