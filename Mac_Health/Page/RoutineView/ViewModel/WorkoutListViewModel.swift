//
//  WorkoutListViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/10/23.
//

import SwiftUI

class WorkoutListViewModel: ObservableObject {
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    @Published var isDetailedWorkoutShow = false
    @Published var isConfirmationDialogShow = false
    @Published var isAlternativeWorkoutShow = false
    @Published var isAlternativeWorkoutSheetShow = false
    @Published var isDeleteAlertShow = false
    @Published var selectedExercise = -1
    
    func fetchRoutine(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.routine = routine
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
