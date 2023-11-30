//
//  WorkoutModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/30/23.
//

import SwiftUI

struct WorkoutModel {
    func fetchWorkout(routineId: Int, exerciseId: Int, completion: @escaping ((ResponseGetRoutinesExercises)->())) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let exercise):
                let exercise: ResponseGetRoutinesExercises = exercise
                completion(exercise)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWorkout(routineId: Int, exerciseId: Int, completion: @escaping (() -> ())) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId)) {
            switch $0 {
            case .success:
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func decreaseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> ())) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let sets):
                completion(sets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func increseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> ()) ) {
        GeneralAPIManger.request(for: .PostRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let sets):
                completion(sets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
