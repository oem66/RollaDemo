//
//  HomeView.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import SwiftUI
import CoreBluetooth

struct BLEView: View {
    @StateObject var viewModel = BLEViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                List(viewModel.peripherals, id: \.self) { peripheral in
                    Text(peripheral.name ?? "Unknown device")
                        .font(.custom("Avenir-Medium", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .onTapGesture {
                            viewModel.connectToPeripheral(peripheral)
                        }
                    ShowServices(services: peripheral.services ?? [CBService]())
                }
                .navigationTitle("BLE Peripherals")
            }
        }
    }
    
    @ViewBuilder
    func ShowServices(services: [CBService]) -> some View {
        ForEach(services, id: \.self) { service in
            Text(service.description)
                .font(.custom("Avenir-Medium", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
    }
}
