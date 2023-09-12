//
//  PeripheralModel.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 12. 9. 2023..
//

import Foundation
import CoreBluetooth

struct PeripheralModel: Hashable {
    var name: String
    var services: [CBService]
}
