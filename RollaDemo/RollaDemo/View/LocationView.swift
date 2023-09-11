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
        GeometryReader { proxy in
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            .ignoresSafeArea(.all)
            
            VStack {
                // MARK: App logo, I'm out status, Search
//                LocationTopElements(showLocation: $viewModel.showLocation, title: $viewModel.currentLocationStatus, viewModel: viewModel)
                
                Spacer()
                
                // MARK: Location preview
//                if viewModel.showLocation {
//                    withAnimation(.spring()) {
//                        //                        LocationPreviewView(place: $viewModel.selectedPlace, showVenueView: $viewModel.showVenueView)
//                        LocationPreviewView(place: $viewModel.selectedPlace, showLocation: $viewModel.showLocation)
//                            .padding([.leading, .trailing], 10)
//                            .padding(.bottom, 25)
//                    }
//                }
            }
        }
        .onAppear {
            viewModel.setupLocationServices()
        }
    }
}
