//
//  Entity.swift
//  FotografListesi
//
//  Created by Muhammed Gül on 16.11.2022.
//



// bu sayfayı editörden create nsmanagedObject subclass tan otoamtik yapabilirsin

import Foundation
import CoreData

@objc(Entity)

public class Entity : NSManagedObject{
    
    
}

extension Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }
    
    @NSManaged public var titleText : String?
    @NSManaged public var descriptionText : String?
    @NSManaged public var image : NSData?
}
