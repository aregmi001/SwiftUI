//
//  FilteredList.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-02.
//

import SwiftUI

struct FilteredList: View {

    @Environment(\.managedObjectContext) var moc
    @FetchRequest var fetchRequest: FetchedResults<Singer>

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }

    init(filter: String) {

        /* underscore below is used to write a wholly new fetch request */
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}
