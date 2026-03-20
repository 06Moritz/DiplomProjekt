#import "../config.typ": *
#aktueller_autor.update(author1) // Melanie

= Hardware
*!* Einleitung \ Einleitung \ Einleitung


#figure(fimage("/Bilder/Blockschaltbild-HW-Bahn.svg", width: 100%),
caption: [Blockschaltbild Hardware Bahn],
)

== Spannungsversorgung <sec_bahn-spannungsversorgung>
Die Versorgung der Hardware erfolgt über einen @usb\-C Eingang mit @pd, der eine Eingangsspannung von 12V liefert. 

@usb\-C @pd:long wird aus folgenden Gründen verwendet:
- Standardisierung: @usb\-C @pd ist weit verbreitet und ermöglicht die Nutzung von handelsüblichen Netzteilen ohne eigene Steckerlösung.
- Leistung: @pd unterstützt bis zu 100W, was für die Anforderungen der Bahn mehr als ausreichend ist.
- Bauweise: @usb\-C ist kompakt, robust und ermöglicht reversibles Einstecken.
- Spannungsaushandlung: Über den @pd\-Handshake wird die benötigte Spannung von 12V aktiv zwischen Netzteil und Hardware vereinbart, wodurch nur kompatible Netzteile die erhöhte Spannung liefern und somit Sicherheit gewährleistet wird.

Von den 12V werden intern zwei geregelte Spannungsebenen erzeugt: 
- 5V über einen @buck:short (siehe @sec_bahn-buck)
- 3,3V über einen nachgeschalteten @ldo:short\-Spannungsregler (siehe @sec_bahn-ldo).
Die stufenweise Regelung dient dazu, eine sauberere Ausgangsspannung mit geringem @ripple:short zu erhalten, da der @ldo als Linearregler hochfrequente Störungen des @buck:short\s zusätzlich unterdrückt.

== Spannungsregler - Buck <sec_bahn-buck>
Als @buck:short wird der TPS56628RQFR von @ti eingesetzt, der die Eingangsspannung von 12V auf 5V bei einem maximalen Ausgangsstrom von 6A wandelt. @tps56628 Zur Funktionsweise eines @buck:short\s siehe @sec_buck. 

Der @ic:short wurde aufgrund folgender Eigenschaften gewählt:
- Ausgangsstrom: Mit bis zu 6A liefert der @ic:short ausreichend 
  Strom für alle angeschlossenen Komponenten.
- Effizienz: Der TPS56628 erreicht einen Wirkungsgrad von über 90%, was die Wärmeentwicklung auf der Platine gering hält.
- Integrierter @mosfet:short: Durch den integrierten High- und Low-Side-@mosfet:short entfallen externe Schaltelemente, was die Schaltung kompakter gestaltet.

Die Dimensionierung der Schaltung erfolgte mit dem @ti WEBENCH Power Designer @webench. Die Ausgangsspannung wird über einen resistiven Spannungsteiler am @fb:short\-Pin des ICs eingestellt. 

Dabei wurden folgende Widerstände verwendet:
- $R_(f b t) = 220 upright("kΩ")$
- $R_(f b b) = 30 upright("kΩ")$

Ein- und ausgangsseitig sind Stützkondensatoren verbaut, um die Ausgangsspannung zu stabilisieren und Spannungseinbrüche bei Lastsprüngen zu minimieren.

#figure(
fimage("/Bilder/sch-bahn-buck.png", width: 100%),
caption: [Schaltung Buck Converter Bahn],
)

== Spannungsregler - LDO <sec_bahn-ldo>
/* erst anschaun

- Eingang 5V, Ausgang 3.3V
- Versorgt ESP32-S3 und Display
- Stützkondensatoren C1–C4 (1µF)

Der LDO-Regler erzeugt aus den 5V des Buck-Converters eine stabile 3,3V Versorgungsspannung für den ESP32-S3 und das Display. Der XC6206P332MR wurde aufgrund seiner geringen Dropout-Spannung und seines kompakten SOT-23 Gehäuses gewählt. An Ein- und Ausgang sind jeweils 1µF Stützkondensatoren verbaut, um die Stabilität des Reglers zu gewährleisten und hochfrequente Störungen zu unterdrücken.
*/

