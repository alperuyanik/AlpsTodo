//
//  Item.swift
//  AlpsTodo
//
//  Created by ALPER UYANIK on 8/27/18.
//  Copyright © 2018 ALPER UYANIK. All rights reserved.
//

import Foundation

class Item: Codable {
    // Codable or Encodable: And this means that the item type is now able to encode itself into a P list or into a Jason and for
    
    var title: String = ""
    var done: Bool = false
}
