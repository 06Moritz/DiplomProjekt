#import "../config.typ": *
#aktueller_autor.update([#author2, #klasse])
 
= Hardware
Das Fahrzeug hat eine 2.4GHz Antenne und eine NFC-Spule auf der Leiterplatte. Motortreiber und Drehzahlsensor für Drehzahlmessung. Für die Spannungsregelung hat es einen @buck. Ein Buzzer dient als akustische Signalgeber.\
\


// noch neues blockschaltbild
#figure(
  image("/Bilder/Blockschaltbild-HW-Auto.svg", width: 85%),
  caption: [Blockschaltbild Hardware Fahrzeug],
  gap: 1em
)

== Spannungsversorgung <sec_auto-spgversorgung>
Die Schleifkontakte, an der Unterseite des Fahrzeugs, greifen 12V von der Schiene ab. Die Eingangspannung wird mit einem @buck auf 5V geregelt. Mit einem Linearregler wird auf 3.3V reduziert. Die stufenweise Regelung sorgt für eine geringe Restwelligkeit, da Mikrocontroller eine stabile Versorgungsspannung benötigen (siehe @sec_bahn-spannungsversorgung).

#figure(
  image("/Bilder/buck-auto-sch.png", width: 110%),
  caption: [Schaltplan der Spannungsversorgung],
)


#figure(
  image("/Bilder/buckLay.png", width: 85%),
  caption: [Layout @buck Fahrzeug],
)

Layout der Spannungsversorgung:

- Einspeisung der 12V mittels der Schleifkontakte über M2 Schrauben
- Gleichrichten der Spannung mit Gleichrichter (N5) für Verpolungsschutz und Möglichkeit der Fahrtrichtungsänderung.
- Der @buck ist auf 5V Ausgangsspannung eingestellt über das Widerstandsverhältnis R2 zu R6.
- Es ist zu beachten die Eingangskondensatoren (C6,C7) nahe an dem @buck\-@ic:short zu platzieren.
- Die Ausgangskondensatoren (C8,C9) sollten nahe an der Last (3.3V Netz) platziert werden, um die Restwelligkeit zu minimieren.
- Alle Verbindungen sind mit Polygonen ausgeführt, um die Leitungsinduktivität zu reduzieren und die Wärmeableitung zu verbessern.
- Die Spule L1 ist nahe am @buck platziert, und mit vielen @via:short:pl verbunden.
- Mit dem Linearregler (U1) wird die Spannung für den Microkontroller auf 3.3V geregelt.




== Motor
Als Motor wird ein 12V Gleichstrommotor verwendet, der über eine H-Brücke gesteuert wird. Die H-Brücke ermöglicht es, die Drehrichtung des Motors zu ändern und die Geschwindigkeit über @pwm zu steuern (siehe @sec-hbridge).

Der Motor hat folgende technische Daten:
- Nennspannung: 12V
- Leerlaufstrom: 0.14A
- Leerlaufdrehzahl: 16500 $upright("U") / upright("min")$

Aufgrund folgender Kriterien wurde der Motor ausgewählt:
- Hohe Spannung (12V) für ausreichend Leistung
- Drehzahl gewählt um eine Geschwindigkeit von ca. 8$upright("m") / upright("s")$ zu erreichen bei einem Raddurchmesser von 15mm .

$ U = 0.015 upright("m") *pi=0.0471 upright("m") $
$ (8 upright("m") / upright("s") )/(0.0471 upright("m") ) *60 upright("s") = 10191 upright("U") / upright("min") $

Der Motor muss unter Belastung eine Mindestdrehzahl von 10200 $upright("U") / upright("min")$ haben, um 8 $upright("m") / upright("s")$ zu erreichen.


== H-Brückenschaltung<sec-hbridge>

#figure(
  fimage("/Bilder/HBrueke.png", width: 55%),
  caption: [H-Brückenschaltung],
)

Eine H-Brücke ist eine Schaltung mit der Motoren (hier: RL) angesteuert werden. Die Drehrichtung kann durch die Ansteuerung der Transistoren geändert werden. Die Schaltung ermöglicht es, Motoren mit niedrigem Signalpegel zu regeln. @hbrueke

== Mikrocontroller
Der CH585 ist ein @riscv:short Mikrocontroller von WCH. Er hat direkte Peripherieunterstützung für @ble:both und @nfc:both. @sourceCH585
// fertig schreiben


== Antennendesign – BLE
@ble hat eine Frequenz von 2.4GHz, dafür eignet sich am besten eine "Inverted-F-Antenne". Sie ist einfach zu Designen und hat eine gute Leitungsfähigkeit für ihre kleine Bauform.

Beim Entwickeln der Antenne sind einige Punkte zu beachten:
- 50\u{03A9} Wellenwiderstand der Leitung von der Antenne zum Anpassungsnetzwerk
- Antennen-Masse mittels vielen @via:long\en (@via:short:pl) mit @gnd:short\-Polygon verbinden
- keine @gnd Fläche unter der Antenne
- hinter der Antenne @gnd mit vielen @via:short:pl setzen
(siehe Abbildung 21) @antennaSource

Berechnung der Leiterbahndicke für 50\u{03A9}  Wellenwiderstand: @Wellenwiderstand

$ w=((5.98*h)/(e^(((sqrt(e_r+ 1.41)*Z_0)/87)))-t)*1/0.8 $

