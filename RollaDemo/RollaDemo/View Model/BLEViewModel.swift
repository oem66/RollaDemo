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
    @Published var selectedPeripheral: CBPeripheral?
    
    private var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        selectedPeripheral = peripheral
        centralManager?.connect(peripheral)
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
            debugPrint("Services \(String(describing: peripheral.services))")
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "Unknown Device")
        }
    }
    
    // The handler if we do connect succesfully
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.selectedPeripheral {
            debugPrint("Connected to BLE device")
//            peripheral.discoverServices([DEVICE_SERVICE_UUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral == self.selectedPeripheral {
            print("Disconnected");
            self.selectedPeripheral = nil;
            // Start scanning again
            centralManager!.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true]);
        }
    }
    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        if let services = peripheral.services {
//            for service in services {
//                if service.uuid == DEVICE_SERVICE_UUID {
//                    print("LED service found")
//                    //Now kick off discovery of characteristics
//                    peripheral.discoverCharacteristics([DEVICE_SERVICE_UUID], for: service)
//                }
//            }
//        }
//    }
}
