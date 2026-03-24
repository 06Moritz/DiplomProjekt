#let schriftfeld(
    dateiname:      "Beilage",
    name:           "",
    toleranz:       "",
    werkstoff:      "",
    id_nr:          "5AHEL",
    gez:            "",
    geprueft:       "",
    betreuer:       "LinR",
    dokumentart:    "",
    freigabe:       "",
    projekt:        "",
    beschreibung:   "",
    version:        "1.0",
    revision:       "1",
    status:         "",
    massstab:       "ohne",
    sprache:        "DE",
    datum:          "",
    blatt:          "1",
    blaetter:       "1",
) = {
    box(width: 19cm, height: 4cm, {
        set grid(stroke: 1.2pt + black)
        
        let f(titel, inhalt) = {
            block(width: 100%, height: 100%, inset: (top: 3pt, left: 2pt, right: 2pt, bottom: 7pt))[
            #align(top + left, text(size: 6pt, titel))
            #align(center + bottom, text(size: 10pt, inhalt))
            ]
        }
        
        grid(
            columns: (1fr, 1fr, 1fr), 
            rows: (1fr, 3fr),               
            f("Sachnummer, Dateiname:", dateiname),
            f("Name:", text(size: 14pt, name)),
            [
                #grid(
                    rows: (100%),
                    columns: (2cm, 1.5fr),
                    f("Toleranz:", text(size: 12pt, toleranz)),
                    f("Werkstoff:", text(size: 12pt, werkstoff))
                )
            ],
            grid.cell(inset: (top: 3pt, left: 2pt, right: 2pt, bottom: 12pt))[
                #align(center + bottom)[
                    #stack(
                        dir: ttb,
                        //spacing: -1pt,
                        v(-12pt),
                        image("../Bilder/HTBLuVA_Salzburg_Logo.svg", width: 70%),
                        v(-5pt),
                        text(size: 13pt, weight: "bold")[HTBLuVA Salzburg],
                        v(12pt),
                        //text(size: 10pt, weight: "regular")[Elektronik & technische Informatik],
                        text(size: 9pt, weight: "bold")[Elektronik & technische Informatik]
                    )
                ]
            ],
            [
                #grid(
                    columns: (100%),
                    rows: (1fr, 2fr),
                    [
                        #grid(
                            rows: (100%),
                            columns: (1.5fr, 1fr, 1fr, 1fr),
                            f("ID-Nr.:", id_nr),
                            f("Gez.:", gez),
                            f("Geprüft:", geprueft),
                            f("Betreuer:", betreuer)
                        )
                    ], 
                    block(width: 100%, height: 100%, inset: (top: 3pt, left: 2pt, right: 2pt, bottom: 12pt))[
                        #align(top + left, text(size: 6pt)[Benennung:])
                        #align(center + bottom)[
                            #stack(
                                dir: ttb,
                                spacing: 15pt,
                                text(size: 20pt, weight: "regular")[#projekt],
                                text(size: 12pt)[#beschreibung]
                            )
                        ]
                    ] 
                )
            ],
            [
                #grid(
                    columns: (100%),
                    rows: (1fr, 1fr, 1fr),
                    [
                        #grid(
                            rows: (100%),
                            columns: (1fr, 1.7cm),
                            f("Dokumentart:", text(size: 12pt, dokumentart)),
                            f("Freigabe:", freigabe),
                        )
                    ], 
                    [
                        #grid(
                            rows: (100%),
                            columns: (2cm, 1fr, 2.2fr),
                            f("Version:", text(size: 12pt, version)),
                            f("Revision:", text(size: 12pt, revision)),
                            f("Dokumentstatus:", text(size: 12pt, status))
                        )
                    ], 
                    [
                        #grid(
                            rows: (100%),
                            columns: (1.15cm, 0.85cm, 1fr, 0.85cm, 0.85cm),
                            f("Maßstab:", massstab),
                            f("Spr.:", sprache),
                            f("Datum:", datum),
                            f("Blatt:", blatt),
                            f("Blätter:", blaetter)
                        )
                    ]
                )
            ] 
        )
    })
}


// Hochformat-Rahmen
#let rahmen-hoch(..args) = {
  let body = args.pos().at(0)
  let s_box = schriftfeld(..args.named())

  set page(
    margin: (top: 1.5cm, bottom: 5.5cm, left: 1.5cm, right: 1.5cm),
    background: {
      let rand = 1cm
      place(center + top, dy: rand)[
        #rect(width: 100% - 2cm, height: 100% - (2 * rand), stroke: 1.2pt + black)
      ]
      place(bottom + center, dy: -rand)[
        #box[#s_box]
      ]
    }
  )
  align(center + horizon, body)
}


// wird im Hochformat im Dokument angezeigt
#let rahmen-quer(..args) = {
    let body = args.pos().at(0)
    let s_box = schriftfeld(..args.named())

    set page(
        flipped: false,
        margin: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt),
    )

    context {
        let pw = page.width
        let ph = page.height
        let rand = 1cm

        place(center + horizon,
            rotate(-90deg,
                block(width: ph, height: pw, {
                    // Äußerer Rahmen
                    place(center + horizon)[
                        #rect(
                            width: ph - 2 * rand,
                            height: pw - 2 * rand,
                            stroke: 1.2pt + black
                        )
                    ]
                    // Schriftfeld
                    place(right + bottom, dx: -rand, dy: -rand)[
                        #box[#s_box]
                    ]
                    // Schreibbereich
                    place(center + top, dy: rand,
                        block(
                            width: ph - 2 * rand,
                            height: pw - 2 * rand,
                            clip: false,
                            align(center + horizon,
                                layout(size =>
                                    block(
                                        width: size.width,
                                        height: size.height,
                                        align(center + horizon, body)
                                    )
                                )
                            )
                        )
                    )
                })
            )
        )
    }
}


// wird im Querformat im Dokument angezeigt
#let rahmen-quer-quer(..args) = {
    let body = args.pos().at(0)
    let s_box = schriftfeld(..args.named())

    set page(
        flipped: true,
        margin: (top: 1.5cm, bottom: 1.5cm, left: 1.5cm, right: 1.5cm),
        background: {
            let rand = 1cm
            place(center + horizon)[
                #rect(
                width: 100% - (2 * rand), 
                height: 100% - (2 * rand),
                stroke: 1.2pt + black
                )
            ]
            place(right + bottom, dx: -rand, dy: -rand)[
                #rotate(0deg, origin: bottom + right)[
                    #box[#s_box]
                ]
            ]
        }
    )
    align(center + horizon, body)
}