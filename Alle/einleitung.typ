#import "../config.typ": *
= Einleitung

== Problemstellung
Modellautorennbahnen sind ein beliebtes Hobby, jedoch sind die Produkte, die den Markt dominieren, oft nicht auf dem neuesten Stand der Technik und bieten wenig Möglichkeiten zur Individualisierung.

Daher ist eine einstellbare Benutzeroberfläche mit konfigurierbaren Rennmodi vorgesehen. Um ein gutes Spielerlebnis zu ermöglichen, werden leistungsfähige Prozessoren und eine drahtlose Kommunikation benötigt.

== Zielsetzung
Das Ziel dieser Diplomarbeit ist die Entwicklung einer funkgesteuerten Modellautorennbahn mit erweiterbaren Funktionen. Die Rennbahn soll neben klassischen Elementen eine App zur Steuerung und Anpassung des Fahrbetriebs bieten.

*Musskriterien:*
- eigenständig fahrfähige Autos
- zuverlässige Funkverbindung zwischen Fahrzeug und Steuereinheit

*Wunschkriterien:*
- Anzeige der Rundenzeiten in der App und auf dem Display
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


// NAME? 
// Optionen: Spielnetzwerk, Projektübersicht, Gesamtprojekt, ...
// 
= Projektübersicht
#figure(
  image("/Bilder/projekt-alles.png", width: 100%),
  caption: [Gesamtprojekt Übersicht],
)

#figure(
  image("/Bilder/BlockschaltbildProjekt.svg", width: 100%),
  caption: [Blockschaltbild der Systemarchitektur],
)


#pagebreak()