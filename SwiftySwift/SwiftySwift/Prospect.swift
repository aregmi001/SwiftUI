//
//  Prospect.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-06.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    //var isConctacted = false
    fileprivate(set) var isConctacted = false
}

@MainActor class Prospects: ObservableObject {

    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"

    init () {

        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }

        people = []
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isConctacted.toggle()
        save()
    }
}
