#import "../config.typ": *
#aktueller_autor.update([#author3, #klasse])

Die Ladestation dient zum Aufladen des Akkus vom Controller. Sie ist so konzipiert, dass sie einfach zu bedienen ist und eine sichere Stromversorgung für die Controller bietet.

= Hardware <sec_ladestation-hw>
Versorgt wird die Ladestation mit einem @usbc Anschluss. An dem Hauptmodul ist ein USB-C Buchse vorgesehen.
Mit einem kurzen USB-C zu  USB-C Stecker wird die Platine angeschlossen. Die Ladestation ist für vier Controller designt. Die Controller werden über Federkontakte mit der Ladestation verbunden und aufgeladen. Da die Federkontakte über Magnete verbunden sind, ist es möglich, die Controller einfach auf die Ladestation zu stellen und eine Verpolung ist auszuschließen.
\ \
#figure(
fimage("/Bilder/Ladestation.png", width: 70%),
caption: [Schaltplan Ladestation],
)
\
Für die Versorgung wird ein einfacher USB-C Anschluss verwendet, da keine Datenübertragung notwendig ist. Ein Laderegler wird nicht benötigt, da dieser bereits im Controller verbaut ist. 
Die Widerstände R1 und R2 dienen zur Erkennung eines Geräts.


#pagebreak()





