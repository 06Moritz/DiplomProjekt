#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Mechanik
Die mechanische Komponente des Autos ist möglichst einfach gehalten. Die Leiterplatte wird als Bodenplatte des Fahrzeugs verwendet. Die Räder werden mit einem einfachen Getriebe angetrieben.

#figure(
  image("/Bilder/3d-car.png", width: 85%),
  caption: [3D Modell des Autos],
)

== Getriebe
Der Motor wird 5:4 untersetzt, um aus der hohen Drehzahl des Motors ein höheres Drehmoment zu erhalten. Es werden zwei Zahnräder mit 10 bzw. 8 Zähnen verwendet, um die Untersetzung zu erreichen. Die Hinterachse wird mit zwei Kegelrädern angetrieben.


#grid(
  columns: (1fr, auto),
  figure(
    fimage("/Bilder/bevel.png", height: 120pt), caption: [Achsantreib mit Kegelrad]
  ),
  figure(
    fimage("/Bilder/gear.png", height: 120pt), caption: [Motorübersetzung]
  ),
)

== Wellenaufhängung
Die gefrästen Messingblöcke positionieren und lagern die Wellen. Sie sind mit dem @pcb durch @m2:short\-Schrauben befestigt.

== Achsaufhängung
Die Achsen werden von Achshalterungen hinten und vorne gelagert. Sie sind aus @abs 3D-gedruckt wegen der Temperaturbeständigkeit des Materials. Die Halterungen werden auf die Bodenplatte gesteckt und verschraubt.

#grid(
  columns: (1fr, auto),
  figure(
    fimage("/Bilder/achsmountfront.png", height: 150pt),
    caption: [Achsaufhängung vorne],
  ),
  figure(fimage("/Bilder/achsmountrear.png", height: 150pt), caption: [Achsaufhängung hinten]),
)

== Schleifkontakte
Die Spannungsversorgung des Autos erfolgt über Schleifkontakte unter dem Auto. Diese werden mit Schrauben an dem Auto befestigt. Die Bürsten sind aus Kupfer.
