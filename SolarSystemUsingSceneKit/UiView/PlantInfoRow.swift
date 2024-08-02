//
//  PlantInfoRow.swift
//  SolarSystemUsingSceneKit
//
//  Created by 전성훈 on 8/2/24.
//

import SwiftUI

struct PlantInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(title): ").fontWeight(.thin).font(.title2)
                Text(value).fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            Spacer()
        }
    }
}

struct PlantInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PlantInfoRow(title: "타이틀", value: "4")
    }
}
