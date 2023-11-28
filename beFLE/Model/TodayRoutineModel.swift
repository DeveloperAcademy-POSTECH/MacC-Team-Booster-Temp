//
//  TodayRoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/28/23.
//

import SwiftUI

struct TodayRoutineModel {
    func fetchTodayRoutines(completion: @escaping ((ResponseGetUsersRoutines)->())) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.string(from: Date())
        
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
