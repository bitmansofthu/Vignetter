//
//  VehicleCategoryDTO.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import Foundation

struct VehicleCategoryDTO: Codable {
    let category: String
    let vignetteCategory: String
    let name: VehicleCategoryNameDTO
}

struct VehicleCategoryNameDTO: Codable {
    let en: String
    let hu: String
}
