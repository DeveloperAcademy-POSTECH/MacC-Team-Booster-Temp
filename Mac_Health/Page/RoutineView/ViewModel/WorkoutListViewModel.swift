//
//  WorkoutListViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/10/23.
//

import SwiftUI

class WorkoutListViewModel: ObservableObject {
//    @Published var routine = ResponseGetUsersRoutinesId()
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    init() {
        self.fetchRoutine()
    }
    
    func fetchRoutine() {
        let id = 1
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: id), type: ResponseGetUsersRoutinesId.self) {
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
