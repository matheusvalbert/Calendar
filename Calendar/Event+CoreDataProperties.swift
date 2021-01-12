//
//  Event+CoreDataProperties.swift
//  Calendar
//
//  Created by Matheus Valbert on 10/01/21.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var content: String?
    @NSManaged public var year: String?
    @NSManaged public var month: String?
    @NSManaged public var day: String?

    var wrappedContent: String {
        content ?? "Unknown"
    }
    
    var wrappedYear: String {
        year ?? "Unknown"
    }
    
    var wrappedMonth: String {
        month ?? "Unknown"
    }
    
    var wrappedDay: String {
        day ?? "Unknown"
    }
}

extension Event : Identifiable {

}
