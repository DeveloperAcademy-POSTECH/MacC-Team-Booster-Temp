//
//  RoutineViewModel.swift
//  beFLE
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

class RoutineViewModel: ObservableObject {
    @Published var todayRoutines = ResponseGetUsersRoutines(routine: [])
    let todayRoutineModel = TodayRoutineModel()
    
    func fetch() {
        todayRoutineModel.fetchTodayRoutines { todayRoutines in
            self.todayRoutines = todayRoutines
        }
    }
}
