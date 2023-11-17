//
//  DetailedWorkoutSheetViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/13/23.
//

import SwiftUI

class DetailedWorkoutSheetViewModel: ObservableObject {
    @Published var workout = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    
    func fetchWorkout(routineId: Int, exerciseId: Int) {
        print(routineId, exerciseId)
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let workout):
                self.workout = workout
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
