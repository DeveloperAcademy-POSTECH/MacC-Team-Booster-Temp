//
//  RoutineViewModel.swift
//  beFLE
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

class RoutineViewModel: ObservableObject {
    @Published var todayRoutines = ResponseGetUsersRoutines(routine: [])
    
    func fetchTodayRoutines() {
        #if DEBUG
        let date = Date().toString()
        #else
        let date = Date().toString()
        #endif
        
        GeneralAPIManger.request(for: .GetUsersRoutines(date: date), type: [InfluencerRoutine].self) {
            switch $0 {
            case .success(let routines):
                self.todayRoutines.routine = routines
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
