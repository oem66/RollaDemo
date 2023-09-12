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
                List(viewModel.peripheralNames, id: \.self) { peripheral in
                    Text(peripheral)
                        .font(.custom("Avenir-Medium", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .navigationTitle("BLE Peripherals")
            }
        }
    }
}
