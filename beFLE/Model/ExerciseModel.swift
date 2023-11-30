//
//  ExerciseModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/30/23.
//

import SwiftUI

struct ExerciseModel {
    func fetchExercise(routineId: Int, exerciseId: Int, completion: @escaping ((ResponseGetRoutinesExercises)->())) {
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
}
