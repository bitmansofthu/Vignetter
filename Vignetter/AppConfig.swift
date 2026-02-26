//
//  AppConfig.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

protocol AppConfigProtocol {
    var baseUrl: String { get }
}

class AppConfig: AppConfigProtocol {
    var baseUrl: String {
        "https://idj.hu/highwaytest/v1"
    }
}
