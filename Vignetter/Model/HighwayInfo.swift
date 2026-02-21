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

extension Array where Element == CountyDTO {
    func county(forId id: String) -> CountyDTO? {
        self.first { $0.id == id }
    }
}

extension HighwayInfo {
    static var preview: HighwayInfo = .init(vignettes: [.preview], counties: [
        .init(id: "YEAR-11", name: "Bács-Kiskun"),
        .init(id: "YEAR-12", name: "Baranya")
    ])
}
