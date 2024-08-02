//
//  SolarButtonStyle.swift
//  SolarSystemUsingSceneKit
//
//  Created by 전성훈 on 8/2/24.
//

import SwiftUI

struct SolarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundStyle(configuration.isPressed ? .gray : .white)
            .padding(8)
            .background(ColorPalette.secondary)
            .clipShape(.rect(cornerRadius: 8))
    }
}
