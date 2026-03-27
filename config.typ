#import "Templates/seitenlayout.typ": aktueller_autor, page_layout
#import "Templates/startlayout.typ": start_layout
#import "@preview/glossy:0.9.0": glossary, init-glossary
#import "Verzeichnisse/abkuerzungsverzeichnis.typ": eintraege
#import "@preview/muchpdf:0.1.2": muchpdf


#let author1 = "Melanie Koch"
#let author2 = "Moritz Prodinger"
#let author3 = "Magdalena Reitsamer"
#let projekt = "CorsaNuova"
#let klasse = "5AHEL"
#let schuljahr = "2025/2026"
#let schule = "HTBLuVA - Elektronik"



#let apply_styles(body) = {
  set text(
    font: "Lucida Sans",
    size: 12pt,
    lang: "de",
  )
  set par(
    justify: true,
    leading: 1em,
  )
  set text(hyphenate: false)
  set page(
    margin: (
      top: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
      bottom: 2.5cm,
    ),
  )

  set table(
    stroke: 0.5pt + gray,
    inset: 10pt, // Optional: Erhöht den Abstand vom Text zum Rand
  )


   show heading.where(level: 4): set heading(numbering: none, outlined: false)
   
  show heading: it => {
    if it.level == 1 {
      v(1.5cm, weak: true)
    } else if it.level == 2 {
      v(1cm, weak: true)
    } else {
      v(1cm, weak: true)
    }

    it

    if it.level == 1 {
      v(1cm, weak: true)
    } else if it.level == 2 {
      v(0.75cm, weak: true)
    } else {
      v(0.5cm, weak: true)
    }
  }


  /*
  show figure: it => {
    it
    v(1em, weak: true)
  }
  */
  show figure.caption: set text(fill: gray.darken(50%), size: 10pt)

  show raw.where(block: true): set text(1em / 0.9)
  show raw.where(block: true): block.with(
    fill: luma(100%),
    stroke: 0.5pt + gray.darken(0%),
    //fill: luma(240), // oder z.B. 95%
    //stroke: 0.5pt + luma(200), // oder z.B. 70%
    inset: 10pt,
    radius: 2pt,
    width: 100%,
  )
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Optional: Stil für Unterüberschriften (Ebene 3 und tiefer)
  show heading: it => {
    if it.level > 3 {
      set text(weight: "semibold", size: 11pt) // Optional: Stil anpassen
      v(0.5em) // Kleiner Abstand davor
      it.body
      v(0.2em) // Kleiner Abstand danach
    } else {
      it
    }
  }

  body
}

// framed-image:
#let fimage(path, ..args) = {
  rect(
    stroke: 0.5pt + gray.darken(0%),
    inset: 0pt,
    radius: 0pt,
    image(path, ..args),
  )
}

#let t = metadata("tab")



#let tabed(c) = {
  let cs = c.children.split(metadata("tab"))
  context grid(
    columns: (2cm,) * 8,
    row-gutter: par.leading,
    ..cs
      .fold((0, ()), ((col, arr), c) => {
        let s = c.sum()
        let w = int(calc.div-euclid(measure(s).width.pt(), 2cm.pt())) + 1
        if col + w > 8 {
          let (b, top) = s
            .children
            .map(t => if t.has("text") { t.text.split(" ") } else { t })
            .flatten()
            .fold(([], ()), ((tmp, res), word) => {
              if res == () {
                let new = if tmp == [] {
                  if word == [ ] { tmp } else { word }
                } else if word == [ ] {
                  tmp + sym.space
                } else {
                  tmp + sym.space + word
                }
                if measure(new).width > (8 - col) * 2cm {
                  (word, tmp)
                } else {
                  (new, ())
                }
              } else { (tmp + sym.space + word, res) }
            })
          (calc.rem(col + w, 8), arr + (grid.cell(colspan: 8 - col, top), grid.cell(colspan: w - 8 + col, b)))
        } else {
          (calc.rem(col + w, 8), arr + (grid.cell(colspan: w, s),))
        }
      })
      .at(1)
  )
}


