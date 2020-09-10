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
    public func postAttendance(_ attendance: AttendanceRequest, completion: @escaping (Result<(AttendanceResponseResult, String?), Never>) -> Void) {
        let url = URL(string: Constants.api.attendance)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(attendance)
        
        AF.request(request)
            .validate()
            .responseDecodable(of: AttendanceResponse.self) { response in
                guard let result = response.value else { return completion(.success((.other, nil))) }
                return completion(.success((result.response, result.name)))
        }
    }
    
    public func postRegister(_ registerForm: RegisterRequest, completion: @escaping (Result<RegisterResponseResult, Never>) -> Void) {
        let url = URL(string: Constants.api.register)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(registerForm)
        
        AF.request(request)
            .validate()
            .responseDecodable(of: RegisterResponse.self) { response in
                guard let result = response.value else { return completion(.success(.other)) }
                if result.response == .ok {
                    let defaults = UserDefaults.standard
                    defaults.set(result.id, forKey: "StationId")
                }
                return completion(.success(result.response))
        }
    }
    
    func getInfo(_ infoRequest: InfoRequest, completion: @escaping (InfoResponse?) -> Void) {
        let url = URL(string: Constants.api.info)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.httpBody = try? JSONEncoder().encode(infoRequest)
        
        AF.request(request)
            .validate()
            .responseDecodable(of: InfoResponse.self) { response in
                guard let result = response.value else { return completion(nil) }
                if result.response == .ok {
                    completion(result)
                }
                return completion(nil)
        }
    }
}
