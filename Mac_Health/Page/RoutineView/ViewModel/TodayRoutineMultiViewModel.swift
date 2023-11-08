//
//  TodayRoutineMultiViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/8/23.
//

import SwiftUI
import Moya

class TodayRoutineMultiViewModel: ObservableObject {
    let provider = MoyaProvider<GeneralAPI>()
    let date = "2023-10-30"
    
    @Published var routines = ResponseGetUsersRoutines(routines: [])
    
    init() {
        self.fetchRoutines()
    }
    
    func fetchRoutines() {
        provider.request(.GetUsersRoutines(date: date)) { result in
            switch result {
            case .success(let resp):
                switch resp.statusCode {
                case 200:
                    let resultData = try! JSONDecoder().decode([InfluencerRoutine].self, from: resp.data)
                    self.routines = ResponseGetUsersRoutines(routines: resultData)
                    print(self.routines)
                default:
                    print("Status Code: \(resp.statusCode)")
                    break
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
