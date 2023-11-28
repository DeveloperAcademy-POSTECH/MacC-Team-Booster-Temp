//
//  WholeRoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/29/23.
//

import SwiftUI

struct WholeRoutineModel {
    /// 인플루언서의 모든 운동 목록을 불러오는 함수
    func fetchWholeRoutine(influencerId: Int, completion: @escaping ((ResponseGetUsersInfluencersRoutines)->()) ) {
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) {
            switch $0 {
            case .success(let routine):
                let wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: routine)
                completion(wholeRoutine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
