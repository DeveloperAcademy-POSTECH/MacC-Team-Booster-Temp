//
//  RecordSpecificViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordSpecificViewModel: ObservableObject {
    func caculatelTotalVolume(workouts: [RecordedExercise]) -> String {
        let totalVolume = workouts.reduce(0) { partialResult, workout in
            partialResult + workout.sets.reduce(0) { partialResult, set in
                partialResult + (set.weight ?? 0) * set.reps
            }
        }
        
        return String(totalVolume)
    }
    
    func caculateVolume(sets: [RecordedSet]) -> String {
        let volume = sets.reduce(0) { partialResult, set in
            partialResult + (set.weight ?? 0) * set.reps
        }
        
        return String(volume)
    }
    
    func timeFormat(from time: String) -> String {
        let split = time.split(separator: ":")
        let hour = Int(split[0])!
        let miniute = Int(split[1])!
        let second = Int(split[2])!
        
        return "\(hour)시간 \(miniute)분 \(second)초"
    }
}
