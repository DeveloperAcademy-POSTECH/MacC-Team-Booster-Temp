//
//  ChangeRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class ChangeRoutineViewModel: ObservableObject {
    // TODO: 데이트 포매터로 운동 일 수 파싱
    @Published var routines = ResponseGetUsersInfluencersRoutines(routines: [])
    
    init() {
        self.fetchRoutines()
    }
    
    func fetchRoutines() {
        let id = 1
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: id), type: [Routine].self) {
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
