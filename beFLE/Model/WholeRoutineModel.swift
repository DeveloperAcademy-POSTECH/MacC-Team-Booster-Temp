//
//  WholeRoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/29/23.
//

import SwiftUI

struct WholeRoutineModel {
    func fetchWholeRoutine(influencerId: Int, completion: @escaping ((ResponseGetUsersInfluencersRoutines)->()) ) {
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) {
            switch $0 {
            case .success(let routine):
                var wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: routine)
                completion(wholeRoutine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
