//
//  DetailedWorkoutSheetViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/13/23.
//

import SwiftUI

class DetailedWorkoutSheetViewModel: ObservableObject {
    @Published var exercise = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [])
    
    func fetchExercise(routineId: Int, exerciseId: Int) {
        print(routineId, exerciseId)
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let exercise):
                self.exercise = exercise
                print(self.exercise)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
