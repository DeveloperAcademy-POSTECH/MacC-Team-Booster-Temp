//
//  PauseStopwatchVM.swift
//  beFLE
//
//  Created by 정회승 on 11/10/23.
//

import SwiftUI

class PauseStopwatchVM: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
    @Published private var startTime = Date.now
    private var timer: Timer?
    
    
    func timerStart() {
        if !isRunning {
            isRunning = true
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.isRunning {
                    self.elapsedTime += 1
                    print(self.elapsedTime)
                }
                else {
                    timer.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    
    func timerStop() {
        isRunning = false
    }
    
    func reset() {
        elapsedTime = 0
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func bgTimer() -> TimeInterval {
        let curTime = Date.now
        let diffTime = startTime.distance(to: curTime)
        let result = Double(diffTime.formatted())!
        elapsedTime = result + elapsedTime
        
        return elapsedTime
    }
}
