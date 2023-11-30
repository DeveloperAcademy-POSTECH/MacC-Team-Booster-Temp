//
//  RoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/30/23.
//

import SwiftUI

struct RoutineModel {
    func fetchRoutine(routineId: Int, completion: @escaping ((ResponseGetUsersRoutinesId)->())) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                let routine: ResponseGetUsersRoutinesId = routine
                completion(routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func finishRoutine(routineId: Int, completion: @escaping ((String)->())) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesFinish(routineId: routineId), type: ResponsePatchUsersRoutinesFinish.self) {
            switch $0 {
            case .success(let routine):
                completion(routine.routineCompleteImageUrl)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
