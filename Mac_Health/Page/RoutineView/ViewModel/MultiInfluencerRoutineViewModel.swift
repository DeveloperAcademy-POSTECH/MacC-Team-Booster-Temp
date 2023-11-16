//
//  MultiInfluencerRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/8/23.
//

import SwiftUI

class MultiInfluencerRoutineViewModel: ObservableObject {
    @Published var routines = ResponseGetUsersRoutines(routine: [])
    
    init() {
        self.fetchRoutines()
    }
    
    func fetchRoutines() {
        // TODO: date 오늘 날짜로
        let date = "2023-10-24"
        
        GeneralAPIManger.request(for: .GetUsersRoutines(date: date), type: [InfluencerRoutine].self) {
            switch $0 {
            case .success(let routines):
                self.routines.routine = routines
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