== ESP32 S3 <sec_bahn-esp>
Der ESP32-S3-WROOM-1-N16R8 von Espressif ist ein kompaktes Mikrocontroller-Modul mit 3,3V Versorgungsspannung, integrierter Antenne, 16 MB Flash und 8 MB PSRAM. Er übernimmt die Steuerungslogik der Bahn, verarbeitet die @nfc\-Daten, steuert das Display an und kommuniziert drahtlos mit der App.

Für dieses Projekt ausschlaggebende Eigenschaften des verwendeten ESPs:
- Dual-Core (240 MHz): \ Zwei unabhängige Prozessorkerne ermöglichen die parallele Verarbeitung der Kommunikation und Steuerlogik.
- @psram:short: \ Der zusätzliche Arbeitsspeicher wird für die Darstellung der Displayinhalte benötigt.
- zwei @i2c:short\-Busse: \ Ermöglichung des gleichzeitigen Betriebs beider @nfc\-Module, da sie dieselbe @i2c:short\-Adresse verwenden. (siehe @sec_bahn-nfc).
- integrierte Antenne: \ Durch die im Modul integrierte Antenne entfällt eine externe @rf:short\-Beschaltung.
- @wifi:short und @ble:short: Drahtlose Kommunikation mit der App unter Verwendung des @tcp:short\-Protokolls. // (siehe @sec_app-kommunikation)
- ausreichend @gpio:short\s: \ Mit ? @gpio:short\-Pins ist die Verwendung aller Peripherie ohne Einschränkung möglich. Auch als Schaltsignal zur Freigabe des Ladeausgangs genutzt (siehe @sec_bahn-ladeausgang).

Für die Peripherieanbindung kommen zwei Kommunikationsprotokolle zum Einsatz: 
- @i2c: @nfc\-Module und Touchscreen des Displays
- @spi: Display

== Programmierschnittstelle <sec_bahn-programmierung>
Der ESP32-S3 wird über eine 6-polige Schnittstelle mit einem @usb:short\-@uart:short\-Adapter programmiert, da es platzsparender ist als ein @usb:short\-Anschluss. 

Folgende Signale sind heraus geführt:
- @gnd
- @io0
- @rx
- @tx
- @en
- 3,3V 

Durch Ziehen des @io0\-Pins auf GND wird der @bootloader:short\-Modus aktiviert und die @firmware:short über den @uart:short\-Adapter übertragen. Im normalen Betrieb bleibt @io0 unbeschaltet und der ESP32 startet die Applikation.

== Zeitnehmung - NFC <sec_bahn-nfc>
Zur Rundenzeitmessung werden zwei PN532 @nfc\-Lesestationen eingesetzt. Der PN532 ist als fertiges Breakout-Board erhältlich, das @uart:short, @i2c:short und @spi:short direkt unterstützt und einfach anzubinden ist. Fährt ein Auto über eines dieser Reader-Module, wird die ID des @nfc\-Tags im Fahrzeug ausgelesen und an den ESP32 übermittelt. Anhand der Tag-ID und dem Zeitstempel der Erkennung wird die Rundenzeit berechnet.
Zwei separate Module sind notwendig, da jede Fahrspur eine eigene Lesestation benötigt und unabhängig erfasst werden kann.
/*
#figure(
image("/Bilder/pn532.png", width: 30%),
caption: [NFC-Modul PN532],
)
*/
#figure(
image("/Bilder/pn532-esp.svg", width: 40%),
caption: [NFC-Modul PN532],
)

Die Kommunikatio
n zwischen ESP32 und den @nfc:short\-Modulen erfolgt über @i2c. @i2c ist ein serielles Zwei-Draht-Protokoll bestehend aus einer Datenleitung (@sda) und einer Taktleitung (@scl), das die Anbindung mehrerer Geräte über einen gemeinsamen Bus ermöglicht.

Beide PN532-Module haben dieselbe fest eingestellte @i2c:short\-Adresse und können somit nicht ohne Multiplexer auf einem Bus betrieben werden. Da eine eindeutige Adressierung nicht möglich ist, wird für jedes Modul ein eigener @i2c:short\-Bus des ESP32 verwendet:

