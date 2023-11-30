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
    
    func deleteWorkout(routineId: Int, exerciseId: Int, completion: @escaping (() -> ())) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId)) {
            switch $0 {
            case .success:
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
