//
//  AlgorithmViewModel.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import Combine

final class AlgorithmViewModel: ObservableObject {
    @Published var showIndicator = false
    @Published var sortingTime = 0.0
    @Published var timeElapsed = TimeInterval()
    let count = 25_000_000

    func DoWork() {
        let serialQueue = DispatchQueue(label: "serialQueue")
        serialQueue.async {
            self.generateRandomIntegers(count: self.count)
//            self.sortRandomIntegers()
        }
    }
    
    // Generate a collection of 25 million random integers
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
    
    // Sort the collection using Swift's built-in sort() method
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
