//
//  WholeRoutineModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/29/23.
//

import SwiftUI

struct WholeRoutineModel {
    /// 인플루언서의 모든 운동 목록을 불러오는 함수
    func fetchWholeRoutine(influencerId: Int, completion: @escaping ((ResponseGetUsersInfluencersRoutines) -> Void)) {
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) { result in
            switch result {
            case .success(let routine):
                let wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: routine)
                completion(wholeRoutine)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 목록을 부위, 월 별로 분류하는 함수 [ 월: [ 루틴 ]]
    func parseByMonth(_ part: Part, routines: [Routine]) -> [Int: [Int: [Routine]]] {
        var routinesByYear: [Int: [Int: [Routine]]] = [:]
        
        for routine in routines {
            var routinesByMonth: [Int: [Routine]] = [:]
            
            if part == .전체 || routine.part.contains(part.rawValue) {
                let year = Int(routine.date.components(separatedBy: "-")[0])!
                let month = Int(routine.date.components(separatedBy: "-")[1])!
                
                if let routines = routinesByYear[year] {
                    routinesByMonth = routines
                    
                    if routinesByMonth[month] != nil {
                        routinesByMonth[month]?.append(routine)
                    }
                    else {
                        routinesByMonth.updateValue([routine], forKey: month)
                    }
                    
                    routinesByYear[year]? = routinesByMonth
                }
                else {
                    routinesByMonth.updateValue([routine], forKey: month)
                    routinesByYear.updateValue(routinesByMonth, forKey: year)
                }
            }
        }
        
        return routinesByYear
    }
}
