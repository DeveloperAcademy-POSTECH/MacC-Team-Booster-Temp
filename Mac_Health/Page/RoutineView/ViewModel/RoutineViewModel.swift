//
//  RoutineViewModel.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

class RoutineViewModel: ObservableObject {
    // TODO: 데이터 모델명 리네임
    @Published var todayRoutines = ResponseGetUsersRoutines(routine: [])
    
    init() {
        self.fetchTodayRoutines()
    }
    
    func fetchTodayRoutines() {
        #if DEBUG
        let date = "2023-11-17"
        #else
        let date = Date()
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
