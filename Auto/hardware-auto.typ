#import "../config.typ": *
#aktueller_autor.update([#author2, #klasse])

= Hardware
*!*Die Hardware des Fahrzeugs übernimmt die Zeitmessung beider Fahrspuren über @nfc, stellt Renninformationen auf einem Touchdisplay dar und kommuniziert drahtlos mit der App. Zusätzlich gibt es einen @usbc:short\-Ausgang für die Controller-Ladestation.*!*

motorregler nfc ble buzzer



/* // controller:
Die Hardware des Hauptmoduls übernimmt die Zeitmessung beider Fahrspuren über @nfc, stellt Renninformationen auf einem Touchdisplay dar und kommuniziert drahtlos mit der App. Zusätzlich gibt es einen @usbc:short\-Ausgang für die Controller-Ladestation. */


// noch neues blockschaltbild
#figure(
  fimage("/Bilder/Blockschaltbild-HW-Auto.svg", width: 85%),
  caption: [Blockschaltbild Hardware Auto],
)

== Spannungsversorgung <sec_auto-spgversorgung>
Die Schleifkontakte, an der Unterseite des Fahrzeugs, greifen 12V von der Schiene ab. Die Eingangspannung wird mit einem @buck auf 5V geregelt. Mit einem Linearregler wird auf 3.3V geregelt. Die stufenweise Regelung sorgt für eine geringe Restwelligkeit, da Mikrocontroller eine stabile Versorgungsspannung benötigen (siehe @sec_bahn-spannungsversorgung).

#figure(
  fimage("/Bilder/buckLay.png", width: 85%),
  caption: [Layout des @buck],
)

== Motor
Als Motor wird ein 12V Gleichstrommotor verwendet, der über eine H-Brücke gesteuert wird. Die H-Brücke ermöglicht es, die Drehrichtung des Motors zu ändern und die Geschwindigkeit über @pwm zu steuern (siehe @sec-hbridge).

Der Motor hat folgende technische Daten:
- Nennspannung: 12V
- Leerlaufstrom: 0.14A
- Leerlaufdrehzahl: 16500 $upright("U") / upright("min")$

Aufgrund folgender Kriterien wurde der Motor ausgewählt:
- Hohe Spannung (12V) für ausreichend Leistung
- Drehzahl gewählt um eine Geschwindigkeit von ca. 8$upright("m") / upright("s")$ erreichen bei einem Raddurchmesser von 15mm .

$ U = 0.015 upright("m") *pi=0.0471 upright("m") $
$ (8 upright("m") / upright("s") )/(0.0471 upright("m") ) *60 upright("s") = 10191 upright("U") / upright("min") $

Der Motor muss unter Belastung eine Mindestdrehzahl von 10200 $upright("U") / upright("min")$ haben, um 8 $upright("m") / upright("s")$ zu erreichen.


== H-Brückenschaltung<sec-hbridge>

#figure(
  fimage("/Bilder/HBrueke.png", width: 50%),
  caption: [H-Brückenschaltung],
)

Eine H-Brücke ist eine Schaltung mit der Motoren (hier: RL) angesteuert werden. Die Drehrichtung kann durch die Ansteuerung der Transistoren geändert werden. Die Schaltung ermöglicht es, Motoren mit niedrigem Signalpegel zu steuern. @hbrueke

== WCH CH585
Der CH585 ist ein @riscv:short Mikrocontroller von WCH. Er hat direkte Peripherie für @ble:both und @nfc:both. @sourceCH585
// fertig schreiben

== Antennendesign – BLE
@ble hat eine Frequenz von 2.4GHz, dafür eignet sich am besten eine "Inverted-F-Antenne". Sie ist einfach zu Designen und hat eine gute Leitungsfähigkeit für ihre kleine Bauform.

Beim Entwickeln der Antenne sind einige Punkte zu beachten:
- 50\u{03A9} Wellenwiderstand der Leitung von der Antenne zum Anpassungsnetzwerk
- Antennen-Masse mittels vielen @via:long\en (@via:short:pl) mit @gnd:short\-Polygon verbinden
- keine @gnd Fläche unter der Antenne
- hinter der Antenne @gnd mit vielen @via:short:pl setzen

(siehe @fig-bleantenna) @antennaSource
\ \
Berechnung der Leiterbahndicke für 50\u{03A9}  Wellenwiderstand: @Wellenwiderstand

$ w=((5.98*h)/(e^(((sqrt(e_r+ 1.41)*Z_0)/87)))-t)*1/0.8 $

t = 0.035mm (Kupferdicke)\
h = 1.5mm (Dicke des Dielektrikums)\
e#sub("r") = 4.5 (Dielektrizitätskonstante)\
Z#sub("0") = 50 \u{03A9} (Wellenwiderstand)

$ w=((5.98*1.5)/(e^(((sqrt(4.5+ 1.41)*50)/87)))-0.035)*1/0.8 = underline(underline(2.73"mm" => 106"mil")) $
\

#figure(
  fimage("/Bilder/antenna.png", width: 70%),
  caption: [BLE Antennendesign],
)<fig-bleantenna>


#figure(
  fimage("/Bilder/stromverteilungAuto.png", width: 70%),
  caption: [Stromverteilung auf der Antenne],
)


#figure(
  fimage("/Bilder/Autocart.png", width: 70%),
  caption: [Stromverteilung auf der Antenne],
)

