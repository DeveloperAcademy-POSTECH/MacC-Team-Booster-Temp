//
//  WholeRoutineViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class WholeRoutineViewModel: ObservableObject {
    /// 선택된 부위
    @Published var selectedPart = "전체"
    
    /// 월 별 운동 목록 [월: [루틴]]
    @Published var routinesByMonth: [String: [Routine]] = [:]
    
    ///최초 네트워킹으로 받은 전체 목록
    @Published var wholeRoutines: [Routine] = []
    
    @Published var wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: [])
    let wholeRoutineModel = WholeRoutineModel()
    
    func fetch(influencerId: Int) {
        wholeRoutineModel.fetchWholeRoutine(influencerId: influencerId) {
            self.wholeRoutine = $0
        }
    }
    
    /// 전체 루틴 조회 함수
    func fetchWholeRoutine(influencerId: Int) {
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) {
            switch $0 {
            case .success(let routine):
                self.routinesByMonth = self.fetchByMonth(routines: routine)
                self.wholeRoutines = routine
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchBySelect() {
        routinesByMonth = fetchByMonth(routines: wholeRoutines)
    }
    
    /// 파트 별 루틴 월 별 분류 함수
    func fetchByMonth(routines: [Routine]) -> [String: [Routine]] {
        var routinesByMonth: [String: [Routine]] = [:]
        
        if selectedPart == "전체" {
            for routine in routines {
                let month = routine.date.components(separatedBy: "-")[1]
                
                if routinesByMonth[month] != nil {
                    routinesByMonth[month]?.append(routine)
                }
                else {
                    routinesByMonth.updateValue([routine], forKey: month)
                }
            }
        }
        else {
            for routine in routines {
                if routine.part.contains(selectedPart) {
                    let month = routine.date.components(separatedBy: "-")[1]
                    
                    if routinesByMonth[month] != nil {
                        routinesByMonth[month]?.append(routine)
                    }
                    else {
                        routinesByMonth.updateValue([routine], forKey: month)
                    }
                }
            }
        }
        
        return routinesByMonth
    }
}
