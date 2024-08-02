//
//  ProgressViewWithBackgroundStyle.swift
//  SolarSystemUsingSceneKit
//
//  Created by 전성훈 on 8/2/24.
//

import SwiftUI

struct ProgressViewWithBackgroundStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ColorPalette.accent
            .opacity(0.8)
            .overlay(ProgressView(configuration))
            .clipShape(.rect(cornerRadius: 8))
    }
}
