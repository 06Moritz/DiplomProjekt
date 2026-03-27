#import "@preview/glossy:0.9.0": glossary
// https://typst.app/universe/package/glossy/
#let eintraege = (
  abs: (short: "ABS", long: "Acrylonitrile Butadiene Styrene", description: "Schlagzäher Thermoplast mit hoher Temperaturbeständigkeit, häufig im 3D-Druck verwendet"),

  adc: (short: "ADC", long: "Analog-Digital-Wandler", description: "Wandelt analoge Spannungssignale in digitale Zahlenwerte um"),

  ask: (short: "ASK", long: "Amplitude Shift Keying", description: "Digitales Modulationsverfahren, bei dem Daten durch Variation der Trägeramplitude übertragen werden"),

  ble: (short: "BLE", long: "Bluetooth Low Energy", description: "Energiesparendes Funkprotokoll im 2,4-GHz-Band für die drahtlose Kommunikation über kurze Distanzen"),

  bootloader: (short: "Bootloader", long: "Bootloader", description: "Programm, das beim Gerätestart die Applikations-Firmware lädt oder eine Aktualisierung ermöglicht"),

  buck: (short: "Buck-Converter", long: "Abwärtswandler", description: "Getakteter Gleichspannungswandler, der eine höhere Eingangsspannung effizient auf eine niedrigere Ausgangsspannung regelt"),

  cc: (short: "CC", long: "Configuration Channel", description: "Leitungen im USB-C-Stecker zur Aushandlung von Stromrichtung und Power-Delivery-Parametern"),

  ccv: (short: "CH32V003", long: "Cost-optimized 32-bit RISC-V MCU", description: "Kostengünstiger 32-Bit-RISC-V-Mikrocontroller von WCH mit integriertem ADC"),

  clk: (short: "CLK", long: "Clock", description: "Taktsignal zur zeitlichen Synchronisation von Datenübertragungen in digitalen Schaltungen"),

  cs: (short: "CS", long: "Chip Select", description: "Aktives SPI-Steuersignal zur Auswahl eines bestimmten Slave-Geräts am Bus"),

  deepsleep: (short: "deep-sleep", long: "Deep Sleep", description: "Energiesparmodus, in dem der Mikrocontroller alle nicht benötigten Einheiten abschaltet"),

  dir: (short: "DIR", long: "Direction", description: "Steuerpin eines bidirektionalen Level Shifters zur Festlegung der Signalübertragungsrichtung"),

  easyeda: (short: "EasyEDA", long: "Easy Electronic Design Automation", description: "Browserbasiertes EDA-Tool zur Erstellung von Schaltplänen und Leiterplattenlayouts"),

  en: (short: "EN", long: "Enable", description: "Aktivierungspin zum Ein- oder Ausschalten eines ICs oder einer Funktion"),

  esp32: (short: "ESP32", long: "Espressif Systems 32-bit Microcontroller", description: "32-Bit-Mikrocontroller mit integriertem WLAN und Bluetooth von Espressif"),

  fb: (short: "FB", long: "Feedback", description: "Rückkopplungssignal in Regelkreisen zur Ausregelung von Abweichungen vom Sollwert"),

  firmware: (short: "Firmware", long: "Firmware", description: "In Hardware eingebettete Software, die grundlegende Steuerungslogik und Peripheriefunktionen bereitstellt"),

  fusion360: (short: "Fusion 360", long: "Autodesk Fusion 360", description: "CAD/CAM-Software von Autodesk zur parametrischen 3D-Modellierung und Fertigungsvorbereitung"),

  gpio: (short: "GPIO", long: "General Purpose Input/Output", description: "Frei konfigurierbarer digitaler Ein-/Ausgangspin eines Mikrocontrollers"),

  gnd: (short: "GND", long: "Ground", description: "Bezugspotential einer elektrischen Schaltung, Nullpunkt aller Spannungsmessungen"),

  hvga: (short: "HVGA", long: "Half Video Graphics Array", description: "Displayauflösung von 320 × 480 Pixeln"),

  i2c: (short: "I²C", long: "Inter-Integrated Circuit", description: "Synchrones serielles Zwei-Draht-Protokoll zur Kommunikation zwischen Mikrocontroller und Peripherie"),

  ic: (short: "IC", long: "Integrated Circuit", description: "Elektronisches Bauteil, das mehrere Schaltungsfunktionen miniaturisiert auf einem Halbleiterchip vereint"),

  id: (short: "ID", long: "Identifier", description: "Eindeutige Kennung zur Identifikation eines Objekts oder Geräts innerhalb eines Systems"),

  io0: (short: "IO0", long: "Input/Output Pin 0", description: "GPIO-Pin des ESP32, der im Low-Zustand beim Reset den UART-Bootloader-Modus aktiviert"),

  lcd: (short: "LCD", long: "Liquid Crystal Display", description: "Anzeigetechnologie, bei der Flüssigkristalle durch elektrische Felder die Lichtdurchlässigkeit der Pixel steuern"),

  ldo: (short: "LDO", long: "Low Dropout Regulator", description: "Linearer Spannungsregler mit geringer minimaler Eingangs-Ausgangs-Spannungsdifferenz"),

  led: (short: "LED", long: "Light Emitting Diode", description: "Halbleiterbauelement, das beim Stromfluss in Durchlassrichtung Licht emittiert"),

  levelshifter: (short: "Level Shifter", long: "Pegelwandler", description: "Schaltung zur Pegelanpassung von Signalen zwischen Komponenten unterschiedlicher Versorgungsspannungen"),

  lipo: (short: "LiPo", long: "Lithium-Polymer-Akku", description: "Wiederaufladbarer Lithium-Akku mit Polymer-Elektrolyt und hoher Energiedichte bei flexiblem Formfaktor"),

  m2: (short: "M2", long: "Metric 2mm", description: "Metrische Schraubengröße mit 2 mm Nenndurchmesser"),

  mac: (short: "MAC", long: "Media-Access-Control", description: "Weltweit eindeutige 48-Bit-Hardware-Adresse eines Netzwerkgeräts auf Sicherungsschicht"),

  miso: (short: "MISO", long: "Master In Slave Out", description: "SPI-Datenleitung für die Übertragung vom Slave zum Master"),

  mosfet: (short: "MOSFET", long: "Metal-Oxide-Semiconductor Field-Effect Transistor", description: "Spannungsgesteuerter Feldeffekttransistor, eingesetzt als elektronischer Schalter oder Verstärker"),

  mosi: (short: "MOSI", long: "Master Out Slave In", description: "SPI-Datenleitung für die Übertragung vom Master zum Slave"),

  nfc: (short: "NFC", long: "Near Field Communication", description: "Kontaktloser Übertragungsstandard auf Basis von RFID bei 13,56 MHz mit einer Reichweite von bis zu 10 cm"),

  pcd: (short: "PCD", long: "Proximity Coupling Device", description: "NFC-Betriebsmodus, in dem der IC als aktives Lesegerät passive Transponder ausliest"),

  pcb: (short: "PCB", long: "Printed Circuit Board", description: "Trägerplatte aus isolierendem Material mit aufgedruckten Leiterbahnen zur Verbindung elektronischer Bauteile"),

  pd: (short: "PD", long: "Power Delivery", description: "USB-Protokoll zur dynamischen Aushandlung von Spannung und Strom, unterstützt bis zu 240 W"),

  pi: (short: "PI", long: "Proportional-Integral", description: "Reglertyp mit proportionalem und integralem Anteil zur Eliminierung stationärer Regelabweichungen"),

  picc: (short: "PICC", long: "Proximity Integrated Circuit Card", description: "NFC-Betriebsmodus, in dem der IC einen passiven Transponder emuliert"),

  pla: (short: "PLA", long: "Polylactic Acid", description: "Biologisch abbaubarer Thermoplast auf Basis nachwachsender Rohstoffe, verbreitet im 3D-Druck"),

  poti: (short: "Poti", long: "Potentiometer", description: "Verstellbarer Spannungsteiler zur stufenlosen Einstellung einer Ausgangsspannung"),

  psram: (short: "PSRAM", long: "Pseudo Static RAM", description: "DRAM mit integrierter Auffrischlogik, der sich nach außen wie SRAM verhält"),

  pwm: (short: "PWM", long: "Pulsweitenmodulation", description: "Verfahren zur Leistungssteuerung durch Variation des Tastverhältnisses eines digitalen Signals"),

  ram: (short: "RAM", long: "Random Access Memory", description: "Flüchtiger Schreib-Lese-Speicher für temporäre Daten während des Betriebs"),

  rf: (short: "RF", long: "Radio Frequency", description: "Elektromagnetische Wellen im Bereich 3 kHz bis 300 GHz, genutzt für drahtlose Übertragung"),

  rfid: (short: "RFID", long: "Radio Frequency Identification", description: "Kontaktlose Identifikationstechnologie mittels elektromagnetischer Felder, Basis der NFC-Technologie"),

  ripple: (short: "Ripple", long: "Spannungswelligkeit", description: "Periodische Schwankung der Ausgangsspannung eines Schaltnetzteils durch den Schaltvorgang"),

  riscv: (short: "RISC-V", long: "Reduced Instruction Set Computer - Five", description: "Offene und lizenzfreie Befehlssatzarchitektur für Mikroprozessoren"),

  rx: (short: "RX", long: "Receive", description: "Empfangsleitung einer seriellen Schnittstelle"),

  sck: (short: "SCK", long: "Serial Clock", description: "Vom Master erzeugte Taktleitung des SPI-Busses"),

  scl: (short: "SCL", long: "Serial Clock Line", description: "Vom Master erzeugte Taktleitung des I²C-Busses"),

  sd: (short: "SD", long: "Secure Digital", description: "Standard für Flash-Speicherkarten zur nichtflüchtigen Datenspeicherung"),

  sda: (short: "SDA", long: "Serial Data Line", description: "Bidirektionale Datenleitung des I²C-Busses"),

  spi: (short: "SPI", long: "Serial Peripheral Interface", description: "Synchrones serielles Vier-Draht-Protokoll zur schnellen Kommunikation zwischen Mikrocontroller und Peripherie"),

  tcp: (short: "TCP", long: "Transmission Control Protocol", description: "Verbindungsorientiertes Transportprotokoll mit garantierter, geordneter Datenübertragung"),

  tft: (short: "TFT", long: "Thin-Film Transistor", description: "LCD-Variante, bei der jeder Pixel durch einen eigenen Dünnschichttransistor angesteuert wird"),

  ti: (short: "TI", long: "Texas Instruments", description: "Amerikanischer Halbleiterhersteller, bekannt für Mikrocontroller, Analog-ICs und Leistungselektronik"),

  tmos: (short: "TMOS", long: "Task Management Operating System", description: "Echtzeitbetriebssystem von WCH zur Aufgaben- und Ressourcenverwaltung in Bluetooth-Chips"),

  tx: (short: "TX", long: "Transmit", description: "Sendeleitung einer seriellen Schnittstelle"),

  uart: (short: "UART", long: "Universal Asynchronous Receiver-Transmitter", description: "Asynchrone serielle Schnittstelle zur Vollduplex-Datenübertragung ohne gemeinsames Taktsignal"),

  ui: (short: "UI", long: "User Interface", description: "Gesamtheit aller Bedien- und Anzeigeelemente zur Interaktion zwischen Benutzer und System"),

  usb: (short: "USB", long: "Universal Serial Bus", description: "Serieller Busstandard zur Datenübertragung und Stromversorgung zwischen Geräten"),

  usbc: (short: "USB-C", long: "USB Type-C", description: "Symmetrischer USB-Steckverbinder mit Power Delivery und hohen Datenraten, steckrichtungsunabhängig"),

  uuid: (short: "UUID", long: "Universally Unique Identifier", description: "128-Bit-Kennung zur global eindeutigen Identifikation von Objekten in verteilten Systemen"),

  via: (short: "Via", long: "Durchkontaktierung", description: "Metallisierte Bohrung in einer Leiterplatte zur elektrischen Verbindung verschiedener Kupferlagen"),

  wifi: (short: "WiFi", long: "Wireless Fidelity", description: "Drahtloser Netzwerkstandard nach IEEE 802.11 zur lokalen Vernetzung über Funkwellen"),
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
  
  block(width: 100%, below: 1.5em, {
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