//
//  Category.swift
//  AlpsTodo
//
//  Created by ALPER UYANIK on 9/9/18.
//  Copyright © 2018 ALPER UYANIK. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object { //with the help of this object class we are able to save our data using realm
    
    @objc dynamic var name: String = ""  //with dynami property we are able to monitor the change of variable while app is running
    let items = List<Item>()              //forward relationship

// each category have an number of items and that is a list of item objects and item objects are also subclassing the realm object
    
}
