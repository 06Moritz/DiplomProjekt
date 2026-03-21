#import "../config.typ": *

#aktueller_autor.update(author2) // Moritz

= @ble:both <sec_ble>
*!* @ble:long ist ein drahtloses Kommunikationsprotokoll, das speziell für die Verbindung von Geräten über kurze Entfernungen entwickelt wurde. @ble ist für Übertragung von kleinen Datenmengen optimiert und zeichnet sich durch folgende Eigenschaften aus:
- energiesparend durch geringen Datendurchsatz
- deep sleep, wenn nicht in Verwendung
- kurze Verbindungszeiten
- usw.
Es ist dadurch geeignet für batteriebetriebene Geräte. @ble basiert auf einem Server-Client Prinzip, der Server bietet seine Dienste an, über @ble advertising. Der Client sucht nach dem Server und verbindet sich mit ihm, um Daten auszutauschen. @bleSource