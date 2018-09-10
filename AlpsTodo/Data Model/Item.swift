//
//  Item.swift
//  AlpsTodo
//
//  Created by ALPER UYANIK on 9/9/18.
//  Copyright © 2018 ALPER UYANIK. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") //inverse relationship
}
