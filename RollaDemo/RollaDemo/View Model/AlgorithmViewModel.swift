//
//  AlgorithmViewModel.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import Combine
import SwiftUI

enum SortingType {
    case Ascending
    case Descending
}

final class AlgorithmViewModel: ObservableObject {
    @Published var showIndicator = false
    @Published var sortingTime = 0.0
    @Published var timeElapsed = TimeInterval()
    
    @Published var ascendingFontColor: Color = .white
    @Published var ascendingBackgroundColor: Color = .black
    
    @Published var descendingFontColor: Color = .white
    @Published var descendingBackgroundColor: Color = .black
    
    let count = 25_000_000

    init() {
        if UserDefaults.standard.bool(forKey: "AscendingSort") {
            setSortingType(.Ascending)
        } else {
            setSortingType(.Descending)
        }
    }
    
    func setSortingType(_ type: SortingType) {
        switch type {
        case .Ascending:
            setButtonLayout(.Ascending)
            UserDefaults.standard.set(true, forKey: "AscendingSort")
        case .Descending:
            setButtonLayout(.Descending)
            UserDefaults.standard.set(false, forKey: "AscendingSort")
        }
    }
    
    private func setButtonLayout(_ type: SortingType) {
        switch type {
        case .Ascending:
            ascendingFontColor = .black
            ascendingBackgroundColor = .green
            descendingFontColor = .white
            descendingBackgroundColor = .black
        case .Descending:
            ascendingFontColor = .white
            ascendingBackgroundColor = .black
            descendingFontColor = .black
            descendingBackgroundColor = .green
        }
    }
    
    func DoWork() {
        let serialQueue = DispatchQueue(label: "serialQueue")
        serialQueue.async {
            self.generateRandomIntegers(count: self.count)
        }
    }
    
    func generateRandomIntegers(count: Int) {
        var randomNumbers = [Int]()
        randomNumbers.reserveCapacity(count)
        
        for _ in 0..<count {
            let randomNumber = Int.random(in: 0..<10)
            randomNumbers.append(randomNumber)
            debugPrint(randomNumber)
        }
        sortRandomIntegers(&randomNumbers)
        DispatchQueue.main.async {
            self.showIndicator.toggle()
        }
    }
    
    func sortRandomIntegers(_ numbers: inout [Int]) {
        let startTime = Date()
        numbers.sort()
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        DispatchQueue.main.async {
            self.timeElapsed = timeElapsed
        }
        debugPrint("Sorting \(count) random integers took \(timeElapsed) seconds")
    }
}
