//
//  TodayStartViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class TodayStartViewModel: ObservableObject {
    // TODO: 데이터 바인딩 수정
    @Published var routines = ResponseGetUsersRoutines(routines: [])
    @Published var routine: InfluencerRoutine = InfluencerRoutine(routineId: 0, part: "", date: "", numberOfExercise: 0, burnedKCalories: 0, requiredMinutes: 0, comment: "", name: "", routineName: "", influencerProfileImageUrl: "", influencerId: 0)
    
    init() {
        self.fetchRoutines()
    }
    
    func fetchRoutines() {
        // TODO: date 오늘 날짜로
        let date = "2023-10-30"
        
        GeneralAPIManger.request(for: .GetUsersRoutines(date: date), type: [InfluencerRoutine].self) {
            switch $0 {
            case .success(let routines):
                self.routine = routines.first!
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
