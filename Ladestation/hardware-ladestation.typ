#import "../config.typ": *

= Ladestation
Die Ladestation dient zum aufladen des Akkus vom Controller. Sie ist mit dem Hauptmodul Display verbunden und ermöglicht es die Controller aufzuladen, während sie nicht in Benutzung sind. Die Ladestation ist so konzipiert, dass sie einfach zu bedienen ist und eine sichere stromversorgung für die Controller bietet.
== Hardware
Versorgt wird die Ladestation mit einem USB-C Kabel über das Hauptmodul. 
? Mit einem kurzen USB-C zu  USB-c wird die Platine angeschlossen und versorgt. Die Ladestation wurde für vier Controller Designed. Die Controller werden über Federkontakte mit der Ladestation verbunden und aufgeladen. Da die Federkontakte über Magnete verbunden sind, ist es möglich die Controller einfach auf die Ladestation zu legen und es ist kaum möglich somit eine Verpolung zu verursachen.
\ \
#figure(
image("../Bilder/Ladestation.png", width: 50%),
caption: [
Schaltplan Ladestation],
)
\
Für die Versorgung wurde ein einfacher USB-C Anschluss verwendet, da keine Datenübertragung notwendig ist. Die Versorgung der ladestation erfolgt über das Hauptmodul, welches 5V liefert. Es wurde kein Laderegler benötigt, da dieser bereits in dem Controller verbaut ist. 
Die Widerstände R1 und R2 dienen zur Strombegrenzung, um eine Überlastung der ladestation zu verhindern.








