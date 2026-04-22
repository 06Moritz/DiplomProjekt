#import "../config.typ": *
#aktueller_autor.update([#author1, #klasse])

= Abwärtswandler (Buck-Converter) <sec_buck>
/* Ein @buck:long ist ein Gleichspannungswandler, der eine Eingangsspannung effizient in eine niedrigere Ausgangsspannung wandelt. Ein @mosfet:short zerlegt die Eingangsspannung durch hochfrequentes Schalten in Pulse, wobei das Tastverhältnis der @pwm das Spannungsniveau am Ausgang definiert. Ein nachgeschalteter LC-Filter glättet die Pulse zu einer stabilen Gleichspannung. Dadurch werden hohe Wirkungsgrade von oft über 90% bei geringer Wärmeentwicklung erreicht. @buckSource
 */


Ein @buck:long ist ein Gleichspannungswandler, der eine Eingangsspannung in eine niedrigere Ausgangsspannung wandelt. 
Im Gegensatz zu Linearreglern wird die Spannungsdifferenz nicht in Wärme umgewandelt, sondern durch ein getaktetes Prinzip umgesetzt. Dies ermöglicht: 

- hohe Wirkungsgrade (oft > 90%) durch minimale Spannungsdifferenz an den Schaltelementen
- kompakte Bauformen aufgrund hoher Schaltfrequenzen
- stabile Ausgangsspannung trotz schwankender Eingangsspannung

Der @buck nutzt eine Induktivität zur zeitgesteuerten Energiespeicherung. Ein @mosfet:short zerlegt die Eingangsspannung durch hochfrequentes Schalten in Pulse, wobei das Tastverhältnis der @pwm das Spannungsniveau am Ausgang definiert. Ein nachgeschalteter LC-Filter glättet die Pulse schließlich zu einer stabilen Gleichspannung für den Lastkreis. @buckSource 

/* //Bild ist falsch 
  #figure(
  fimage("/Bilder/buckconverter.png", width: 100%),
  caption: [@buck Schaltungsprinzip],
) */

\
Verwendung im Projekt:
- Basismodul: \ 12V auf 5V für Ladestation und @ldo:short (siehe @sec_bahn-buck)
- Fahrzeug: \ 12V auf 5V aus den Schleifkontakten (siehe @sec_auto-spgversorgung)

#pagebreak()