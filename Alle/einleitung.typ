#import "../config.typ": *
= Einleitung

== Problemstellung
Modellautorennbahnen sind ein beliebtes Hobby, jedoch sind die Produkte, die den Markt dominieren, oft nicht auf dem neuesten Stand der Technik und bieten wenig Möglichkeiten zur Individualisierung.

Daher ist es wichtig, eine individuell einstellbare Benutzeroberfläche und selbstkonfigurierbare Rennmodi anzubieten. 
Um das beste Spielerlebnis zu garantieren, werden schnelle Prozessoren und eine zuverlässige drahtlose Kommunikation benötigt.

== Zielsetzung
Das Ziel dieser Diplomarbeit ist die Entwicklung einer modernen, funkgesteuerten Modellautorennstrecke mit innovativen Erweiterungen. Die Rennbahn soll nicht nur die klassischen Elemente einer Modellbahn enthalten, sondern auch eine benutzerfreundliche App zur Steuerung und Anpassung des Fahrerlebnisses bieten.

*Musskriterien:*
- eigenständig fahrfähige Autos
- zuverlässige Funkverbindung zwischen Fahrzeug und Steuereinheit

*Wunschkriterien:*
- Anzeige der Rundenzeiten innerhalb der App
- konfigurierbare Fahrzeugeinstellungen über die App

*Abgrenzungskriterien*
- keine autonome Fahrfunktion
- keine Outdoor-Nutzung vorgesehen

#pagebreak()

== Produkteinsatz
*Anwendungsbereiche:*
- Freizeit- und Hobbyanwendungen

*Zielgruppen:*
- rennsportbegeisterte Kinder
- Jugendliche sowie Erwachsene mit technischem Interesse

== Umsetzung
Es wird ein Basismodul, ein Controller, ein Auto und eine Ladestation entwickelt. Das Basismodul misst die Rundenzeit durch @nfc:short, zeigt am Display und in der App die Renninformationen an. Die Autos haben eine @nfc:short\-Antenne mit der sie eine einzigartige Fahrzeugkennung an die Bahn senden, damit die Rundenzeiten zugeordnet werden können. Der Controller ist über @ble:short mit dem Fahrzeug verbunden und ermöglicht die Steuerung der Geschwindigkeit. Aufladbar sind die Controller über die Ladestation.

#figure(
  image("/Bilder/BlockschaltbildProjekt.svg", width: 100%),
  caption: [Blockschaltbild der Systemarchitektur],
)

// NAME? 
// Optionen: Spielnetzwerk, Projektübersicht, Gesamtprojekt, ...
#figure(
  fimage("/Bilder/projekt-alles.png", width: 100%),
  caption: [Gesamtprojekt Übersicht],
)

#pagebreak()