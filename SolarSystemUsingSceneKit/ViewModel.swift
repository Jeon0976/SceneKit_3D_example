//
//  ViewModel.swift
//  SolarSystemUsingSceneKit
//
//  Created by 전성훈 on 8/2/24.
//

import Foundation

final class ViewModel: NSObject, ObservableObject {
    @Published var selectedPlanet: Planet?
    
    var title: String {
        selectedPlanet?.name ?? ""
    }
    
    func selectNextPlant() {
        changeSelection(offset: 1)
    }
    
    func selectPreviousPlant() {
        changeSelection(offset: -1)
    }
    
    func clearSelection() {
        selectedPlanet = nil
    }
    
    private func changeSelection(offset: Int) {
        guard let selectedPlanet = selectedPlanet,
              let index = Planet.allCases.firstIndex(of: selectedPlanet) else {
            selectedPlanet = Planet.allCases.first
            return
        }
        
        let newIndex = index + offset
        
        if newIndex < 0 {
            self.selectedPlanet = Planet.allCases.last
        } else if newIndex < Planet.allCases.count {
            self.selectedPlanet = Planet.allCases[newIndex]
        } else {
            self.selectedPlanet = Planet.allCases.first
        }
    }
}
