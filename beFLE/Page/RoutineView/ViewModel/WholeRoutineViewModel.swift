//
//  WholeRoutineViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

enum Part: String, CaseIterable {
    case 전체, 등, 가슴, 이두, 삼두, 하체, 복근
}

class WholeRoutineViewModel: ObservableObject {
    let wholeRoutineModel = WholeRoutineModel()
    
    /// 전체 운동 목록
    @Published var wholeRoutine = ResponseGetUsersInfluencersRoutines(routines: [])
    
    /// 선택된 부위
    @Published var selectedPart: Part = .전체
    
    /// 월 별 운동 목록 
    @Published var routinesByMonth: [Int: [Int: [Routine]]] = [:]
    
    func fetch(influencerId: Int) {
        wholeRoutineModel.fetchWholeRoutine(influencerId: influencerId) { wholeRoutine in
            self.wholeRoutine = wholeRoutine
            self.parse()
        }
    }
    
    func parse() {
        routinesByMonth = wholeRoutineModel.parseByMonth(selectedPart, routines: wholeRoutine.routines)
    }
    
    func sortByMonth(routinesByMonth: [Int: [Routine]]) -> [(key: Int, value: [Routine])] {
        return routinesByMonth.sorted { $0.key > $1.key }
    }
    
    func sortByDate(routine: [Routine]) -> [Routine] {
        return routine.sorted { $0.date > $1.date }
    }
    
    func sortByYear() -> [(key: Int, value: [Int: [Routine]])] {
        return routinesByMonth.sorted { $0.key > $1.key }
    }
}
