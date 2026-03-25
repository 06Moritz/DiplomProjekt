#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Mechanik

Das mechanische Komponente des Autos ist möglichst einfach gehalten. Die Leiterplatte wird als Bodenplatte des Fahrzeugs verwendet. Die Räder werden mit einem einfachen Getriebe angetrieben.

#figure(
image("../Bilder/3d-car.png", width: 85%),
caption: [3D Modell des Autos],
)
== Getriebe
Der Motor wird 5:4 untersetzt, um aus der hohen Drehzahl des Motors ein höheres Drehmoment zu erhalten. Es werden 2 Zahnräder mit 10 bzw. 8 Zähnen verwendet, um die Untersetzung zu erreichen. Die Hinterachse wird mit zwei Kegelrädern angetrieben.

#figure(
  grid(
    columns: 2, rows : 2, image("/Bilder/bevel1.png"),image("/Bilder/bevel2.png"),image("/Bilder/gearComp.png"), image("/Bilder/gear.png")
  )
)

== Wellenaufhängung
Die Wellen werden in Messingblöcken gelagert. Die Blöcke sind aus Messing auf Maß gefräst.

== Achsaufhängung 
Die Achsen werden aus ABS 3D gedruckten Halterungen geführt. Die Halterungen werden auf die Bodenplatte gesteckt und verschraubt. 
#figure(
  grid(
    columns: 2, rows : 2, image("/Bilder/achsmountfront.png"),image("/Bilder/achsmountrear.png"),
  )
)

== Schleifkontakte
Die Spannungsversorgung des Autos erfolgt über Schleifkontakte unter dem Auto. Diese werden mit Schrauben mit dem Auto verbunden. Die Bürsten sind aus Kupfer. 