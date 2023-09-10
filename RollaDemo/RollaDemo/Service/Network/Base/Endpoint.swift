//
//  Endpoint.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 10. 9. 2023..
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var postmanHost: String {
        return "postman-echo.com"
    }
}