// :)
Erklärung: Die Stromverteilung auf der Antenne zeigt, dass die Stromdichte an der Spitze der Antenne am höchsten ist, was typisch für eine Inverted-F-Antenne ist. Dies liegt daran, dass die Spitze der Antenne den größten Beitrag zur Strahlung leistet. Die Stromdichte nimmt entlang der Antenne ab, was zu einer effektiven Strahlung führt.


== Drehzahlsensor
Die Drehzahl wird optisch mit einem VCNT2020 gemessen. Der Sensor besteht aus einer Infrarot @led:short und einem Fototransistor. Auf der Antriebsachse ist das Zahnrad zur Hälfte schwarz bemalt. Wenn sich die Achse dreht ändert sich die Lichtintensität, die der Sensor empfängt, dadurch kann die Drehzahl berechnet werden. Das Ausgangssignal des Sensors wird mit einem Komparator aufbereitet, damit es vom Controller verarbeitet werden kann. Refernzspannung (IN-) wird so eingestellt, dass die Schaltschwelle zwischen dem Spannungswert bei heller und dunkler Seite liegt.

Messwerte:
- helle Seite: 2.24V
- dunkle Seite: 0.64V

#figure(
  fimage("/Bilder/speedsensor.png", width: 90%),
  caption: [VCNT2020 und Komperator Schaltung],
)




== NFC Antenne
Die @nfc:short\-Antenne ist eine Spule direkt auf der Leiterplatte. Die Schaltung besteht aus drei Teilen: EMV-Filter, Anpassungsnetzwerk und Antenne.
\ \
#figure(
  fimage("/Bilder/NFC.png", width: 90%),
  caption: [NFC Antenne],
)

#figure(
  fimage("/Bilder/nfcCoil.png", width: 60%),
  caption: [NFC Antenne auf der Leiterplatte],
)

=== Ersatzschaltung

#figure(
  fimage("/Bilder/SpuleErsatzschaltbild.png", width: 100%),
  caption: [Ersatzschaltbild der NFC-Antenne],
)
<fig-nfcantenna>

Die Spule kann mit der Ersatzschaltung dargestellt werden. Optimal ist ein Gütefaktor von 35, damit die Antenne effizient arbeitet. Zu hohe Güten werden mit einem Dämpfungswiderstand R#sub("Q") ausgeglichen. Die Antennenwerte wurden durch Messung mit einer RCL-Messbrücke ermittelt. 

Die Spule hat folgende Werte:
- Induktivität L#sub[a] = 555nH
- Widerstand R#sub[a] = 0.333\u{03A9}
Kapazität wurde nicht bestimmt, da die parastitären Kapazitäten der Messung höher sind als die Eigenkapazität der Spule.

$ Q = (\u{03C9} * L_a)/R_a = underline(underline(142)) $

$ R_Q = 0.5 * ((\u{03C9}*L_a)/35-R_a) = underline(underline(0.5\u{03A9})) $

$ R_"pa" = (\u{03C9} * L_a)^2/(R_a+2*R_Q) = underline(underline(1.68k\u{03A9})) $

=== EMV-Filter

#figure(
  fimage("/Bilder/NFCZTR.png", width: 85%),
  caption: [EMV-Filter der NFC-Antenne],
)

Der EMV-Filter hat zwei Funktionen: Filtern des Signals und Impedanzanpassung.
Die Impedanzanpassung wird aus folgenden Gründen gemacht:
- verkleinert den Amplitudenanstieg nach der Modulationsphase
- vergrößert die Empfangsbandbreite

Für die Dimensionierung wird die Schaltung in zwei Teile geteilt, der @ic:short  wird durch den äquivalenten Widerstand R#sub[match]  ersetzt. Dafür wird 80\u{03A9} angenommen.
- Spule wird mit 1uH dimensioniert
- Die Filterresonanzfrequenz muss annähernd der oberen Seitenbandfrequenz entsprechen, ca.14.3MHz.

$ C_0 = 1/((2 *pi * f_"r0")^2*L_0) = underline(underline(120"pF")) $

Um die die Anpassungskomponenten zu berechnen wird die Impedanz Z#sub[tr] = R#sub[tr] + jX#sub[tr] benötigt.

$ R_"tr" = R_"match" /((1-\u{03C9}^2*L_0*C_0)^2 +(\u{03C9}*R_"match"/2*C_0)^2 )= underline(underline(443.3\u{03A9})) $

$
  X_"tr" = (L_0*(1-\u{03C9}^2*L_0*C_0)-\u{03C9}^2/4*C_0) /((1-\u{03C9}^2*L_0*C_0)^2 +(\u{03C9}*R_"match"/2*C_0)^2 ) = underline(underline(-152.22j\u{03A9}))
$

=== Anpassungsnetzwerk
$ C_1 approx 1/(\u{03C9}* (sqrt((R_"tr"*R_"pa")/4)+X_"tr"/2)) = underline(underline(32"pF")) $
$ C_2 approx 1/(\u{03C9}^2*L_"pa"/2)-1/(\u{03C9}*sqrt((R_"tr"*R_"pa")/4))-2*C_"pa" = underline(underline(390"pF")) $


== Leiterplatte

#figure(
  fimage("/Bilder/auto-pcb.svg", width: 100%),
  caption: [Ersatzschaltbild der @nfc:short\-Antenne],
)
