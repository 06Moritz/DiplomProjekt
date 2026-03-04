#import "../config.typ": *

#counter(page).update(1)

// Seitenlayout für das Inhaltsverzeichnis
#set page(
  numbering: "I",
  margin: (top: 2.5cm),
  // Kopfzeile
  header: context {
    set text(size: 9pt, weight: "light")
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [#projekt], 
      [#schuljahr]
    )
    //v(-0.5em)
    line(length: 100%, stroke: 0.5pt)
  },

  // Fußzeile
    footer: context {
      set text(size: 9pt, weight: "light")
      line(length: 100%, stroke: 0.5pt)
      //v(0.5em)
      let seite = counter(page).at(here()).first()
      let gesamt_iv = counter(page).at(<ende_iv>).first()
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#schule], 
        [#counter(page).display("I") / #numbering("I", gesamt_iv)]
      )
    }
)

// Styling für das Inhaltsverzeichnis
#show outline.entry: it => {
  if it.level == 1 {
    v(1.5em, weak: true) // Deutlicher Block-Abstand
    strong(it)           // Alles in Ebene 1 fett
  } else {
    it
  }
}

// Inhaltsverzeichnis
#outline(title: "Inhaltsverzeichnis", indent: 1em)

#metadata("end-iv")
<ende_iv>
#pagebreak()
