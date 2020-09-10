//
//  RegisterResponse.swift
//  LabMaster
//
//  Created by Robert Moryson on 09/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct RegisterResponse: Decodable {
    let id: Int
    let room: String
    let position: Int
    let response: RegisterResponseResult
    
    init(id: Int, room: String, position: Int, response: RegisterResponseResult) {
        self.id = id
        self.room = room
        self.position = position
        self.response = response
    }

    enum CodingKeys: String, CodingKey {
        case id
        case room
        case position
        case response
    }
}

enum RegisterResponseResult: Decodable {
    case ok
    case wrongKey
    case serverError
    case other
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        switch value {
            case "OK": self = .ok
            case "WRONG KEY": self = .wrongKey
            case "INTERNAL SERVER ERROR": self = .serverError
            default: self = .other
       }
    }
}
