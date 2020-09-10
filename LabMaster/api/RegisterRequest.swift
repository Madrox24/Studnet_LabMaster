//
//  RegisterRequest.swift
//  LabMaster
//
//  Created by Robert Moryson on 09/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable {
    let room: String
    let position: Int
    let adminKey: String
    
    init(room: String, position: Int, adminKey: String) {
        self.room = room
        self.position = position
        self.adminKey = adminKey
    }

    enum CodingKeys: String, CodingKey {
        case room
        case position
        case adminKey = "admin_key"
    }
}
