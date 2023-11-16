//
//  WholeRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class WholeRoutineViewModel: ObservableObject {
    // TODO: 루틴 모델 변경
    /// 전체 루틴 목록
    @Published var routines = ResponseGetUsersInfluencersRoutines(routines: [])
    
    /// 선택된 부위
    @Published var selectedPart = "전체"
    
    /// 월 별 운동 목록
//    @Published var routinesByMonth: [String : [Routine]] = [:]
    
    
    /// 전체 루틴 조회 함수
    func fetchWholeRoutine(influencerId: Int, completion: @escaping ([Routine]) -> ()) {
        var wholeRoutine: [Routine] = []
        
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) {
            switch $0 {
            case .success(let routine):
                wholeRoutine = routine
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            return completion(wholeRoutine)
        }
    }
    
    
    /// 루틴 월 별 분류 함수
    func fetchByMonth(routines: [Routine]) -> [String : [Routine]] {
        var routinesByMonth: [String : [Routine]] = [:]
        
        for routine in routines {
            let month = routine.date.components(separatedBy: "-")[1]
            var updatedRoutine: [Routine] = []
            
            if let parsedRoutine = routinesByMonth[month] {
                updatedRoutine.append(contentsOf: parsedRoutine)
            } else {
                updatedRoutine.append(routine)
            }
            
            routinesByMonth.updateValue(updatedRoutine, forKey: month)
        }
        
        return routinesByMonth
    }
    
    /// "2023-10-24"를 "10월 24일"로 전환해주는 함수
    func formatForDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    /// "2023-10-24"를 "24"로 전환해주는 함수
    func formatForDay(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    /// 전달 받은 "2023-10-24"가 오늘 날짜인지 검사하는 함수
    func compareToday(from date: String) -> Bool {
        let difference = Calendar.current.dateComponents([.day], from: date.toDate() ?? Date(), to: Date())
        if difference.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    /// 루틴 부위 별 분류 함수
    func fetchByPart() {
        // TODO: 부위 별 루틴 분류
    }
    
    /// 루틴 상세 정보 네비게이션 용 함수
    func viewDetailedRoutine() {
        // TODO: 선택한 루틴 상세 정보 보기
    }
}
