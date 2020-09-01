//
//  AttendanceResponse.swift
//  LabMaster
//
//  Created by Robert Moryson on 31/08/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct AttendanceResponse: Decodable {
    let response: AttendanceResponseResult

    enum CodingKeys: String, CodingKey {
        case response
    }
}

enum AttendanceResponseResult: Decodable {
    case ok
    case wrongId
    case serverError
    case other
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        switch value {
            case "OK": self = .ok
            case "ID NOT FOUND": self = .wrongId
            case "INTERNAL SERVER ERROR": self = .serverError
            default: self = .other
       }
    }
}
