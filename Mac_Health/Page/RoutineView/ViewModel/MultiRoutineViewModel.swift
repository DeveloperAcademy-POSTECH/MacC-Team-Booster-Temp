//
//  MultiRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/8/23.
//

import SwiftUI

class MultiRoutineViewModel: ObservableObject {
    @Published var routines = ResponseGetUsersRoutines(routines: [])
    
    init() {
        self.fetchRoutines()
    }
    
    func fetchRoutines() {
        let date = "2023-10-30"
        
        GeneralAPIManger.request(for: .GetUsersRoutines(date: date), type: [InfluencerRoutine].self) {
            switch $0 {
            case .success(let routine):
                self.routines.routines = routine
                print(self.routines)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
