//
//  ChangeRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI
import Moya

class ChangeRoutineViewModel: ObservableObject {
    let provider = MoyaProvider<GeneralAPI>()
    let id = 1
    
    @Published var routines = ResponseGetUsersInfluencersRoutines(routines: [])
    
    init() {
        self.fetchRoutines()
    }
    
    func fetchRoutines() {
        provider.request(.GetUsersInfluencersRoutines(id: id)) { result in
            switch result {
            case .success(let resp):
                switch resp.statusCode {
                case 200:
                    let resultData = try! JSONDecoder().decode([Routine].self, from: resp.data)
                    self.routines = ResponseGetUsersInfluencersRoutines(routines: resultData)
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
