//
//  SwiftySwiftApp.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-20.
//

import SwiftUI

@main
struct SwiftySwiftApp: App {

    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            BetterRest()
                .environment(\.managedObjectContext, dataController.coreDataContainer.viewContext)
        }
    }
}
