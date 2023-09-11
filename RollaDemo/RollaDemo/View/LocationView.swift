//
//  DeviceView.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import SwiftUI

struct LocationView: View {
    @StateObject var viewModel = LocationViewModel()
    
    var body: some View {
        Text("Location View")
            .foregroundColor(.black)
            .onAppear {
                viewModel.setupLocationServices()
            }
    }
}
