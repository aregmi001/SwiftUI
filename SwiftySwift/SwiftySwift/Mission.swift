//
//  Mission.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-31.
//

import Foundation

//{
//    "id": 7,
//    "launchDate": "1968-10-11",
//    "crew": [
//        {
//            "name": "schirra",
//            "role": "Commander"
//        },
//        {
//            "name": "eisele",
//            "role": "Command Module Pilot"
//        },
//        {
//            "name": "cunningham",
//            "role": "Lunar Module Pilot"
//        }
//    ],
//    "description": "Apollo 7 was an October 1968 human spaceflight mission carried out by the United States. It was the first mission in the United States' Apollo program to carry a crew into space. It was also the first U.S. spaceflight to carry astronauts since the flight of Gemini XII in November 1966.\n\nThe AS-204 mission, also known as \"Apollo 1\", was intended to be the first crewed flight of the Apollo program. It was scheduled to launch in February 1967, but a fire in the cabin during a January 1967 test killed the crew.\n\nCrewed flights were then suspended for 21 months, while the cause of the accident was investigated and improvements made to the spacecraft and safety procedures, and uncrewed test flights of the Saturn V rocket and Apollo Lunar Module were made. Apollo 7 fulfilled Apollo 1's mission of testing the Apollo command and service module (CSM) in low Earth orbit."
//},

struct Mission: Codable, Identifiable {

    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate : String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
