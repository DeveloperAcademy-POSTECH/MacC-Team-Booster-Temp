//
//  DetailedWorkoutSheetViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/13/23.
//

import SwiftUI

class DetailedWorkoutSheetViewModel: ObservableObject {
    @Published var exercise = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    
    func fetchexercise(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let exercise):
                self.exercise = exercise
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
