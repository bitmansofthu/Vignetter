//
//  VignetterTests.swift
//  VignetterTests
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import FactoryKit
import FactoryTesting
import Testing
@testable import Vignetter

@MainActor
@Suite(.container)
struct CountySelectorViewModelTests {

    @Test func given_singleSelectedCounty_whenValidated_shouldReturnTrue() async throws {
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // Given
        sut.selectedCounties = [
            .baranyaMock
        ]
        
        // When
        let result = sut.validateSelectedCounties()
        
        // Then
        #expect(result == true)
    }
    
    @Test func given_multiSelectedNeighbourCounty_whenValidated_shouldReturnTrue() async throws {
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // Given
        sut.selectedCounties = [
            .baranyaMock,
            .bacsKiskunMock
        ]
        
        // When
        let result = sut.validateSelectedCounties()
        
        // Then
        #expect(result == true)
    }
    
    @Test func given_multiSelectedNonNeighbourCounty_whenValidated_shouldReturnTrue() async throws {
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // Given
        sut.selectedCounties = [
            .baranyaMock,
            .bekesMock
        ]
        
        // When
        let result = sut.validateSelectedCounties()
        
        // Then
        #expect(result == false)
    }
    
    @Test func given_selectCounty_whenSelected_shouldInsertItem() async throws {
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // Given
        sut.selectedCounties = []
        
        // When
        sut.selectCounty(select: true, county: .bacsKiskunMock)
        
        // Then
        #expect(sut.selectedCounties.contains(.bacsKiskunMock))
    }
    
    @Test func given_selectCounty_whenDeselected_shouldRemoveItem() async throws {
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // Given
        sut.selectedCounties = [.bacsKiskunMock]
        
        // When
        sut.selectCounty(select: false, county: .bacsKiskunMock)
        
        // Then
        #expect(sut.selectedCounties.contains(.bacsKiskunMock) == false)
    }
    
    @Test func given_selectCounty_whenSelected_shouldUpdateOrderInfo() async throws {
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // Given
        sut.selectedCounties = []
        
        // When
        sut.selectCounty(select: true, county: .bacsKiskunMock)
        
        // Then
        #expect(sut.orderInfo.counties.count == sut.selectedCounties.count)
    }
    
    @Test func given_fetchCounties_whenCalledAndFails_shouldUpdateFetchCountiesError() async throws {
        // Given
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock(throwError: true)
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // When
        await sut.fetchCounties()
        
        // Then
        #expect(sut.showFetchCountiesError == true)
    }
    
    @Test func given_fetchCounties_whenCalledAndSucceeds_shouldSetCounties() async throws {
        // Given
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // When
        await sut.fetchCounties()
        
        // Then
        #expect(sut.counties.count > 0)
    }
    
    @Test func given_summaryPrice_whenSelectedCountiesChange_shouldUpdated() async throws {
        // Given
        Container.shared.getHighwayInfoUseCase.register {
            GetHighwayInfoUseCaseMock()
        }
        let sut = CountySelectorViewModel(info: .preview)
        
        // When
        sut.selectedCounties = [.baranyaMock, .bacsKiskunMock]
        
        // Then
        #expect(sut.summaryPrice == sut.selectedCounties.count * sut.orderInfo.vignette.price)
    }

}
