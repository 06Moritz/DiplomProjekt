#import "Templates/seitenlayout.typ": page_layout, aktueller_autor
#import "Templates/startlayout.typ": start_layout

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
    lang: "de"
  )
  set par(
    justify: true,
    leading: 0.75em
  )
  set page(
    margin: (
      top: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
      bottom: 2.5cm,
    ),
  )
  show heading: it => {
    it
    if it.level == 1 { 
      v(1cm, weak: true) 
    }
    else if it.level == 2 { 
      v(0.75cm, weak: true) 
    }
    else { 
      v(0.5cm, weak: true) 
    }
  }
  body
}

#let t = metadata("tab")

#let tabed(c) = {
  let cs = c.children.split(metadata("tab"))
  context grid(
    columns: (2cm,) * 8,
    row-gutter: par.leading,
    ..cs.fold((0, ()), ((col, arr), c) => {
      let s = c.sum()
      let w = int(calc.div-euclid(measure(s).width.pt(), 2cm.pt())) + 1
      if col + w > 8 {
        let (b, t) = s.children.map(t => if t.has("text") {t.text.split(" ")} else {t}).flatten().fold(([],()), ((tmp, res), word) => {
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
          } else {(tmp + sym.space + word, res)}
        })
        (calc.rem(col + w, 8), arr + (grid.cell(colspan: 8-col, t), grid.cell(colspan:  w - 8 + col, b)))
      } else {
        (calc.rem(col + w, 8), arr + (grid.cell(colspan: w, s),))
      }
    }).at(1)
  )
}

