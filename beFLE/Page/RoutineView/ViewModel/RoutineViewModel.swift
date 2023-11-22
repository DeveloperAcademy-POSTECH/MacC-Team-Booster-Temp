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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        #if DEBUG
        let date = "2023-11-22"
        #else
        let date = "2023-11-22"
//        let date = dateFormatter.string(from: Date())
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
