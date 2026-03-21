#import "../config.typ": *
#aktueller_autor.update(author1) // Melanie

= @ldo:both <sec_ldo>
*!* Ein @ldo:long ist ein linearer Spannungsregler, der eine Eingangsspannung in eine niedrigere, stabile Ausgangsspannung wandelt. Die Regelung erfolgt dabei nicht durch getaktetes Schalten wie beim @buck (siehe @sec_buck), sondern durch einen kontinuierlich gesteuerten Transistor, der die überschüssige Spannung als Wärme abgibt. Aufgrund der geringen benötigten Differenz zwischen Ein- und Ausgangsspannung (Low-Dropout-Spannung) ist der @ldo passend für Anwendungen, bei denen der Eingangswert nur knapp über dem gewünschten Ausgangswert liegt.

Eigenschaften eines @ldo's:
- einfache Beschaltung mit wenigen externen Bauteilen
- sehr geringes Ausgangsrauschen sowie minimale @ripple
- keine elektromagnetischen Störungen durch Schaltfrequenzen
- geringer Wirkungsgrad bei großer Spannungsdifferenz

Durch das geringe Rauschen eignet sich der @ldo besonders als nachgeschaltete Stufe eines @buck:short\s, um dessen hochfrequente Schaltstörungen zu unterdrücken. So wird eine saubere Versorgungsspannung für empfindliche Bauteile wie Mikrocontroller oder Displays bereitgestellt. //@ldoSource