
#let start_layout(body) = {
  set heading(numbering: none, outlined: false)
  set page(
    margin: (top: 4cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
    header: context {
      grid(
        columns: (1fr, 2fr), 
        gutter: 1cm,
        align: (left + horizon, right + horizon),
        image("../Bilder/HTBLuVA_Salzburg_Logo.svg", width: 80%),
        text(size: 10pt)[
          #set align(right)
          *HÖHERE TECHNISCHE BUNDESLEHR- UND \
          VERSUCHSANSTALT SALZBURG* \
          Elektronik und technische Informatik
        ]
      )
      v(-0.5cm)
      line(length: 100%, stroke: 0.5pt)
    }
  )
  body
}