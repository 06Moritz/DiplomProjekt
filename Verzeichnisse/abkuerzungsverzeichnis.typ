#import "@preview/glossy:0.9.0": glossary

// Beispiele mit @... im Text verwenden
#let eintraege = (
  ki: (short: "KI", long: "Künstliche Intelligenz", description: "Teilgebiet der Informatik..."),
  nfc: (short: "NFC", long: "Near Field Communication", description: "Funkstandard blablabla"),
  hi: (short: "Hi", long: "Hallo", description: "Ein Gruß"),
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