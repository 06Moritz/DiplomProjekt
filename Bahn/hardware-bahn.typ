#import "../config.typ": *
#aktueller_autor.update([#author1, #klasse])

= Hardware <sec_bahn-hardware>
Die Hardware der Rennbahn übernimmt die Zeitmessung beider Fahrspuren über @nfc, stellt Renninformationen auf einem Touchdisplay dar und kommuniziert drahtlos mit der App. Zusätzlich versorgt sie die Controller-Ladestation. Das Blockschaltbild
gibt einen Überblick über die Komponenten und deren Zusammenspiel.

#figure(
  image("/Bilder/Blockschaltbild-HW-Bahn.svg", width: 100%),
  caption: [Blockschaltbild Hardware Bahn],
)

== Spannungsversorgung <sec_bahn-spannungsversorgung>
Die Versorgung der Hardware erfolgt über einen @usbc Eingang mit @pd, der eine Eingangsspannung von 12V liefert. Dabei wird ein bestehendes @pd:short\-Modul verwendet, das direkt auf dem @pcb integriert ist. Die 12V werden zudem direkt an die Schienen weitergeleitet, über die die Fahrzeuge mit Strom versorgt werden.

@usbc @pd:long wird aus folgenden Gründen verwendet:
- Standardisierung: @usbc @pd ist weit verbreitet und ermöglicht die Nutzung von handelsüblichen Netzteilen ohne eigene Steckerlösung.
- Leistung: @pd unterstützt bis zu 240W, was für die Anforderungen der Bahn mehr als ausreichend ist. @sourcePDhama
- Bauweise: @usbc ist kompakt, robust und ermöglicht reversibles Einstecken.
- Spannungsaushandlung: Über den @pd\-Handshake wird die benötigte Spannung von 12V aktiv zwischen Netzteil und Hardware vereinbart, wodurch nur kompatible Netzteile die erhöhte Spannung liefern.

Von den 12V werden intern zwei geregelte Spannungsebenen erzeugt: 
- 5V über einen @buck (siehe @sec_bahn-buck)
- 3,3V über einen nachgeschalteten @ldo:short\-Spannungsregler (siehe @sec_bahn-ldo).
Die stufenweise Regelung dient dazu, eine sauberere Ausgangsspannung mit geringem @ripple:short zu erhalten, da der @ldo als Linearregler hochfrequente Störungen des @buck:short\s zusätzlich unterdrückt.

== Spannungsregler - Buck <sec_bahn-buck>
Als @buck wird der TPS56628RQFR von @ti eingesetzt, der die Eingangsspannung von 12V auf 5V bei einem maximalen Ausgangsstrom von 6A wandelt. @tps56628 Zur Funktionsweise eines @buck:short\s siehe @sec_buck. 

Der @ic:short wurde aufgrund folgender Eigenschaften gewählt:
- Ausgangsstrom: Mit bis zu 6A liefert der @ic:short ausreichend 
  Strom für alle angeschlossenen Komponenten.
- Effizienz: Der TPS56628 erreicht einen Wirkungsgrad von über 90%, was die Wärmeentwicklung auf dem @pcb gering hält. // oder @pcb:short
- Integrierter @mosfet:short: Durch den integrierten High- und Low-Side-@mosfet:short entfallen externe Schaltelemente, was die Schaltung kompakter gestaltet.

Die Dimensionierung der Schaltung erfolgte mit dem @ti WEBENCH Power Designer @webench. Die Ausgangsspannung wird über einen resistiven Spannungsteiler am @fb:short\-Pin des ICs eingestellt. 

Dabei wurden folgende Widerstände verwendet:
- $R_(f b t) = 220 upright("kΩ")$
- $R_(f b b) = 30 upright("kΩ")$

Am Eingang und Ausgang befinden sind Stützkondensatoren, um die Ausgangsspannung zu stabilisieren und Spannungseinbrüche bei Lastsprüngen zu minimieren.

#figure(
  fimage("/Bilder/sch-bahn-buck.png", width: 100%),
  caption: [Schaltung @buck Bahn],
)

== Spannungsregler - LDO <sec_bahn-ldo>
Zur Erzeugung der 3,3V Systemspannung wird der XC6206P332MR eingesetzt, der die 5V Ausgangsspannung des @buck\s auf 3,3V regelt. Zur Funktionsweise eines @ldo\s siehe @sec_ldo.