- @i2c Bus 1: @sda:short 1 / @scl:short 1 → @nfc:short\-Modul 1 (Fahrspur 1)
- @i2c Bus 2: @sda:short 2 / @scl:short 2 → @nfc:short\-Modul 2 (Fahrspur 2)

An den jeweiligen Datenleitungen sind 10 kΩ Pull-up Widerstände auf 3,3V verbaut, da @i2c im Open-Drain-Betrieb ohne Pull-ups keinen definierten High Pegel sicherstellen kann. Jedes Modul wird über Drähte angeschlossen (@sda:short, @scl:short, @gnd:short und 3,3V). Das ermöglicht die flexible Positionierung der @nfc:short\-Antennen unter den Schienen der Bahn.

== Display <sec_bahn-display>
Als Anzeige für Renneinstellungen wird das MSP4031 Display-Modul verwendet, das über ein Flachbandkabel an der Platine angeschlossen ist.

Eigenschaften des Displays:
- Anzeige: TFT LCD
- Größe: 4,0 Zoll
- Auflösung: HVGA (320 x 480 Pixel)
- Touch: kapazitiver Touchscreen (FT6336U)
- Betrieb: 5V oder 3,3V

Die Displayansteuerung erfolgt über das @spi:long. @spi ist ein synchrones serielles Protokoll mit vier Leitungen (MOSI, MISO, SCK, CS), das höhere Übertragungsraten als @i2c:short ermöglicht und damit für die Übertragung von Bilddaten geeignet ist. Der kapazitive Touch-Controller kommuniziert separat über @i2c, wobei der erste @i2c:short\-Bus des ESP32 verwendet wird. Das Modul verfügt zusätzlich über einen SD-Karten-Steckplatz, der aktuell jedoch nicht genutzt wird.

== Ladeausgang <sec_bahn-ladeausgang>

#figure(
fimage("/Bilder/sch-bahn-ausgang.png", width: 100%),
caption: [Schaltung Ladeausgang Bahn],
)
/* erst anschaun

- USB C Ausgang 5V für die Versorgung der Ladestation
- SN74LVC1T45DCKR (U4): bidirektionaler Levelshifter für DIR-Signal
- CJ2305 (V1): P-Kanal MOSFET als Schalter
- Spannungsteiler R5 (10kΩ), R6/R7 (je 5.1kΩ) → CC-Leitungen für USB-C
- Steckverbinder B12 (USB1, TYPE-C 6P): Ausgang 5V für Ladestation
- ADC1/ADC2 vom ESP32 zur Stromerkennung/Überwachung

Der 5V Ladeausgang versorgt die Ladestation der Controller. Die Ausgangsspannung wird direkt vom Buck-Converter abgegriffen. Ein CJ2305 P-Kanal MOSFET schaltet den Ausgang, gesteuert durch ein Signal des ESP32. Dadurch kann die Stromversorgung der Ladestation softwareseitig aktiviert und deaktiviert werden, etwa um den Ladevorgang gezielt zu steuern.
Auf den CC-Leitungen des USB-C Steckverbinders sind jeweils 5,1 kΩ Widerstände gegen GND verbaut. Diese signalisieren dem angeschlossenen Gerät, dass es sich um ein 5V Standardprofil handelt, und sind gemäß USB-C Spezifikation für den Betrieb als Stromquelle erforderlich.
Zwei ADC-Eingänge des ESP32 (ADC1, ADC2) sind über einen 10 kΩ Spannungsteiler mit dem VBUS des Ausgangs verbunden, um die anliegende Spannung überwachen zu können.
Ein SN74LVC1T45DCKR bidirektionaler Levelshifter passt das Steuersignal für den MOSFET von 3,3V auf das erforderliche Spannungsniveau an.
*/

== Leiterplatte

#figure(
image("/Bilder/pcb-bahn.svg", width: 100%),
caption: [3D Modell Leiterplatte Bahn],
)
/* erst anschaun

- 3D Modell der Platine
- Schaltplan und PCB-Layout im Anhang

(hier kommen Schaltplan-Ausschnitte, PCB-Layout Bild, kurze Beschreibung der Lagenzahl, Abmessungen und ggf. besondere Designentscheidungen wie Massefläche, Leiterbahnbreiten für Hochstrom etc.)
*/