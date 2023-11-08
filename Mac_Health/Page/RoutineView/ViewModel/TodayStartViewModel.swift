//
//  TodayStartViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI
import Moya

class TodayStartViewModel: ObservableObject {
    let provider = MoyaProvider<GeneralAPI>()
    let id = 1
    
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    init() {
        self.fetchRoutine()
    }
    
    func fetchRoutine() {
        provider.request(.GetUsersRoutinesId(id: id)) { result in
            switch result {
            case .success(let resp):
                switch resp.statusCode {
                case 200:
                    let resultData = try! JSONDecoder().decode(ResponseGetUsersRoutinesId.self, from: resp.data)
                    self.routine = resultData
                    print(self.routine)
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
