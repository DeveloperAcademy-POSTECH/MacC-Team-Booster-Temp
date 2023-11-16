//
//  AlternativeWorkoutSheetViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/14/23.
//

import SwiftUI

class AlternativeWorkoutSheetViewModel: ObservableObject {
    @Published var selection = -1
    
    func patchAlternate(routineId: Int, exerciseId: Int, alternativeExerciseId: Int, completion: @escaping ((ResponseGetRoutinesExercises) -> ())) {
        GeneralAPIManger.request(for: .PatchRoutinesExercisesAlternate(routineId: routineId, exerciseId: exerciseId, alternativeExerciseId: alternativeExerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let routine):
                completion(routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