t = 0.035mm (Kupferdicke)\
h = 1.5mm (Dicke des Dielektrikums)\
e#sub("r") = 4.5 (Dielektrizitätskonstante von FR4 Material laut Hersteller) \
Z#sub("0") = 50 \u{03A9} (Wellenwiderstand)

$ w=((5.98*1.5)/(e^(((sqrt(4.5+ 1.41)*50)/87)))-0.035)*1/0.8 = underline(underline(2.73"mm" => 106"mil")) $
\
#pagebreak()
Die Simulation des Antennendesigns liefert einen Reflexionsfaktor (S#sub("11"))​ von ca. -7,5 dB bei der Betriebsfrequenz von 2,4 GHz (siehe Abbildung 28). Dies entspricht einer ausreichenden Leistungsübertragung für die Kommunikation auf kurze Distanz. In Abbildung 26 ist die Stromdichteverteilung zum Resonanzzeitpunkt dargestellt. \ \

#grid(
  columns: (1fr, auto),
  figure(
    fimage("/Bilder/stromverteilungAuto.png", height: 120pt), caption: [Stromverteilung auf der Antenne]
  ),
  figure(
    fimage("/Bilder/antenna.png", height: 120pt), caption: [Antennendesign]
  ) 
)

#figure(
  image("/Bilder/Autocart.png", width: 60%),
  caption: [Bodediagramm des Reflexionsfaktors],
)



// :)



== Drehzahlsensor
Die Drehzahl wird optisch mit einem VCNT2020 gemessen. Der Sensor besteht aus einer Infrarot @led:short und einem Fototransistor. Auf der Antriebsachse ist das Zahnrad zur Hälfte schwarz angestrichen. Wenn sich die Achse dreht ändert sich die Lichtintensität, die der Sensor empfängt, dadurch kann die Drehzahl berechnet werden. Das Ausgangssignal des Sensors wird mittels Kompertorschaltung in ein steilflankiges Digitales Signal umgewandelt, damit es vom Controller fehlerfrei eingelesen werden kann. Referenzspannung (IN-) wird so eingestellt, dass die Schaltschwelle zwischen dem Spannungswert bei heller und dunkler Seite liegt.

Messwerte:
- helle Seite: 2.24V
- dunkle Seite: 0.64V
\
#figure(
  image("/Bilder/speedsensor.png", width: 90%),
  caption: [VCNT2020 und Komperator Schaltung],
)

#pagebreak()


== NFC Antenne <sec_auto-nfcantenne>
Die @nfc:short\-Antenne ist eine Spule direkt auf der Leiterplatte. Die Schaltung besteht aus drei Teilen: EMV-Filter, Anpassungsnetzwerk und Antenne.
\ \
#figure(
  image("/Bilder/NFC.png", width: 90%),
  caption: [Schaltung der NFC-Antenne],
)
\
- NFC_N: NFC analog output N-terminal
- NFC_P: NFC analog output P-terminal
- NFCA_N: NFC analog input
- NFCA_P: NFC analog input
- NFC_CTR: NFC tune pin
#figure(
  image("/Bilder/nfcCoil.png", width: 80%),
  caption: [NFC Antenne auf der Leiterplatte],
)
#pagebreak()
=== Ersatzschaltung

#figure(
  fimage("/Bilder/SpuleErsatzschaltbild.png", width: 100%),
  caption: [Ersatzschaltbild der NFC-Antenne],
)
<fig-nfcantenna>

Die Spule kann mit der Ersatzschaltung dargestellt werden. Optimal ist ein Gütefaktor von 35 laut der Applicationnote, damit die Antenne effizient arbeitet. Zu hohe Güten werden mit einem Dämpfungswiderstand R#sub("Q") ausgeglichen. Die Antennenwerte wurden durch Messung mit einer RCL-Messbrücke ermittelt. 

Die Spule hat folgende Werte:
- Induktivität L#sub[a] = 555nH
- Widerstand R#sub[a] = 0.333\u{03A9}
Kapazität wurde nicht bestimmt, da die parastitären Kapazitäten der Messung höher sind als die Eigenkapazität der Spule. \ \

$ Q_"gemessen" = (\u{03C9} * L_a)/R_a = underline(underline(142)) $

$ R_Q = 0.5 * ((\u{03C9}*L_a)/35-R_a) = underline(underline(0.5\u{03A9})) $

$ R_"pa" = (\u{03C9} * L_a)^2/(R_a+2*R_Q) = underline(underline(1.68k\u{03A9})) $

#pagebreak()
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
#pagebreak()
=== Anpassungsnetzwerk
$ C_1 approx 1/(\u{03C9}* (sqrt((R_"tr"*R_"pa")/4)+X_"tr"/2)) = underline(underline(32"pF")) $
$ C_2 approx 1/(\u{03C9}^2*L_"pa"/2)-1/(\u{03C9}*sqrt((R_"tr"*R_"pa")/4))-2*C_"pa" = underline(underline(390"pF")) $

== Temporäre Spannungsversorgung
In das 3.3V Netz ist ein 10F Superkondensator eingebaut der durch Knopfdruck eingeschaltet werden kann um das Auto kurzfristig mit 3.3V zu versorgen. Dadurch kann das Auto hochgehoben durch die NFC-Funktion mit dem Controller Daten wie die MAC-Adresse austauschen.

== Leiterplatte

#figure(
  image("/Bilder/auto-pcb.svg", width: 100%),
  caption: [Leiterplatte Fahrzeug],
)
