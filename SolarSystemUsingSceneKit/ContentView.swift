//
//  ContentView.swift
//  SolarSystemUsingSceneKit
//
//  Created by 전성훈 on 8/2/24.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    static func makeScene() -> SCNScene? {
        let scene = SCNScene(named: "Solar Scene.scn")
        return scene
    }
    
    var scene = makeScene()
    
    var body: some View {
        ZStack {
            ColorPalette.secondary.ignoresSafeArea()
            
            VStack {
                if let planet = viewModel.selectedPlanet {
                    VStack {
                        PlantInfoRow(title: "Length of Year", value: planet.yearLength)
                        PlantInfoRow(title: "Number of moons", value: "\(planet.moonCount)")
                        PlantInfoRow(title: "Namesake", value: planet.namesake)
                    }
                    .padding(8)
                    .background(ColorPalette.primary)
                    .clipShape(.rect(cornerRadius: 14))
                    .padding(12)
                }
                
                Spacer()
                
                HStack {
                    HStack {
                        Button(action: viewModel.selectPreviousPlant) {
                            Image(systemName: "arrow.backward.circle.fill")
                        }
                        Button(action: viewModel.selectNextPlant) {
                            Image(systemName: "arrow.forward.circle.fill")
                        }
                    }
                    
                    Spacer()
                    Text(viewModel.title).foregroundStyle(.white)
                    Spacer()
                    
                    if viewModel.selectedPlanet != nil {
                        Button(action: viewModel.clearSelection) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
                .padding(8)
                .background(ColorPalette.primary)
                .clipShape(.rect(cornerRadius: 14))
                .padding(12)
            }
        }
    }
    
    func setUpCamera(planet: Planet?) -> SCNNode? {
        let cameraNode = scene?.rootNode
            .childNode(withName: "camera", recursively: false)
        
        return cameraNode
    }
}

#Preview {
    ContentView()
}
