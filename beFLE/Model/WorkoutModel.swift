//
//  WorkoutModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/30/23.
//

import SwiftUI

struct WorkoutModel {
    func fetchWorkout(routineId: Int, exerciseId: Int, completion: @escaping ((ResponseGetRoutinesExercises) -> Void)) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) { result in
            switch result {
            case .success(let exercise):
                let exercise: ResponseGetRoutinesExercises = exercise
                completion(exercise)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWorkout(routineId: Int, exerciseId: Int, completion: @escaping (() -> Void)) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId)) { result in
            switch result {
            case .success:
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func decreaseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> Void)) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) { result in
            switch result {
            case .success(let sets):
                completion(sets)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func increseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> Void)) {
        GeneralAPIManger.request(for: .PostRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) { result in
            switch result {
            case .success(let sets):
                completion(sets)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func editWeight(routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> Void)) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) { result in
            switch result {
            case .success(let set):
                completion(set)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func editReps(routineId: Int, exerciseId: Int, setId: Int, weight: Int? = nil, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> Void)) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) { result in
            switch result {
            case .success(let set):
                completion(set)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fisishSet(routineId: Int, exerciseId: Int, setId: Int, completion: @escaping (() -> Void)) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSetsFinish(routineId: routineId, exerciseId: exerciseId, setId: setId), type: ResponsePatchUsersRoutinesExercisesSetsFinish.self) { result in
            switch result {
            case .success:
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
