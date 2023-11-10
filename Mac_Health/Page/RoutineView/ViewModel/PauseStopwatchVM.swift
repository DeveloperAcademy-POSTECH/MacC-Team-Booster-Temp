//
//  PauseStopwatchVM.swift
//  Mac_Health
//
//  Created by 정회승 on 11/10/23.
//

import SwiftUI

class PauseStopwatchVM: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
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
    
    func reset() {
            elapsedTime = 0
            isRunning = false
            timer?.invalidate()
            timer = nil
        }
}
