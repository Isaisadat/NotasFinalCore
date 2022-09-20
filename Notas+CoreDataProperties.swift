//
//  Notas+CoreDataProperties.swift
//  NotasFinalCore
//
//  Created by Isai Abraham on 19/09/22.
//
//

import Foundation
import CoreData


extension Notas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notas> {
        return NSFetchRequest<Notas>(entityName: "Notas")
    }

    @NSManaged public var borrar: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: Int32
    @NSManaged public var titulo: String?

}

extension Notas : Identifiable {

}
