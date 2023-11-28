//
//  RoutineViewModel.swift
//  beFLE
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

class RoutineViewModel: ObservableObject {
    @Published var todayRoutines: ResponseGetUsersRoutines?
    let todayRoutineModel = TodayRoutineModel()
    
    init() {
        todayRoutineModel.fetchTodayRoutines {
            self.todayRoutines = $0
        }
    }
}
