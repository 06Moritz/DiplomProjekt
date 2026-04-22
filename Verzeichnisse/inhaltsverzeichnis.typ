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

    // Falls Kopfzeile auch gespiegelt:
    /* if calc.odd(seite) {
      // Ungerade Seite (Rechts): Projekt links, Schuljahr rechts
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#projekt], 
        [#schuljahr]
      )
    } else {
      // Gerade Seite (Links): Schuljahr links, Projekt rechts
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#schuljahr],
        [#projekt]
      ) 
    }*/

    line(length: 100%, stroke: 0.5pt)
  },

  // Fußzeile
 footer: context {
      set text(size: 9pt, weight: "light")
      line(length: 100%, stroke: 0.5pt)
      
      let seite = counter(page).at(here()).first()
      let gesamt_iv = counter(page).at(<ende_iv>).first()
      
      // Variable für die Seitenzahlanzeige erstellen, um Code-Duplikate zu vermeiden
      let seiten_anzeige = [#counter(page).display("I") / #numbering("I", gesamt_iv)]

      if calc.odd(seite) {
        // Ungerade Seite (Rechts): Schule links, Seite rechts
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [#schule], 
          [#seiten_anzeige]
        )
      } else {
        // Gerade Seite (Links): Seite links, Schule rechts
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [#seiten_anzeige],
          [#schule]
        )
      }
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
#outline(
  title: "Inhaltsverzeichnis", 
  indent: 1em,
  depth: 3, // Zeige bis zu 3 Ebenen an
  target: heading.where(outlined: true).before(<anhang_start>)
)

#metadata("end-iv")
<ende_iv>
#pagebreak()
