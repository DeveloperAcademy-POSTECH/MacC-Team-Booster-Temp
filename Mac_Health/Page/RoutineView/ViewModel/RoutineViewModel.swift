//
//  RoutineViewModel.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

class RoutineViewModel: ObservableObject {
    // TODO: 데이터 모델명 리네임
    @Published var routines = ResponseGetUsersRoutines(routines: [])
    init() {
        self.fetchRoutines()
        self.tempfetcher()
    }
    
    func fetchRoutines() {
        // TODO: date 오늘 날짜로
        let date = "2023-11-15"
        
        GeneralAPIManger.request(for: .GetUsersRoutines(date: date), type: [InfluencerRoutine].self) {
            switch $0 {
            case .success(let routines):
                self.routines.routines = routines
                print(self.routines)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @Published var RoutineViewRoutine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    @Published var RecordingRoutineViewRoutine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    func tempfetcher() {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: 2), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.RoutineViewRoutine = routine
                self.RecordingRoutineViewRoutine = routine
                print(self.RoutineViewRoutine)
                print(self.RecordingRoutineViewRoutine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
