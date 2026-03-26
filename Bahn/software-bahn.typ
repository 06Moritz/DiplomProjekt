#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author3, #klasse])

= Software <sec_bahn-software>

? Die Software des Hauptmoduls dient zum Rundenzeit messen mittels NFC, erkennen von Autos, sowie zum Anzeigen von Informationen auf einem Display. ? Die Software ist in C++ geschrieben und läuft auf einen ESP32S3.

== @nfc:long
Die Rundenzeit wird über NFC gemessen. Jedes Auto hat eine eingebaute NFC Spule. Sobald ein Auto über den NFC-Tag fährt, wird ein Signal an den ESP geschickt, welcher die Werte auswertet und die Rundenzeit über BLE an die App, den Hauptmodul Display und den Controller sendet. 
\
```c
code:


```

== @ble:long
Die Software empfängt die Rundenzeit über NFC und sendet sie über BLE an die App, den Hauptmodul Display und den Controller. Zusätzlich empfängt sie Informationen von der App und aktualisiert das Display.
\
```c
code:

```

== @tcp:long
Mit der @tcp programmierung wird sichergestellt, dass Signale von der APP und dem Display in beide Richtungen übertragen werden können.
\
```c
code:

```










