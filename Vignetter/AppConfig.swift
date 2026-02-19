//
//  AppConfig.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

class AppConfig {
    
    static var shared = AppConfig()
    
    let baseUrl: String
    
    private init() {
        baseUrl = "https://idj.hu/highwaytest/v1"
    }
}
