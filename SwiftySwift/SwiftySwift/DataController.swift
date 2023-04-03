//
//  DataController.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-02.
//

import CoreData
import Foundation

class DataController: ObservableObject {

    var coreDataContainer : NSPersistentContainer = NSPersistentContainer(name: "Bookworm")

    init () {
        coreDataContainer.loadPersistentStores { desciption, error in
            if let error = error {
                print ("Core Data failed to load : \(error.localizedDescription)")
                return
            }

            self.coreDataContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

}
