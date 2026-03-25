#import "../config.typ": *
#aktueller_autor.update([#author2, #klasse])

= Hardware
*!*Die Hardware des Fahrzeugs \ \ 

== Blockschaltbild
#figure(
image("../Bilder/Blockschaltbild-HW-Auto.svg", width: 85%),
caption: [Blockschaltbild Hardware Auto],
)

== Spannungsversorgung <sec_auto-spgversorgung>
Die Schleifkontakte, an der Unterseite des Fahrzeugs, greifen 12V von der Schiene ab. Die Eingangspannung wird mit einem Buck-Converter auf 5V geregelt. Mit einem Linearregler wird auf 3.3V geregelt. Die stufenweise Regelung sorgt für eine geringe Restwelligkeit, da Mikrocontroller eine stabile Versorgungspannung benötigen.

#figure(
fimage("/Bilder/buckLay.png", width: 85%),
caption: [Layout des Abwertswandlers],
)

== Motor 
 Als Motor wird ein 12V Gleichstrommotor verwendet, der über eine H-Brücke gesteuert wird. Die H-Brücke ermöglicht es, die Drehrichtung des Motors zu ändern und die Geschwindigkeit zu steuern. siehe @sec-hbridge \ !Die Motorleistung wird über @pwm gesteuert. \ \
Der Motor hat folgende technische Daten: \
- Nennspannung: 12V
- Leerlaufstrom: 0.14A
- Leerlaufdrehzahl: 16500 U/min

Der Motor wurde aufgrund folgender Kriterien ausgewählt: \
- Hohe Spannung (12V) für ausreichend Leistung
- Drehzahl gewählt um eine Geschwindigkeit von ca. 8m/s erreichen bei einem Raddurchmesser von 15mm . 
$ U = 0.015 upright("m") *pi=0.0471m $ 
$ (8m/s)/(0.0471m) *60s= 10191U/min $

Der Motor muss unter Belastung eine Mindestdrehzahl von 10200 $U/min$ haben um 8$m/s$ zu erreichen.


== H-Brückenschaltung<sec-hbridge>

#figure(
image("../Bilder/HBrueke.png", width: 50%),
caption: [H-Brückenschaltung],
)

 Eine H-Brücke ist eine Schaltung mit der Motoren angesteuert werden. Die Drehrichtung kann durch die Ansteuerung der Transistoren geändert werden. Die Schaltung ermöglicht es, Motoren mit niedrigem Signalpegel zu steuern. @hbrueke

== WCH CH585
*!* Der CH585 ist ein Risc-V Microcontroller von WCH. Er hat native Peripherals für Bluetooth Low Energy (BLE) und Near Field Communication (NFC). Pwm pins...

== Antennendesign – BLE 
@ble hat eine Frequenz von 2.4GHz, dafür eignet sich am besten eine "Inverted-F-Antenne". Sie ist einfach zu Designen und hat eine gute Leitungsfähigkeit für ihre kleine Bauform. \ Beim entwickeln der Antenne sind einige Punkte zu beachten:
- 50\u{03A9} Wellenwiderstand der Leitung von der Antenne zum Anpassungsnetzwerk
- Antennen-Masse mit vielen Durchkontaktierungen mit GND Polygon verbinden
- keine GND Fläche unter der Antenne 
- hinter der Antenne GND mit vielen Vias setzen. \ (siehe @fig-bleantenna) @antennaSource \ \
Berechung der Leiterbahndicke für 50\u{03A9}  Wellenwiderstand: @Wellenwiderstand

$ w=((5.98*h)/(e^(((sqrt(e_r+ 1.41)*Z_0)/87)))-t)*1/0.8 $ 

t=0.035mm (Kupferdicke)\
h=1.5mm (Dicke des Dielektrikums)\
e_r=4.5 (Dielektrizitätskonstante)\
Z_0=50 \u{03A9} (Wellenwiderstand)

$ w=((5.98*1.5)/(e^(((sqrt(4.5+ 1.41)*50)/87)))-0.035)*1/0.8 = underline(underline(2.73"mm" => 106"mil")) $
\

#figure(
fimage("/Bilder/antenna.png", width: 70%),
caption: [BLE Antennendesign],
)<fig-bleantenna>

#pagebreak()

