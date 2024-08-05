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
        
        applyTextures(to: scene)
        
        return scene
    }
    
    static func applyTextures(to scene: SCNScene?) {
        for planet in Planet.allCases {
            let identifier = planet.rawValue
            
            let node = scene?.rootNode.childNode(
                withName: identifier,
                recursively: false
            )
            
            let texture = UIImage(named: identifier)
            
            node?.geometry?.firstMaterial?.diffuse.contents = texture
            
            let skyboxImages = (1...6).map { UIImage(named: "skybox\($0)")}
            
            scene?.background.contents = skyboxImages
        }
    }
    
    var scene = makeScene()
    
    var body: some View {
        ZStack {
            SceneView(
                scene: scene,
                pointOfView: setUpCamera(planet: viewModel.selectedPlanet),
                options: viewModel.selectedPlanet == nil ? [.allowsCameraControl] : []
            )
            .background(ColorPalette.secondary)
            .edgesIgnoringSafeArea(.all)
            
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
        
        if let planetNode = planet.flatMap(planetNode(planet:)) {
            let constraint = SCNLookAtConstraint(target: planetNode)
            cameraNode?.constraints = [constraint]
            
            let globalPosition = planetNode.convertPosition(
                SCNVector3(x: 50, y: 10, z: 0),
                to: nil
            )
            
            let move = SCNAction.move(to: globalPosition, duration: 1.0)
            
            cameraNode?.runAction(move)
        }
        
        return cameraNode
    }
    
    private func planetNode(planet: Planet) -> SCNNode? {
        scene?.rootNode.childNode(
            withName: planet.rawValue,
            recursively: false
        )
    }
}

#Preview {
    ContentView()
}
