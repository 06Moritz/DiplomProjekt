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
