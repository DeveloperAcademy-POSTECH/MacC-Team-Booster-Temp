//
//  RoutineInformationViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class RoutineInformationViewModel: ObservableObject {
    let routineModel = RoutineModel()
    /// 루틴 목록
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    /// 루틴 정보 조회 함수
    func fetch(routineId: Int) {
        routineModel.fetchRoutine(routineId: routineId) {
            self.routine = $0
        }
    }
}
