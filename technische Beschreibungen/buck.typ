#import "../config.typ": *
#aktueller_autor.update([#author1, #klasse])

= Abwärtswandler (Buck-Converter) <sec_buck>
Ein @buck:long ist ein Gleichspannungswandler, der eine Eingangsspannung in eine niedrigere Ausgangsspannung wandelt. 
Im Gegensatz zu Linearreglern wird die Spannungsdifferenz nicht in Wärme umgewandelt, sondern durch ein getaktetes Prinzip umgesetzt. Dies ermöglicht: 

- hohe Wirkungsgrade (oft > 90%) durch minimale Spannungsdifferenz an den Schaltelementen
- geringe Wärmeentwicklung
- kompakte Bauformen aufgrund hoher Schaltfrequenzen
- stabile Ausgangsspannung trotz schwankender Eingangsspannung

Der @buck nutzt eine Induktivität zur zeitgesteuerten Energiespeicherung. Ein @mosfet:short zerlegt die Eingangsspannung durch hochfrequentes Schalten in Pulse, wobei das Tastverhältnis der @pwm das Spannungsniveau am Ausgang definiert. Ein nachgeschalteter LC-Filter glättet die Pulse schließlich zu einer stabilen Gleichspannung für den Lastkreis. @buckSource

/* #figure(
  fimage("/Bilder/buckconverter.png", width: 100%),
  caption: [@buck Schaltungsprinzip],
) */
