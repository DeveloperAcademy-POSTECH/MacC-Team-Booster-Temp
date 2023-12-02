//
//  RoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/30/23.
//

import SwiftUI

struct RoutineModel {
    func fetchRoutine(routineId: Int, completion: @escaping ((ResponseGetUsersRoutinesId) -> Void)) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) { result in
            switch result {
            case .success(let routine):
                let routine: ResponseGetUsersRoutinesId = routine
                completion(routine)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func finishRoutine(routineId: Int, completion: @escaping ((String) -> Void)) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesFinish(routineId: routineId), type: ResponsePatchUsersRoutinesFinish.self) { result in
            switch result {
            case .success(let routine):
                completion(routine.routineCompleteImageUrl)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
