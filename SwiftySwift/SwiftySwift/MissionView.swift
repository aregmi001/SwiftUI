//
//  MissionView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-31.
//

import SwiftUI

struct HorizontalScrollView: View {
    let crew: [MissionView.CrewMember]
    var body: some View {

        ScrollView (.horizontal, showsIndicators: false) {

            HStack {
                ForEach(crew, id: \.role) { crew in
                    NavigationLink {
                        //Text("Astro Details")
                        AstronautView(astronaut: crew.astronaut)
                    } label: {
                        HStack {
                            Image(crew.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack(alignment: .leading ) {
                                Text("\(crew.astronaut.name)")
                                    .foregroundColor(.white)
                                    .font(.headline)

                                Text("\(crew.role)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
        }

    }
}

struct MissionView: View {

    struct CrewMember {
        let role: String
        let astronaut : Astronaut
    }

    let mission : Mission
    let crew: [CrewMember]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)

                    Text("\(mission.formattedLaunchDate)")
                        .font(.headline)

                    VStack (alignment: .leading) {

                        //Divider()
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)

                        Text("Missing Highlights")
                            .font(.title)

                        Text (mission.description)

                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)

                        Text("Crew")
                            .font(.title)
                    }
                    .padding(.horizontal)

                    HorizontalScrollView(crew: crew)

                }
                .padding(.bottom)
            }
        }
        .navigationTitle("hello")        
    }

    init(mission: Mission, astronauts: [String: Astronaut]?) {
        self.mission = mission
        self.crew = mission.crew.map({ member in
            if let astronaut = astronauts![member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        })
    }
}

struct MissionView_Previews: PreviewProvider {

    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