Der @ic:short wird wegen seiner einfachen Beschaltung mit wenigen externen Bauteilen sowie dem geringen Rauschen verwendet. Als nachgestellter Linearregler unterdrückt er hochfrequente Störungen des @buck\s, was eine saubere Versorgungsspannung für ESP32, Display und @nfc:short\-Module ermöglicht.
Ein- und ausgangsseitig sind Stützkondensatoren zur Stabilisierung der Ausgangsspannung verbaut.

== ESP32 S3 <sec_bahn-esp>
Der ESP32-S3-WROOM-1-N16R8 von Espressif ist ein kompaktes Mikrocontroller-Modul mit 3,3V Versorgungsspannung, integrierter Antenne, 16 MB Flash und 8 MB PSRAM. Er übernimmt die Steuerungslogik der Bahn, verarbeitet die @nfc\-Daten, steuert das Display an und kommuniziert drahtlos mit der App.

Für dieses Projekt ausschlaggebende Eigenschaften des verwendeten ESPs:
- Dual-Core (240 MHz): \ Zwei unabhängige Prozessorkerne ermöglichen die parallele Verarbeitung der Kommunikation und Steuerlogik.
- @psram:short: \ Der zusätzliche Arbeitsspeicher wird für die Darstellung der Displayinhalte benötigt.
- zwei @i2c:short\-Busse: \ Ermöglichung des gleichzeitigen Betriebs beider @nfc\-Module, da sie dieselbe @i2c:short\-Adresse verwenden. (siehe @sec_bahn-nfc).
- integrierte Antenne: \ Durch die im Modul integrierte Antenne entfällt eine externe @rf:short\-Beschaltung.
- @wifi:short und @ble:short: \ Drahtlose Kommunikation mit der App unter Verwendung des @tcp:short\-Protokolls. // (siehe @sec_app-kommunikation)
- ausreichend @gpio:short\s: \ Mit ? @gpio:short\-Pins ist die Verwendung aller Peripherie ohne Einschränkung möglich. Auch als Schaltsignal zur Freigabe des Ladeausgangs genutzt (siehe @sec_bahn-ladeausgang).

Für die Peripherieanbindung kommen zwei Kommunikationsprotokolle zum Einsatz: 
- @i2c: @nfc\-Module und Touchscreen des Displays
- @spi: Display

== Programmierschnittstelle <sec_bahn-programmierung>
Der ESP32-S3 wird über eine 6-polige Schnittstelle mit einem @usb:short\-@uart:short\-Adapter programmiert, da es platzsparender ist als ein @usb:short\-Anschluss. 

Folgende Signale sind herausgeführt:
- @gnd
- @io0
- @rx
- @tx
- @en
- 3,3V 

Durch Ziehen des @io0\-Pins auf @gnd wird der @bootloader:short\-Modus aktiviert und die @firmware:short über den @uart:short\-Adapter übertragen. Im normalen Betrieb bleibt @io0 unbeschaltet und der ESP32 startet die Applikation.

== Zeitnehmung - NFC <sec_bahn-nfc>
Zur Rundenzeitmessung werden zwei PN532 @nfc\-Lesestationen eingesetzt. Der PN532 ist als fertiges Breakout-Board erhältlich, das @uart:short, @i2c:short und @spi:short direkt unterstützt und einfach anzubinden ist. Fährt ein Auto über eines dieser Reader-Module, wird die @id:short des @nfc\-Tags im Fahrzeug ausgelesen und an den ESP32 übermittelt. Anhand der Tag-@id:short und dem Zeitstempel der Erkennung wird die Rundenzeit berechnet.
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

Die Kommunikation zwischen ESP32 und den @nfc:short\-Modulen erfolgt über @i2c. @i2c ist ein serielles Zwei-Draht-Protokoll bestehend aus einer Datenleitung (@sda) und einer Taktleitung (@scl), das die Anbindung mehrerer Geräte über einen gemeinsamen Bus ermöglicht.

Beide PN532-Module haben dieselbe fest eingestellte @i2c:short\-Adresse und können somit nicht ohne Multiplexer auf einem Bus betrieben werden. Da eine eindeutige Adressierung nicht möglich ist, wird für jedes Modul ein eigener @i2c:short\-Bus des ESP32 verwendet:

- @i2c Bus 1: @sda:short 1 / @scl:short 1 → @nfc:short\-Modul 1 (Fahrspur 1)
- @i2c Bus 2: @sda:short 2 / @scl:short 2 → @nfc:short\-Modul 2 (Fahrspur 2)

An den jeweiligen Datenleitungen sind 10 kΩ Pull-up Widerstände auf 3,3V verbaut, da @i2c im Open-Drain-Betrieb ohne Pull-ups keinen definierten High Pegel sicherstellen kann. Jedes Modul wird über Drähte angeschlossen (@sda:short, @scl:short, @gnd:short und 3,3V). Das ermöglicht die flexible Positionierung der @nfc:short\-Antennen unter den Schienen der Bahn.

