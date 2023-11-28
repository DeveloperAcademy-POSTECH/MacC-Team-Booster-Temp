//
//  SingleInfluencerRoutineViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class SingleInfluencerRoutineViewModel: ObservableObject {
    /// "2023-10-24"를 "10월 24일 월요일"로 전환해주는 함수
    func formatForDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 EEEE"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
}
