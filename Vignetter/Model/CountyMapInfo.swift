//
//  CountyInfo.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 21..
//

import Foundation

enum CountyMapInfo: String, CaseIterable, Identifiable {
    
    case bacskiskun
    case pest
    case baranya
    case bekes
    case borsodabaujzemplen
    case csongradcsanad
    case fejer
    case gyormosonsopron
    case hajdubihar
    case heves
    case jasznagykunszolnok
    case komaromesztergom
    case nograd
    case somogy
    case szabolcsszatmarbereg
    case tolna
    case vas
    case veszprem
    case zala
    
    var id: String {
        switch self {
        case .bacskiskun:
            return "YEAR_11"
        case .baranya:
            return "YEAR_12"
        case .bekes:
            return "YEAR_13"
        case .borsodabaujzemplen:
            return "YEAR_14"
        case .csongradcsanad:
            return "YEAR_15"
        case .fejer:
            return "YEAR_16"
        case .gyormosonsopron:
            return "YEAR_17"
        case .hajdubihar:
            return "YEAR_18"
        case .heves:
            return "YEAR_19"
        case .jasznagykunszolnok:
            return "YEAR_20"
        case .komaromesztergom:
            return "YEAR_21"
        case .nograd:
            return "YEAR_22"
        case .pest:
            return "YEAR_23"
        case .somogy:
            return "YEAR_24"
        case .szabolcsszatmarbereg:
            return "YEAR_25"
        case .tolna:
            return "YEAR_26"
        case .vas:
            return "YEAR_27"
        case .veszprem:
            return "YEAR_28"
        case .zala:
            return "YEAR_29"
        }
    }
    
    var imageName: String {
        return self.rawValue
    }
    
    var selectedImageName: String {
        return self.rawValue + "_selected"
    }
    
    var neighbours: [CountyMapInfo] {
        switch self {
        case .bacskiskun:
            return [.baranya, .tolna, .fejer, .pest, .jasznagykunszolnok, .csongradcsanad]
        case .pest:
            return [.komaromesztergom, .nograd, .heves, .jasznagykunszolnok, .bacskiskun, .fejer]
        case .baranya:
            return [.somogy, .tolna, .bacskiskun]
        case .bekes:
            return [.csongradcsanad, .jasznagykunszolnok, .hajdubihar]
        case .borsodabaujzemplen:
            return [.nograd, .szabolcsszatmarbereg, .hajdubihar, .jasznagykunszolnok, .heves]
        case .csongradcsanad:
            return [.bacskiskun, .jasznagykunszolnok, .bekes]
        case .fejer:
            return [.komaromesztergom, .pest, .bacskiskun, .tolna, .somogy, .veszprem]
        case .gyormosonsopron:
            return [.vas, .veszprem, .komaromesztergom]
        case .hajdubihar:
            return [.borsodabaujzemplen, .szabolcsszatmarbereg, .bekes, .jasznagykunszolnok, .heves]
        case .heves:
            return [.nograd, .borsodabaujzemplen, .jasznagykunszolnok, .pest]
        case .jasznagykunszolnok:
            return [.pest, .heves, .borsodabaujzemplen, .hajdubihar, .bekes, .csongradcsanad, .bacskiskun]
        case .komaromesztergom:
            return [.gyormosonsopron, .veszprem, .fejer, .pest]
        case .nograd:
            return [.pest, .heves, .borsodabaujzemplen]
        case .somogy:
            return [.zala, .veszprem, .fejer, .tolna, .baranya]
        case .szabolcsszatmarbereg:
            return [.borsodabaujzemplen, .hajdubihar]
        case .tolna:
            return [.somogy, .fejer, .bacskiskun, .baranya]
        case .vas:
            return [.zala, .veszprem, .gyormosonsopron]
        case .veszprem:
            return [.vas, .gyormosonsopron, .komaromesztergom, .fejer, .somogy, .zala]
        case .zala:
            return [.vas, .veszprem, .somogy]
        }
    }
}

extension CountyDTO {
    var mapInfo: CountyMapInfo? {
        CountyMapInfo.allCases.first { $0.id == self.id }
    }
}
