//
//  URLComponents.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 10. 9. 2023..
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String:String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
