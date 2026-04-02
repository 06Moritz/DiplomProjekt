#import "@preview/glossy:0.9.0": glossary
// https://typst.app/universe/package/glossy/
#let eintraege = (
  pcb: (short: "PCB", long: "Printed Circuit Board", description: "Leiterplatte, auf der elektronische Bauteile montiert und verbunden werden"),

  tmos: (short: "TMOS", long: "Task Management Operating System", description: "Echtzeitbetriebssystem von WCH zur Verwaltung von Aufgaben und Ressourcen in Bluetooth-Chips"),

  led: (short: "LED", long: "Light Emitting Diode", description: "Halbleiterbauelement, das beim Durchfluss von Strom Licht emittiert"),

  riscv: (short: "RISC-V", long: "Reduced Instruction Set Computer - Five", description: "Offene und lizenzfreie Befehlssatzarchitektur für Mikroprozessoren"),

  ble: (short: "BLE", long: "Bluetooth Low Energy", description: "Energiesparende Funktechnologie für die drahtlose Kommunikation über kurze Distanzen"),

  pwm: (short: "PWM", long: "Pulsweitenmodulation", description: "Verfahren zur Steuerung der Leistung elektrischer Geräte durch Variation des Tastverhältnisses eines Signals"),

  deepsleep: (short: "deep-sleep", long: "deepsleep", description: "Energiesparmodus von Mikrocontrollern, in dem alle nicht benötigten Funktionen abgeschaltet werden um den Stromverbrauch zu minimieren"),

  mac: (short: "MAC", long: "Media-Access-Control", description: "Eindeutige Hardware-Adresse, die jedem Netzwerkgerät fest zugewiesen ist und zur Identifikation im Netzwerk dient"),

  picc: (short: "PICC", long: "Proximity Integrated Circuit Card", description: "NFC-Betriebsmodus, in dem der IC einen passiven Transponder emuliert und von einem aktiven NFC-Lesegerät ausgelesen wird"),

  pcd: (short: "PCD", long: "Proximity Coupling Device", description: "NFC-Betriebsmodus, in dem der IC als aktives Lesegerät fungiert und passive NFC-Transponder ausliest"),

  uuid: (short: "UUID", long: "Universally Unique Identifier", description: "128-Bit-Kennung, die zur eindeutigen Identifikation von Objekten oder Entitäten in verteilten Systemen verwendet wird"),

  ldo: (short: "LDO", long: "Low Dropout Regulator", description: "Linearer Spannungsregler, der eine stabile Ausgangsspannung auch bei geringer Differenz zur Eingangsspannung liefert"),

  nfc: (short: "NFC", long: "Near Field Communication", description: "Übertragungsstandard für den kontaktlosen Datenaustausch über kurze Distanzen von bis zu 10 cm bei 13,56 MHz"),

  adc: (short: "ADC", long: "Analog-Digital-Wandler", description: "Bauteil, das analoge Messsignale in digitale Werte umwandelt, die ein Mikrocontroller verarbeiten kann"),

  tcp: (short: "TCP", long: "Transmission Control Protocol", description: "Verbindungsorientiertes Netzwerkprotokoll, das eine zuverlässige und geordnete Übertragung von Datenpaketen sicherstellt"),

  pd: (short: "PD", long: "Power Delivery", description: "USB-Standard zur Aushandlung von Spannung und Strom zwischen Ladegerät und Gerät, ermöglicht Leistungen bis zu 240 W"),

  ic: (short: "IC", long: "Integrated Circuit", description: "Elektronisches Bauteil, das viele Schaltungsfunktionen miniaturisiert auf einem einzigen Halbleiterchip vereint"),

  mosfet: (short: "MOSFET", long: "Metal-Oxide-Semiconductor Field-Effect Transistor", description: "Feldeffekttransistor, der als spannungsgesteuerter elektronischer Schalter oder Verstärker eingesetzt wird"),

  buck: (short: "Buck-Converter", long: "Abwärtswandler", description: "Schaltregler, der eine höhere Eingangsspannung durch getaktetes Schalten effizient in eine niedrigere Ausgangsspannung umwandelt"),

  fb: (short: "FB", long: "Feedback", description: "Rückkopplungssignal, das in Regelkreisen verwendet wird, um den Ausgang eines Systems auf den gewünschten Sollwert zu regeln"),

  spi: (short: "SPI", long: "Serial Peripheral Interface", description: "Synchrones serielles Kommunikationsprotokoll mit vier Leitungen zur schnellen Datenübertragung zwischen Mikrocontroller und Peripheriegeräten"),

  poti: (short: "Poti", long: "Potentiometer", description: "Verstellbarer Widerstand, dessen Abgriffspannung sich durch Drehen oder Schieben stufenlos einstellen lässt"),

  levelshifter: (short: "Level Shifter", long: "Pegelwandler", description: "Schaltung zur Anpassung von Signalpegeln zwischen Komponenten mit unterschiedlichen Versorgungsspannungen"),

  cc: (short: "CC", long: "Configuration Channel", description: "Leitungen im USB-C-Stecker, über die Stromrichtung, Leistungsklasse und Power-Delivery-Parameter ausgehandelt werden"),

  ask: (short: "ASK", long: "Amplitude Shift Keying", description: "Digitales Modulationsverfahren, bei dem binäre Daten durch Variation der Amplitude eines Trägersignals übertragen werden"),

  via: (short: "Via", long: "Durchkontaktierung", description: "Metallisierte Bohrung in einer Leiterplatte, die elektrische Verbindungen zwischen verschiedenen Kupferlagen herstellt"),

  ti: (short: "TI", long: "Texas Instruments", description: "Amerikanischer Halbleiterhersteller, bekannt für Mikrocontroller, Analog-ICs und Leistungselektronik"),

  usb: (short: "USB", long: "Universal Serial Bus", description: "Weit verbreiteter Standard für die serielle Datenübertragung und Stromversorgung zwischen Geräten und Computern"),

  usbc: (short: "USB-C", long: "USB Type-C", description: "Symmetrischer USB-Steckverbinder, der unabhängig von der Ausrichtung eingesteckt werden kann und hohe Datenraten sowie Power Delivery unterstützt"),

  ripple: (short: "Ripple", long: "Spannungswelligkeit", description: "Periodische Schwankung der Ausgangsspannung eines Netzteils oder Spannungsreglers, die durch den Schaltvorgang entsteht"),

  rf: (short: "RF", long: "Radio Frequency", description: "Elektromagnetische Wellen im Frequenzbereich von 3 kHz bis 300 GHz, die für drahtlose Kommunikation genutzt werden"),

  rfid: (short: "RFID", long: "Radio Frequency Identification", description: "Technologie zur kontaktlosen Identifikation von Objekten mittels elektromagnetischer Felder, Grundlage der NFC-Technologie"),

  easyeda: (short: "EasyEDA", long: "Easy Electronic Design Automation", description: "Browserbasierte Software für die Erstellung von Schaltplänen und Leiterplattenlayouts"),

  wifi: (short: "WiFi", long: "Wireless Fidelity", description: "Drahtloser Netzwerkstandard auf Basis von IEEE 802.11 zur Vernetzung von Geräten über Funkwellen"),

  i2c: (short: "I²C", long: "Inter-Integrated Circuit", description: "Synchrones serielles Zwei-Draht-Protokoll zur Kommunikation zwischen Mikrocontrollern und Peripheriegeräten auf kurzer Distanz"),

  uart: (short: "UART", long: "Universal Asynchronous Receiver-Transmitter", description: "Asynchrone serielle Schnittstelle zur Datenübertragung zwischen zwei Geräten ohne gemeinsames Taktsignal"),

  rx: (short: "RX", long: "Receive", description: "Empfangsleitung einer seriellen Schnittstelle, über die eingehende Datenbits empfangen werden"),

  tx: (short: "TX", long: "Transmit", description: "Sendeleitung einer seriellen Schnittstelle, über die ausgehende Datenbits übertragen werden"),

  gnd: (short: "GND", long: "Ground", description: "Bezugspotential elektrischer Schaltungen, das als Nullpunkt für alle Spannungsmessungen dient"),

  m2: (short: "M2", long: "Metric 2mm", description: "Metrische Schraubengröße mit 2 mm Nenndurchmesser, häufig zur Befestigung kleiner Bauteile in der Elektronik"),

  en: (short: "EN", long: "Enable", description: "Aktivierungspin, über den ein IC oder eine Funktion ein- oder ausgeschaltet werden kann"),

  io0: (short: "IO0", long: "Input/Output Pin 0", description: "GPIO-Pin des ESP32, der im Low-Zustand beim Reset den Bootloader-Modus aktiviert und die Programmierung per UART ermöglicht"),

  pi: (short: "PI", long: "Proportional-Integral", description: "Reglertyp, der aus einem proportionalen und einem integralen Anteil besteht und zur Ausregelung von stationären Regelabweichungen eingesetzt wird"),

  sda: (short: "SDA", long: "Serial Data Line", description: "Bidirektionale Datenleitung des I²C-Busses, über die Daten zwischen Master und Slave übertragen werden"),

  clk: (short: "CLK", long: "Clock", description: "Taktsignal, das die zeitliche Synchronisation von Datenübertragungen und Verarbeitungsschritten in digitalen Schaltungen steuert"),

  scl: (short: "SCL", long: "Serial Clock Line", description: "Taktleitung des I²C-Busses, die vom Master erzeugt wird und die Übertragungsgeschwindigkeit vorgibt"),

  esp32: (short: "ESP32", long: "Espressif Systems 32-bit Microcontroller", description: "Mikrocontroller mit integriertem WLAN und Bluetooth, der häufig in IoT- und Embedded-Projekten eingesetzt wird"),

  ram: (short: "RAM", long: "Random Access Memory", description: "Flüchtiger Arbeitsspeicher, der während des Betriebs schnellen Lese- und Schreibzugriff auf temporäre Daten ermöglicht"),

  psram: (short: "PSRAM", long: "Pseudo Static RAM", description: "Dynamischer Speicher mit integrierter Auffrischlogik, der sich wie statischer RAM verhält und kostengünstig größere Speichermengen bereitstellt"),

  id: (short: "ID", long: "Identifier", description: "Eindeutige Kennung zur Identifikation eines Objekts, Geräts oder Datensatzes innerhalb eines Systems"),

  gpio: (short: "GPIO", long: "General Purpose Input/Output", description: "Frei konfigurierbarer digitaler Ein-/Ausgangspin eines Mikrocontrollers zur Ansteuerung von Peripheriegeräten"),

  firmware: (short: "Firmware", long: "Firmware", description: "In einem Gerät fest eingebettete Software, die grundlegende Hardware-Funktionen und Steuerungslogik bereitstellt"),

  bootloader: (short: "Bootloader", long: "Bootloader", description: "Programm, das beim Start eines Mikrocontrollers ausgeführt wird und die eigentliche Applikations-Firmware lädt oder aktualisiert"),

  mosi: (short: "MOSI", long: "Master Out Slave In", description: "Datenleitung des SPI-Busses, über die der Master Daten an den Slave sendet"),

  miso: (short: "MISO", long: "Master In Slave Out", description: "Datenleitung des SPI-Busses, über die der Slave Daten an den Master zurücksendet"),

  sck: (short: "SCK", long: "Serial Clock", description: "Taktleitung des SPI-Busses, die vom Master erzeugt wird und die Übertragungsgeschwindigkeit vorgibt"),

  cs: (short: "CS", long: "Chip Select", description: "Steuersignal des SPI-Busses, das einen bestimmten Slave aktiviert und so die gleichzeitige Nutzung mehrerer Geräte am selben Bus ermöglicht"),

  tft: (short: "TFT", long: "Thin-Film Transistor", description: "Display-Technologie, bei der jeder Pixel durch einen eigenen Dünnschichttransistor angesteuert wird und so hohe Bildqualität und schnelle Reaktionszeiten ermöglicht"),

  sd: (short: "SD", long: "Secure Digital", description: "Weit verbreiteter Standard für Flash-Speicherkarten, der in vielen Geräten zur Datenspeicherung eingesetzt wird"),

  pla: (short: "PLA", long: "Polylactic Acid", description: "Biologisch abbaubarer Thermoplast auf Basis nachwachsender Rohstoffe, der aufgrund seiner einfachen Verarbeitung häufig im 3D-Druck verwendet wird"),

  fusion360: (short: "Fusion 360", long: "Autodesk Fusion 360", description: "CAD/CAM-Software von Autodesk zur parametrischen 3D-Modellierung, Simulation und Fertigungsvorbereitung"),

  lcd: (short: "LCD", long: "Liquid Crystal Display", description: "Anzeigetechnologie auf Basis von Flüssigkristallen, die durch elektrische Felder die Lichtdurchlässigkeit einzelner Pixel steuern"),

  hvga: (short: "HVGA", long: "Half Video Graphics Array", description: "Displayauflösung von 320 × 480 Pixeln, die häufig in kleinen eingebetteten Displays verwendet wird"),

  dir: (short: "DIR", long: "Direction", description: "Steuerpin eines bidirektionalen Level Shifters, der die Übertragungsrichtung des Signals festlegt"),

  lipo: (short: "LiPo", long: "Lithium-Polymer-Akku", description: "Wiederaufladbarer Lithium-Akku mit Polymer-Elektrolyt, der eine hohe Energiedichte bei flexiblem Formfaktor bietet"),

  ccv: (short: "CH32V003", long: "Cost-optimized 32-bit RISC-V MCU", description: "Kostengünstiger 32-Bit-RISC-V-Mikrocontroller von WCH mit integriertem ADC"),

  abs: (short: "ABS", long: "Acrylonitrile Butadiene Styrene", description: "Schlagzäher thermoplastischer Kunststoff mit guter Temperaturbeständigkeit, der häufig für technische 3D-Druckteile verwendet wird"),

  ui: (short: "UI", long: "User Interface", description: "Gesamtheit aller Bedienelemente und Anzeigekomponenten, über die ein Benutzer mit einem System interagiert"),

  lut: (short: "LUT", long: "Look-Up Table", description: "Datenstruktur, die vorgefertigte Werte für bestimmte Eingaben enthält, um Berechnungen zu beschleunigen oder komplexe Funktionen zu implementieren")

  cccv: (short: "CC-CV", long: "Constant Current Constant Voltage", description: "Ladeverfahren, bei dem zunächst mit konstantem Strom geladen wird und nach Erreichen einer bestimmten Spannung auf konstante Spannung umgeschaltet wird, um die Batterie schonend zu laden")
)

#let my-theme = (
  section: (title, body) => {
    heading(level: 1, title)
    body
  },

  group: (name, index, total, body) => {
    if name != "" and total > 1 {
      heading(level: 2, name)
    }
    body
  },entry: (entry, index, total) => {
  let pages = entry.pages.join(", ")
  
  block(width: 100%, below: 1.5em, breakable: false, {
    grid(
      columns: (auto, auto),
      column-gutter: 1em,
      align: (left + bottom, right + bottom),
      {
        strong(entry.short)
        if entry.long != none [
          #h(0.2em)#text(fill: luma(0))[– #entry.long]
        ]
      },
      text(size: 0.75em, fill: luma(50), "[" + pages + "]")

    )
    if entry.description != none {
      pad(top: 0.05em,
        text(size: 0.9em, fill: luma(90), entry.description)
      )
    }
  })
}
)

#glossary(title: "Glossar", theme: my-theme, sort: true, show-all: false)

#pagebreak()