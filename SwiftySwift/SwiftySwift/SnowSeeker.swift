//
//  SnowSeeker.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-07.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct SnowSeeker: View {

    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @StateObject var favorites = Favorites()


    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            //List(resorts) { resort in
            List(filteredResorts) { resort in
                NavigationLink {
                    //Text(resort.name)
                    ResortView(resort: resort)

                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }

                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibilityLabel("This is a favorite resort")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")

            WelcomeView()

        }
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
}

struct SnowSeeker_Previews: PreviewProvider {
    static var previews: some View {
        SnowSeeker()
    }
}
