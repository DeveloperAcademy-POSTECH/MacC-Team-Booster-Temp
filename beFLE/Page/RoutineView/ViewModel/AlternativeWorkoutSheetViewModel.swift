//
//  AlternativeWorkoutSheetViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/14/23.
//

import SwiftUI

class AlternativeWorkoutSheetViewModel: ObservableObject {
    @Published var selection = -1
    
    @Published var workout = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    
    func fetchWorkout(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let workout):
                self.workout = workout
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func patchAlternate(routineId: Int, exerciseId: Int, alternativeExerciseId: Int, completion: @escaping (() -> ())) {
        GeneralAPIManger.request(for: .PatchRoutinesExercisesAlternate(routineId: routineId, exerciseId: exerciseId, alternativeExerciseId: alternativeExerciseId)) {
            switch $0 {
            case .success:
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