== Display <sec_bahn-display>
Als Anzeige für Renneinstellungen wird das MSP4031 Display-Modul verwendet, das über ein Flachbandkabel an der Platine angeschlossen ist.

Eigenschaften des Displays:
- Anzeige: @tft:short @lcd:short
- Größe: 4,0 Zoll
- Auflösung: @hvga:short (320 x 480 Pixel)
- Touch: kapazitiver Touchscreen (FT6336U)
- Betrieb: 5V oder 3,3V

Die Displayansteuerung erfolgt über das @spi:long. @spi ist ein synchrones serielles Protokoll mit vier Leitungen:
- @miso
- @mosi
- @sck
- @cs
Es ermöglicht höhere Übertragungsraten als @i2c:short und ist damit für die Übertragung von Bilddaten geeignet. Der kapazitive Touch-Controller kommuniziert separat über @i2c, wobei der erste @i2c:short\-Bus des ESP32 verwendet wird. Das Modul verfügt zusätzlich über einen @sd:short\-Karten-Steckplatz, der aktuell jedoch nicht genutzt wird.

== @levelshifter:both <sec_bahn-levelshifter>
Der SN74LVC1T45DCKR ist ein bidirektionaler @levelshifter, der Signale zwischen zwei unterschiedlichen Spannungsebenen anpasst. Er wird verwendet um das 3,3V Steuersignal des ESP32 auf 5V anzuheben, da der nachgeschaltete @mosfet eine 5V-kompatible Ansteuerung erwartet. Die Richtung der Signalübertragung wird über den @dir:short\-Pin festgelegt. // oder @mosfet:short

#pagebreak()
== Ladeausgang <sec_bahn-ladeausgang>
Der @usbc Ladeausgang versorgt die Ladestation der Controller mit 5V. Die Spannung wird direkt vom @buck bereitgestellt.

#figure(
  fimage("/Bilder/sch-bahn-ausgang.png", width: 100%),
  caption: [Schaltung Ladeausgang Bahn],
) <img_sch-bahn-ausgang>

Die Ladefunktion ist über einen CJ2305 P-Kanal @mosfet schaltbar, der vom ESP32 über den @levelshifter angesteuert wird (siehe @sec_bahn-levelshifter).

An den @cc:short\-Leitungen des Steckverbinders sind je ein 5,1 kΩ Pull-up Widerstand gegen 3,3V verbaut. Wird ein Gerät angesteckt, bildet dessen interner Pull-down Widerstand $R_d$ (5,1 kΩ gemäß @usbc\-Spezifikation /*@usbc-spez*/) mit $R_6$ bzw. $R_7$ einen Spannungsteiler. Der Pegel $U_(A D C)$ an ADC1 bzw. ADC2 fällt dadurch von 3,3V auf ca. 1,65V. 
$ U_(A D C) = 3.3 upright("V") dot R_d / (R_d + R_6) = 3.3 upright("V") dot (5.1 upright("k")Omega) / (5.1 upright("k")Omega + 5.1 upright("k")Omega) = 1.65 upright("V") $
Der ESP32 wertet diesen Spannungsabfall aus und gibt die 5V-Versorgung über den @mosfet softwareseitig frei (siehe @sec_bahn-software).
//@usb-source

#pagebreak()
== Leiterplatte <sec_bahn-pcb>
Die Leiterplatte wurde mit @easyeda:short entworfen und als zweiseitiges @pcb gefertigt. Der vollständige Schaltplan sowie das @pcb\-Layout (Top/Bottom) sind im Anhang zu finden. // (siehe @anhang_bahn-sch, @anhang_bahn-pcb).

#figure(
  image("/Bilder/pcb-bahn.svg", width: 100%),
  caption: [3D Modell Leiterplatte Bahn],
)

Relevante Designentscheidungen:
- Leiterbahnbreite: \ 12V, 5V und 3,3V Pfade sind entsprechend der jeweiligen Strombelastung breiter geführt als die Signalleitungen.
- Abmessungen: \ Das @pcb orientiert sich in der Breite an den Maßen des Displays, da beide im Gehäuse übereinander verbaut sind (siehe @sec_bahn-3d).
- Steckerplazierung: \ @usbc Eingang und Ausgang befinden sich bewusst auf gegenüberliegenden Seiten, um eine einfache Zugänglichkeit zu ermöglichen. 