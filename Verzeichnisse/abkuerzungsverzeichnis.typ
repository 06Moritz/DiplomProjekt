#import "@preview/glossy:0.9.0": glossary

// Beispiele mit @... im Text verwenden
#let eintraege = (
  ki: (short: "KI", long: "Künstliche Intelligenz", description: "Teilgebiet der Informatik..."),
  pcb: (short: "PCB", long: "Printed Circuit Board", description: "Leiterplatte, auf der elektronische Bauteile montiert werden"),
  ble: (short: "BLE", long: "Bluetooth Low Energy", description: "Energiesparende Funktechnologie für die drahtlose Kommunikation"),
  pwm: (short: "PWM", long: "Pulsweitenmodulation", description: "Verfahren zur Steuerung der Leistung von elektrischen Geräten"),
  ldo: (short: "LDO", long: "Low Dropout Regulator", description: "Spannungsregler, der auch bei geringer Eingangsspannung stabil arbeitet"),
  nfc: (short: "NFC", long: "Near Field Communication", description: "Technologie für die drahtlose Kommunikation über kurze Distanzen"),
  
  adc: (short: "ADC", long: "Analog-Digital-Wandler", description: "Bauteil zur Umwandlung von analogen Signalen in digitale Werte"),
  uart: (short: "UART", long: "Universal Asynchronous Receiver Transmitter", description: "Kommunikationsschnittstelle für asynchrone Datenübertragung"),
  spi: (short: "SPI", long: "Serial Peripheral Interface", description: "Kommunikationsprotokoll für die serielle Datenübertragung zwischen Mikrocontrollern und Peripheriegeräten"),
  i2c: (short: "I2C", long: "Inter-Integrated Circuit", description: "Kommunikationsprotokoll für die serielle Datenübertragung zwischen Mikrocontrollern und Peripheriegeräten"),
  usb: (short: "USB", long: "Universal Serial Bus", description: "Standard für die Verbindung von Computern und Peripheriegeräten"),
  riscv: (short: "RISC-V", long: "Reduced Instruction Set Computer V", description: "Offene Befehlssatzarchitektur für Mikroprozessoren"),

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
  },

  entry: (entry, index, total) => {
    let output = [*#entry.short*#entry.label]
    if entry.long != none {
      output = [#output -- #entry.long]
    }
    if entry.description != none {
      output = [#output: #emph(entry.description)]
    }
    block(
      grid(
        columns: (auto, 1fr, auto),
        gutter: 0.5em,
        output,
        repeat([#h(0.05em).#h(0.05em)]),
        entry.pages.join(", "),
      )
    )
  }
)

#glossary(title: "Abkürzungsverzeichnis", theme: my-theme, sort: true, show-all: true)

#pagebreak()