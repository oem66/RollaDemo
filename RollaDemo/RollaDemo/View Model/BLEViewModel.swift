//
//  BLEViewModel.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 12. 9. 2023..
//

import Foundation
import Combine
import CoreBluetooth

final class BLEViewModel: NSObject, ObservableObject {
    @Published var peripheralNames: [String] = []
    @Published var peripherals = [CBPeripheral]()
    
    private var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BLEViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "Unknown Device")
        }
    }
}
