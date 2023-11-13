//
//  AlternativeWorkoutSheetViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/14/23.
//

import SwiftUI

class AlternativeWorkoutSheetViewModel: ObservableObject {
    @Published var selection = -1
    
    func patchAlternate(routineId: Int, exerciseId: Int, alternativeExerciseId: Int) {
        // TODO: 성공 시 dismiss
        GeneralAPIManger.request(for: .PatchRoutinesExercisesAlternate(routineId: routineId, exerciseId: exerciseId, alternativeExerciseId: alternativeExerciseId), type: ResponsePatchRoutinesExercisesAlternate.self) {
            switch $0 {
            case .success(let routine):
                print(routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
