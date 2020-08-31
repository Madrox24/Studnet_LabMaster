//
//  AttendanceRequest.swift
//  LabMaster
//
//  Created by Robert Moryson on 31/08/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct AttendanceRequest: Codable {
    let id: Int
    let studentId: Int
    
    init(id: Int, studentId: Int) {
        self.id = id
        self.studentId = studentId
    }

    enum CodingKeys: String, CodingKey {
        case id
        case studentId = "student_id"
    }
}
