//
//  HighwayVignettes.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

struct HighwayInfo {
    
    let vignettes: [Vignette]
    let counties: [CountyDTO]
    
    init(
        vignettes: [Vignette],
        counties: [CountyDTO]
    ) {
        self.vignettes = vignettes
        self.counties = counties
    }
}

extension HighwayInfo {
    static var preview: HighwayInfo = .init(vignettes: [.preview], counties: [
        .init(id: "YEAR_11", name: "Bács-Kiskun"),
        .init(id: "YEAR_12", name: "Baranya"),
        .init(id: "YEAR_13", name: "Bekes")
    ])
}
