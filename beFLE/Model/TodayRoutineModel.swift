//
//  TodayRoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/28/23.
//

import SwiftUI

struct TodayRoutineModel {
    /// 인플루언서별 오늘 운동 목록을 불러오는 함수
    func fetchTodayRoutines(_ completion: @escaping ((ResponseGetUsersRoutines) -> ())) {
        #if DEBUG
        let date = "2023-11-22"
        #else
        let date = Date().format(.yearMonthToday)
        #endif
        
        GeneralAPIManger.request(for: .GetUsersRoutines(date: date), type: [InfluencerRoutine].self) {
            switch $0 {
            case .success(let routine):
                let todayRoutine = ResponseGetUsersRoutines(routine: routine)
                completion(todayRoutine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
