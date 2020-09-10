//
//  InfoRequest.swift
//  LabMaster
//
//  Created by Robert Moryson on 10/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct InfoRequest: Codable {
    let id: Int

    init(id: Int) {
        self.id = id
    }
    
    enum CodingKeys: CodingKey {
        case id
    }
}
