//
//  HomeView.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 10. 9. 2023..
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case BLE = "dot.radiowaves.left.and.right"
    case Location = "location.fill.viewfinder"
    case Algorithm = "cpu"
}

struct TabBarView: View {
    @State private var currentTab: Tab = .BLE
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                BLEView()
                    .environment(\.locale, .init(identifier: "en"))
                    .tag(Tab.BLE)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                LocationView()
                    .environment(\.locale, .init(identifier: "en"))
                    .tag(Tab.Location)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                AlgorithmView()
                    .environment(\.locale, .init(identifier: "en"))
                    .tag(Tab.Algorithm)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
            .accentColor(.black)
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        // add shadow at background
                            .background(
                                Color(red: 94/255, green: 78/255, blue: 203/255)
//                                    .opacity(0.8)
                                    .cornerRadius(10)
                                // blurring
//                                    .blur(radius: 5)
                                    .padding([.leading, .trailing], -20)
                                    .padding([.top, .bottom], -10)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color(.white) : Color.white.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding([.top, .bottom], 10)
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
        .background(Color(red: 67/255, green: 47/255, blue: 191/255))
    }
}
