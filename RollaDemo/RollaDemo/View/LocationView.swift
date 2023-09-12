//
//  DeviceView.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import SwiftUI
import MapKit

struct LocationView: View {
    @StateObject var viewModel = LocationViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                if viewModel.journeyStarted {
                    SpeedAndDistance()
                        .padding(.horizontal, 30)
                }
                StartStopButton()
                    .padding([.horizontal, .bottom], 30)
            }
        }
        .onAppear {
            viewModel.setupLocationServices()
        }
    }
    
    @ViewBuilder
    func StartStopButton() -> some View {
        Button {
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.journeyStarted.toggle()
                    viewModel.handleLocationUpdate()
                }
            }
        } label: {
            Text(viewModel.journeyStarted ? "Stop" : "Start")
                .font(.custom("Avenir-Medium", size: 17))
                .fontWeight(.heavy)
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(viewModel.journeyStarted ? .red : .green)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    func SpeedAndDistance() -> some View {
        HStack {
            VStack(alignment: .center) {
                Text(String(format:"%.1f", viewModel.currentSpeed))
                    .font(.custom("Avenir-Medium", size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding([.horizontal, .top], 20)
                Text("km/h")
                    .font(.custom("Avenir-Medium", size: 27))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding([.horizontal, .bottom], 20)
            }
            .background(Color(red: 30/255, green: 39/255, blue: 46/255))
            .cornerRadius(15)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(String(format:"%.2f", (viewModel.totalDistance / 1000)))
                    .font(.custom("Avenir-Medium", size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding([.horizontal, .top], 20)
                Text("km")
                    .font(.custom("Avenir-Medium", size: 27))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding([.horizontal, .bottom], 20)
            }
            .background(Color(red: 30/255, green: 39/255, blue: 46/255))
            .cornerRadius(15)
        }
    }
}
