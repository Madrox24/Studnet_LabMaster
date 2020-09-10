//
//  InfoResponse.swift
//  LabMaster
//
//  Created by Robert Moryson on 10/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct InfoResponse: Decodable {
    let response: InfoResponseResult
    let name: String
    let surname: String
    let subject: String
    
    init(response: InfoResponseResult, name: String, surname: String, subject: String) {
        self.response = response
        self.name = name
        self.surname = surname
        self.subject = subject
    }

    enum CodingKeys: String, CodingKey {
        case response
        case name
        case surname
        case subject
    }
}

enum InfoResponseResult: Decodable {
    case ok
    case idNotFound
    case serverError
    case other
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        switch value {
            case "OK": self = .ok
            case "ID NOT FOUND": self = .idNotFound
            case "INTERNAL SERVER ERROR": self = .serverError
            default: self = .other
       }
    }
}
