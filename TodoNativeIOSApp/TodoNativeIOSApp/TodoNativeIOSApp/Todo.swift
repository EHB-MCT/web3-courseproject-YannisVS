//
//  Todo.swift
//  TodoNativeIOSApp
//
//  Created by Nick Ingels on 05/10/2021.
//  Copyright © 2021 EHB. All rights reserved.
//

import Foundation

struct Todo: Codable{
    var Todo: String!
    
    init(todo: String){self.Todo = todo}
}

