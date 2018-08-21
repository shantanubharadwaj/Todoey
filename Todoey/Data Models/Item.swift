//
//  Item.swift
//  Todoey
//
//  Created by Shantanu Dutta on 20/08/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation

struct Item: Codable {
    let title: String
    var done: Bool = false
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
