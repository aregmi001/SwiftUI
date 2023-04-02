//
//  AstronautView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-31.
//

import SwiftUI

struct AstronautView: View {

    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text (astronaut.description)
                    .foregroundColor(.white)
                    .padding()

            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {

    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}
