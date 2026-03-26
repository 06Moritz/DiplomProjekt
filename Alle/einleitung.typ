= Einleitung

== Problemstellung
*!* Modellautorennbahnen sind ein beliebtes Hobby, jedoch sind die Produkte die den Markt dominieren oft nicht auf dem neusten stand der Technik und bieten wenig Möglichkeiten zur Individualisierung.

Daher ist es wichtig, dass eine individuell einstellbare Benutzeroberfläche und selbstkonfigurierbare Rennmmodi angeboten werden. 
Um das beste Spielerlebnis zu garantieren, werden schnelle Prozessoren und eine zuverlässige drahtlose Kommunikation benötigt. 


== Zielsetzung
Das Ziel dieser Diplomarbeit ist die Entwicklung einer modernen, funkgesteuerten Modellautorennstrecke mit innovativen Erweiterungen. Die Rennbahn soll nicht nur die klassischen Elemente einer Modellbahn enthalten, sondern auch eine benutzerfreundliche App zur Steuerung und Anpassung des Fahrerlebnis bieten.

/* Ziel ist die Entwicklung einer Rennbahn mit funkferngesteuerten Autos.

Das Hauptmodul steuert Zeitmessung, User Interface und Ladestationen. */


*Musskriterien:*
- eigenständig fahrfähige Autos
- zuverlässige Funkverbindung zwischen Fahrzeug und Steuereinheit

*Wunschkriterien:*
- Anzeige der Rundenzeiten innerhalb der App
- konfigureirbare Fahrzeugeinstellungen über die App

*Abgrenzungskriterien*
- keine autonome Fahrfunktion
- keine Outdoor-Nutzung vorgesehen

#pagebreak()

== Produkteinsatz
*Anwendungsbereiche:*
- Freizeit- und Hoppyanwengungen

*Zielgruppen:*
- rennsportbegeisterte Kinder
- Jugendlich sowie Erwachsene mit technischem Interesse

== Umsetzung
Es wird ein Hauptmodul, ein Controller, ein Auto und eine Ladestation entwickelt. Das Hauptmodul misst die Rundenzeit durch NFC, zeigt am Display und in der App die Renninformationen an. Die Autos haben eine NFC Antenne mit der sie eine einzigartige Fahrzeugkennung an die Bahn senden, damit die Rundenzeiten zugeordnet werden können. Der Controller ist über BLE mit dem Fahrzeug verbunden und ermöglicht die Steuerung der Geschwindigkeit. Aufladbar sind die Controller über die Ladestation.

#figure(
  image("/Bilder/BlockschaltbildProjekt.svg", width: 100%),
  caption: [Blockschaltbild der Systemarchitektur],
)

#pagebreak()