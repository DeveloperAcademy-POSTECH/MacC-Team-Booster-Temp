//
//  MockUpStopwatchViewModel.swift
//  beFLE
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

class MockUpStopwatchViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
    @Published private var startTime = Date.now
    private var timer: Timer?
    
    func Start() {
        isRunning = true
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func Stop() {
        isRunning = false
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func bgTimer() -> TimeInterval {
        let curTime = Date.now
        let diffTime = startTime.distance(to: curTime)
        let result = Double(diffTime.formatted())!
        elapsedTime = result + elapsedTime
        
        return elapsedTime
    }
    
}
