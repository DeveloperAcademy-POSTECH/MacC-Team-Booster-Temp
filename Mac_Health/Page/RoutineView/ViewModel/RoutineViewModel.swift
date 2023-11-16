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
    @Published var wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: [])

    /// 월 별 운동 목록
    @Published var routinesByMonth: [String : [Routine]] = [:]
    
    init() {
        self.fetchTodayRoutines()
        self.tempfetcher()
    }
    
    func fetchTodayRoutines() {
        // TODO: date 오늘 날짜로
        #if DEBUG
        let date = "2023-11-16"
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
    
    @Published var RoutineViewRoutine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    @Published var RecordingRoutineViewRoutine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    @Published var isDetailedWorkoutSheetShow = false
    
    func tempfetcher() {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: 2), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.RoutineViewRoutine = routine
                self.RecordingRoutineViewRoutine = routine
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
