//
//  ApiClient.swift
//  LabMaster
//
//  Created by Robert Moryson on 31/08/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    public func getRequest() {
        let request = AF.request(Constants.api.base)
        let parameters: AttendanceRequest = AttendanceRequest(id: 12, studentId: 121323)
//
//        AF.request(request, parameters: parameters)
//          .validate()
//          .responseDecodable(of: self) { response in
//            // 4
//            guard let starships = response.value else { return }
//            self.items = starships.all
//            self.tableView.reloadData()
//        }
    }
}
