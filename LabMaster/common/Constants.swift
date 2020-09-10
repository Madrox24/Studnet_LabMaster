//
//  Constants.swift
//  LabMaster
//
//  Created by Robert Moryson on 31/08/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

enum Constants {
    enum api {
        static let base         = "http://192.168.43.37:5000"
        static let attendance   = base + "/api/attendance"
        static let register     = base + "/api/register"
        static let info         = base + "/api/info"
    }
}
