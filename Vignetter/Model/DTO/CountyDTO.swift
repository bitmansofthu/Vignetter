//
//  CountyDTO.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

struct CountyDTO: Codable, Hashable, Identifiable {
    let id: String
    let name: String
}

extension CountyDTO {
    static var bacsKiskunMock: CountyDTO {
        .init(id: "YEAR_11", name: "Bács-Kiskun")
    }
    
    static var baranyaMock: CountyDTO {
        .init(id: "YEAR_12", name: "Baranya")
    }
    
    static var bekesMock: CountyDTO {
        .init(id: "YEAR_13", name: "Bekes")
    }
}
