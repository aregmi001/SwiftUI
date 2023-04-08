//
//  HotProspects.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-05.
//

import SwiftUI

struct HotProspects: View {
    @StateObject private var prospects : Prospects = Prospects()

    var body: some View {

        TabView {

            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }

            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }

            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("UnContacted", systemImage: "questionmark.diamond")
                }

            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

struct HotProspects_Previews: PreviewProvider {
    static var previews: some View {
        HotProspects()
            .environmentObject(Prospects())
    }
}