== Drehzahlsensor 
Die Drehzahl wird optisch mit einem VCNT2020 gemessen. Der Sensor besteht aus einer Infrarot LED und einem Fototransistor. Auf der Antriebswelle ist das Zahnrad zur Hälfte schwarz bemalt, wenn sich die Welle dreht ändert sich die Lichtintensität, die der Sensor empfängt, dadurch kann die Drehzahl berechnet werden. Das Ausgangssignal des Sensors wird mit einem Komparator aufbereitet, damit es vom Controller verarbeitet werden kann. Refernzspannung (Vref) muss so eingestellt werden, dass die Schaltschwelle zwischen dem Spannungswert bei heller und dunkler Seite liegt. 

Messwerte:
- helle Seite: 2.24V
- dunkle Seite: 0.64V

#figure(

image("../Bilder/speedsensor.png", width: 85%),
caption: [VCNT2020 und Komperator Schaltung],
)




== NFC Antenne 
#figure(
image("../Bilder/NFC.png", width: 85%),
caption: [NFC Antenne],
)

*!* Die NFC Antenne ist eine Spule direkt auf der Leiterplatte. Die Schaltung besteht aus 3 Teilen, EMV-Filter, Anpassungsnetzwerk und der Antenne. 
#figure(
fimage("/Bilder/nfcCoil.png", width: 50%),
caption: [NFC Antenne auf der Leiterplatte],
)



=== Ersatzschaltung

#figure(
image("../Bilder/SpuleErsatzschaltbild.png", width: 100%),
caption: [Ersatzschaltbild der NFC-Antenne],
)
<fig-nfcantenna>

Die Spule kann mit der Ersatzschaltung (@fig-nfcantenna) dargestellt werden. Optimal ist ein Gütefaktor von 35, damit die Antenne effizient arbeitet. Zu hohe Güten werden mit einem Dämpfungswiderstand R_Q ausgeglichen. Die Antenne Werte wurden durch Messung mit einer RCL-Messbrücke ermittelt. Die Spule hat folgende Werte: \
- Induktivität L#sub[a] = 555nH
- Widerstand R#sub[a] = 0.333\u{03A9}
Kapzität wurde nicht bestimmt da die Parastitären Kapazitäten höher sind als die Eigenkapazität der Spule.

  $ Q = (\u{03C9} * L_a)/R_a =  underline(underline(142)) $

  $ R_Q = 0.5 * ((\u{03C9}*L_a)/35-R_a)  = underline(underline(0.5\u{03A9}))  $

$ R_"pa" = (\u{03C9} * L_a)^2/(R_a+2*R_Q) = underline(underline(1.68k\u{03A9})) $

=== EMV-Filter

#figure(
image("../Bilder/NFCZTR.png", width: 85%),
caption: [EMV-Filter der NFC-Antenne],
)

Der EMV-Filer hat zwei Funktionen, Filtern des Signals und Impedanzanpassung.
Die Impedanzanpassung wird aus folgenden Gründen gemacht: 
- Verkleinert den Amplitudenanstieg nach der Modulationsphase
- Vergrößert die Empfangsbandbreite

Für die Dimensionierung wird die Schaltung in zwei Teile geteilt, der IC  wird durch den equivalenten Widerstand R#sub[match]  ersetzt. Dafür wird 80\u{03A9} angenommen. 
- Spule wird mit 1uH Dimensioniert
- Die Filterresonanzfrequenz muss annähernd der oberen Seitenbandfrequenz entsprechen, ca.14.3MHz. 

$ C_0 = 1/((2 *pi * f_"r0")^2*L_0) = underline(underline(120"pF")) $

Um die die Anpassungskomponenten zu berechnen wird die Impedanz Z#sub[tr] = R#sub[tr] + jX#sub[tr] benötigt.

$ R_"tr" = R_"match" /((1-\u{03C9}^2*L_0*C_0)^2 +(\u{03C9}*R_"match"/2*C_0)^2 )= underline(underline(443.3\u{03A9})) $ 

$ X_"tr" = (L_0*(1-\u{03C9}^2*L_0*C_0)-\u{03C9}^2/4*C_0) /((1-\u{03C9}^2*L_0*C_0)^2 +(\u{03C9}*R_"match"/2*C_0)^2 ) = underline(underline(-152.22j\u{03A9})) $ 

=== Anpassungsnetzwerk
$ C_1 approx 1/(\u{03C9}* (sqrt((R_"tr"*R_"pa")/4)+X_"tr"/2)) = underline(underline(32"pF")) $
$ C_2 approx 1/(\u{03C9}^2*L_"pa"/2)-1/(\u{03C9}*sqrt((R_"tr"*R_"pa")/4))-2*C_"pa" = underline(underline(390"pF")) $




== Leiterplatte