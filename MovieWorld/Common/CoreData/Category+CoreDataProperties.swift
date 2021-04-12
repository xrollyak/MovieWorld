//
//  Category+CoreDataProperties.swift
//  MovieWorld
//
//  Created by Nadya Khrol on 12.04.2021.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var movies: Movie?

}

extension Category : Identifiable {

}
