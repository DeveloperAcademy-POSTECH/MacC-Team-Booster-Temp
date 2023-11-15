//
//  SingleInfluencerRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class SingleInfluencerRoutineViewModel: ObservableObject {
    // TODO: isDone 작업 이후 제거
    //오늘 운동 했는지
    @Published var finishWorkout: Bool = false
    
    /// "2023-10-24"를 "10월 24일 월요일"로 전환해주는 함수
    func formatForDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 EEEE"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    /// 운동 시작 네비게이션 용
    func startWorkout(routine: String) {
        // TODO: 네비게이션으로 데이터 전달, routine 모델 변경하기
    }
    
    /// 달력 버튼 네비게이션 용 전체 운동 보기
    func viewWholeWorkout(influencerId: Int) {
        // TODO: 네비게이션으로 인플루언서 아이디 전달
    }
}
