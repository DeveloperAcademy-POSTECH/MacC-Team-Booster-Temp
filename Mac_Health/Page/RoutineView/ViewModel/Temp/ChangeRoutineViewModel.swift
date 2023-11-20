//
//  ChangeRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class ChangeRoutineViewModel: ObservableObject {
    @Published var selection = "전체"
    @Published var routines = ResponseGetUsersInfluencersRoutines(routines: [])
    @Published var monthlyroutines: [String : [Routine]] = [:]
    //date는 string으로 2023-10-24로 됨
    
    func fetchRoutines(influencerId: Int) {
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) {
            switch $0 {
            case .success(let routine):
                self.routines.routines = routine
                self.fetchMonthlyRoutines(routines: routine.self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMonthlyRoutines(routines: [Routine]) {
        for routine in routines {
            let month = routine.date.components(separatedBy: "-")[1]
            var updatedRutine: [Routine] = []
            if let influencerRoutine = monthlyroutines[month] {
                updatedRutine.append(contentsOf: influencerRoutine)
            } else {
                updatedRutine.append(routine)
            }
            monthlyroutines.updateValue(updatedRutine, forKey: month)
        }
    }
    
    func dateFormat(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    func dayFormat(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    func dateCompare(from date: String) -> Bool {
        let difference = Calendar.current.dateComponents([.day], from: date.toDate() ?? Date(), to: Date())
        if difference.day == 0 {
            return true
        } else {
            return false
        }
    }
}
