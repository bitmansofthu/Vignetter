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
        .init(id: "YEAR-11", name: "Bács-Kiskun"),
        .init(id: "YEAR-12", name: "Baranya")
    ])
}
