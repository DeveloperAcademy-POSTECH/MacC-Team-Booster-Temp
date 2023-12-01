//
//  RecordingFinishViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordingFinishViewModel: ObservableObject {
    @Published var volume = 0
    @Published var totalCalories = 0
    
    func caculateWorkoutTime(elapsedTime: TimeInterval) -> String {
        let minutes = Int(elapsedTime) / 60
        
        return "\(minutes)분"
    }
    
    func caculateWorkoutVolume(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) { result in
            switch result {
            case .success(let routine):
                _ = routine.exercises.map { exercise in
                    self.fetchWorkout(routineId: routineId, exerciseId: exercise.id) { weight in
                        self.volume += weight.first ?? 0
                        self.totalCalories += weight.last ?? 0
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchWorkout(routineId: Int, exerciseId: Int, completion: @escaping (([Int]) -> Void)) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) { result in
            switch result {
            case .success(let workout):
                var volume = 0
                
                let caloriesPerSet: Double = 16.7
                var totalCalories: Double = 0
                
                _ = workout.sets.map { set in
                    if let weight = set.weight {
                        volume += set.reps * weight
                    }

                    if set.isDone {
                        totalCalories += caloriesPerSet
                    }
                }
                completion([volume, Int(totalCalories)])
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
