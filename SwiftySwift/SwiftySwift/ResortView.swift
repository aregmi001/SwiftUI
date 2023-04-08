//
//  ResortView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-07.
//

import SwiftUI

struct ResortView: View {

    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize

    @State private var selectedFacility: Facility?
    @State private var showingFacility = false

    @EnvironmentObject var favorites: Favorites

    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()

//                HStack {
//                    ResortDetailsView(resort: resort)
//                    SkiDetailsView(resort: resort)
//                }
//                .padding(.vertical)
//                .background(Color.primary.opacity(0.1))

                HStack {

                    if sizeClass == .compact && typeSize > .large {
                    //if sizeClass == .compact {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)


                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)

//                    Text(resort.facilities, format: .list(type: .and))
//                        .padding(.vertical)

//                    Text(resort.facilities.joined(separator: ", "))
//                        .padding(.vertical)
                }
                .padding(.horizontal)
            }

            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if favorites.contains(resort) {
                    favorites.remove(resort)
                } else {
                    favorites.add(resort)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
