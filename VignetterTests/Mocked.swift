//
//  Mock.swift.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 24..
//

@testable import Vignetter

enum TestError: Error {
    case general
}

struct GetHighwayInfoUseCaseMock: GetHighwayInfoUseCaseProtocol {
    
    let returnInfo: HighwayInfo
    let throwError: Bool
    
    init(
        returnInfo: HighwayInfo = .preview,
        throwError: Bool = false
    ) {
        self.throwError = throwError
        self.returnInfo = returnInfo
    }
    
    func execute() async throws -> HighwayInfo {
        if throwError {
            throw TestError.general
        } else {
            return returnInfo
        }
    }
}
