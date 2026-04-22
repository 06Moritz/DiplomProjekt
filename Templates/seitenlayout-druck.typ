// Kopf- und Fußzeile gespiegelt

#let aktueller_autor = state("autor", "Unbekannt")

#let page_layout(
  projekt: "",
  schuljahr: "",
  schule: "",
  body
) = {
  counter(page).update(1)
  set heading(numbering: "1.1", outlined: true)
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    
    // Kopfzeile
    header: context {
      let on_page = query(selector(heading.where(level: 1)).after(here())).filter(it => it.location().page() == here().page())
      let before_page = query(selector(heading.where(level: 1)).before(here()))
      let kapitel = if on_page.len() > 0 {
        on_page.first().body
      } else if before_page.len() > 0 {
        before_page.last().body
      } else {
        "Inhalt"
      }
      
      set text(size: 9pt, weight: "light")
      
      // Sichere Variante: Das Grid direkt in die IF-Abfrage packen
      if calc.odd(here().page()) {
        grid(columns: (1fr, 1fr, 1fr), align: (left, center, right), [#kapitel], [#projekt], [#schuljahr])
      } else {
        grid(columns: (1fr, 1fr, 1fr), align: (left, center, right), [#schuljahr], [#projekt], [#kapitel])
      }
      line(length: 100%, stroke: 0.5pt)
    },

    // Fußzeile
    footer: context {
      set text(size: 9pt, weight: "light")
      line(length: 100%, stroke: 0.5pt)
      
      let name = aktueller_autor.at(here())      
      let seite = counter(page).at(here()).first()
      let gesamt = counter(page).at(<ende_arbeit>).first()
      
      // Das Grid direkt in die IF-Abfrage packen
      if calc.odd(here().page()) {
        grid(columns: (1fr, 1fr, 1fr), align: (left, center, right), [#name], [#schule], [#seite / #gesamt])
      } else {
        grid(columns: (1fr, 1fr, 1fr), align: (left, center, right), [#seite / #gesamt], [#schule], [#name])
      }
    }
  )
  body
}