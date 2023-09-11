//
//  ProfileView.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import SwiftUI

struct AlgorithmView: View {
    @StateObject var viewModel = AlgorithmViewModel()
    
    var body: some View {
        VStack {
            if viewModel.showIndicator {
                Spacer()
                HStack {
                    Spacer()
                    LottieView(lottieFile: "loading")
                        .frame(width: 300, height: 300)
                    Spacer()
                }
                Spacer()
            } else {
                Spacer()
                Text("Sorting 25 000 000 random integers took \(String(format:"%.2f", viewModel.timeElapsed)) seconds")
                    .font(.custom("Avenir-Medium", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Spacer()
                GenerateButton()
                    .padding([.horizontal, .bottom], 30)
            }
        }
        //        rgb(206, 214, 224)
        .background(Color(red: 206/255, green: 214/255, blue: 224/255))
    }
    
    @ViewBuilder
    func GenerateButton() -> some View {
        Button {
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.DoWork()
                    viewModel.showIndicator.toggle()
                }
            }
        } label: {
            Text("Generate")
                .font(.custom("Avenir-Medium", size: 17))
                .fontWeight(.heavy)
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.green)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .foregroundColor(.white)
        }
    }
}
