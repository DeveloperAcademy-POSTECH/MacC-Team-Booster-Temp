//
//  SelectedRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class SelectedRoutineViewModel: ObservableObject {
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    func fetchRoutine(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.routine = routine
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
