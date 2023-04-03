//
//  Candy+CoreDataProperties.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-02.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName : String {
        name ?? "Unknown Candy"
    }
}

extension Candy : Identifiable {

}
