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

enum SortingAlgorithm {
    case Apple
    case Quicksort
    case BubbleSort
}

final class AlgorithmViewModel: ObservableObject {
    @Published var showIndicator = false
    @Published var sortingTime = 0.0
    @Published var timeElapsed = TimeInterval()
    
    @Published var ascendingFontColor: Color = .white
    @Published var ascendingBackgroundColor: Color = .black
    
    @Published var descendingFontColor: Color = .white
    @Published var descendingBackgroundColor: Color = .black
    
    @Published var sortingType: SortingType = .Ascending
    
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
            sortingType = .Ascending
            UserDefaults.standard.set(true, forKey: "AscendingSort")
        case .Descending:
            setButtonLayout(.Descending)
            sortingType = .Descending
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
    
    // MARK: - Apple's sorting algorithm
    func DoWork() {
        let serialQueue = DispatchQueue(label: "serialQueue")
        serialQueue.async {
            self.performSorting(count: self.count, algorithm: .BubbleSort)
        }
    }
    
    func performSorting(count: Int, algorithm: SortingAlgorithm) {
        var randomNumbers = [Int]()
        randomNumbers.reserveCapacity(count)
        
        for _ in 0..<count {
            let randomNumber = Int.random(in: 0..<100)
            randomNumbers.append(randomNumber)
            debugPrint(randomNumber)
        }
        switch algorithm {
        case .Apple:
            sortRandomIntegers(&randomNumbers)
        case .Quicksort:
            quicksort(&randomNumbers, order: sortingType)
        case .BubbleSort:
            BubbleSort(&randomNumbers)
        }
        
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
    
    // MARK: - Bubble sort algorithm
    func bubbleSort(_ array: inout [Int], order: SortingType) {
        let n = array.count
        var swapped = false
        
        repeat {
            swapped = false
            for i in 1..<n {
                let comparisonResult: Bool
                if order == sortingType {
                    comparisonResult = array[i - 1] > array[i]
                } else {
                    comparisonResult = array[i - 1] < array[i]
                }
                
                if comparisonResult {
                    array.swapAt(i - 1, i)
                    swapped = true
                }
            }
        } while swapped
    }
    
    func BubbleSort(_ array: inout [Int]) {
        let startTime = Date()
        bubbleSort(&array, order: sortingType)
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        DispatchQueue.main.async {
            self.timeElapsed = timeElapsed
        }
        debugPrint("Bubble Sort \(count) random integers took \(timeElapsed) seconds")
    }

    // MARK: - Quicksort algorithm
    func quicksort(_ array: inout [Int], low: Int, high: Int, order: SortingType) {
        if low < high {
            let pivotIndex = partition(&array, low: low, high: high, order: order)
            if pivotIndex > 0 {
                quicksort(&array, low: low, high: pivotIndex - 1, order: order)
                debugPrint(pivotIndex)
            }
            quicksort(&array, low: pivotIndex + 1, high: high, order: order)
        }
    }
    
    func partition(_ array: inout [Int], low: Int, high: Int, order: SortingType) -> Int {
        let pivot = array[high]
        var i = low - 1
        
        for j in low..<high {
            if (order == .Ascending && array[j] <= pivot) || (order == .Descending && array[j] >= pivot) {
                i += 1
                debugPrint(i)
                array.swapAt(i, j)
            }
        }
        
        array.swapAt(i + 1, high)
        return i + 1
    }
    
    func quicksort(_ array: inout [Int], order: SortingType) {
        let startTime = Date()
        quicksort(&array, low: 0, high: array.count - 1, order: order)
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        DispatchQueue.main.async {
            self.timeElapsed = timeElapsed
        }
    }
}
