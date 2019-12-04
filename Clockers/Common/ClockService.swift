//
//  ClockService.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 04/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import Alamofire
import Foundation

typealias StaffInfo = (clientInfo: [String: Any], position: [String: Any], wageAmount: String, wageType: String, location: [String: Any], manager: [String: Any])

class ClockService {
    static let shared: ClockService = ClockService()
    var authorizationKey: String = ""
    
    func login(completionHandler: @escaping ((StaffInfo) -> Void)) {
        guard let url = URL(string: "https://api.helpster.tech/v1/auth/login/") else { return }
        
        let loginParams: [String: Any] = [
            "username": "+6281313272005",
            "password": "alexander"
        ]
        
        Alamofire
            .request(url, method: .post, parameters: loginParams)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess,
                    let keyObj = response.result.value as? [String: Any],
                    let authKey = keyObj["key"] as? String else { return }
                
                ClockService.shared.authorizationKey = authKey
                ClockService.shared.getStaffInfo(completionHandler: completionHandler)
        }
    }
    
    func getStaffInfo(completionHandler: @escaping ((StaffInfo) -> Void)) {
        guard let url = URL(string: "https://api.helpster.tech/v1/staff-requests/26074/") else { return }
        
        let header: HTTPHeaders = [
            "Authorization": "\(ClockService.shared.authorizationKey)"
        ]
        
        Alamofire
            .request(url, method: .get, headers: header)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess,
                    let jsonObj = response.result.value as? [String: Any] else { return }
                
                
                if let client = jsonObj["client"] as? [String: Any],
                    let position = jsonObj["position"] as? [String: Any],
                    let wageAmount = jsonObj["wage_amount"] as? String,
                    let wageType = jsonObj["wage_type"] as? String,
                    let location = jsonObj["location"] as? [String: Any],
                    let manager = jsonObj["manager"] as? [String: Any] {
                    completionHandler((client, position, wageAmount, wageType, location, manager))
                }
        }
    }
    
    // TODO: Add Handler for passing the time
    func clockIn(lat: Double, long: Double) {
        guard let url = URL(string: "https://api.helpster.tech/v1/staff-requests/26074/clock-in/") else { return }
        
        let header: HTTPHeaders = [
            "Authorization": "\(ClockService.shared.authorizationKey)"
        ]
        
        let clockParams: [String: Any] = [
            "latitute": "\(lat)",
            "longitude": "\(long)"
        ]
        
        Alamofire
            .request(url, method: .post, parameters: clockParams, headers: header)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess,
                    let jsonObj = response.result.value as? [String: Any] else { return }
                if let clockInTime = jsonObj["clock_in_time"] as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    let date = dateFormatter.date(from: clockInTime)
                    // Pass the date to handler
                }
        }
    }
    
    // TODO: Add Handler for passing the time
    func clockOut(lat: Double, long: Double) {
        guard let url = URL(string: "https://api.helpster.tech/v1/staff-requests/26074/clock-out/") else { return }
        
        let header: HTTPHeaders = [
            "Authorization": "\(ClockService.shared.authorizationKey)"
        ]
        
        let clockParams: [String: Any] = [
            "latitute": "\(lat)",
            "longitude": "\(long)"
        ]
        
        Alamofire
            .request(url, method: .post, parameters: clockParams, headers: header)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess,
                    let jsonObj = response.result.value as? [String: Any] else { return }
                if let clockOutTime = jsonObj["clock_in_time"] as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    let date = dateFormatter.date(from: clockOutTime)
                    // Pass the date to handler
                }
        }
    }
}
