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
    public func postAttendance(_ attendance: AttendanceRequest) {
        let url = URL(string: "https://run.mocky.io/v3/fd771838-d942-4bea-8a03-d1ec6ba6c3f9")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(attendance)
        
        AF.request(request)
            .validate()
            .responseDecodable(of: AttendanceResponse.self) { response in
                guard let result = response.value else { return }
                print(result.response)
        }
    }
}
